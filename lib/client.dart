import 'dart:async';
import 'dart:convert';

import 'package:dart_twitter_api/src/utils/date_utils.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:faker/faker.dart';
import 'package:ffcache/ffcache.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/utils/cache.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:quiver/iterables.dart';

const Duration _defaultTimeout = Duration(seconds: 10);
const String _bearerToken =
    'Bearer AAAAAAAAAAAAAAAAAAAAAPYXBAAAAAAACLXUNDekMxqa8h%2F40K4moUkGsoc%3DTYfbDKbT3jJPCEVnMYqilB28NHfOPqkca3qaAxGfsyKCs0wRbw';

class _FritterTwitterClient extends TwitterClient {
  static final log = Logger('_FritterTwitterClient');

  _FritterTwitterClient() : super(consumerKey: '', consumerSecret: '', token: '', secret: '');

  static Object? _token;
  static int _expiresAt = -1;
  static int _tokenLimit = -1;
  static int _tokenRemaining = -1;

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers, Duration? timeout}) {
    return fetch(uri, headers: headers).timeout(timeout ?? _defaultTimeout).then((response) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return Future.error(HttpException(response));
      }
    });
  }

  static Future<Object> getToken() async {
    if (_token != null) {
      // If we don't have an expiry or limit, it's probably because we haven't made a request yet, so assume they're OK
      if (_expiresAt == -1 && _tokenLimit == -1 && _tokenRemaining == -1) {
        // TODO: Null safety with concurrent threads
        return _token!;
      }

      // Check if the token we have hasn't expired yet
      if (DateTime.now().millisecondsSinceEpoch < _expiresAt) {
        // Check if the token we have still has usages remaining
        if (_tokenRemaining < _tokenLimit) {
          // TODO: Null safety with concurrent threads
          return _token!;
        }
      }
    }

    // Otherwise, fetch a new token
    _token = null;
    _tokenLimit = -1;
    _tokenRemaining = -1;
    _expiresAt = -1;

    log.info('Refreshing the Twitter token');

    var response = await http.post(Uri.parse('https://api.twitter.com/1.1/guest/activate.json'), headers: {
      'authorization': _bearerToken,
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result.containsKey('guest_token')) {
        _token = result['guest_token'];

        return _token!;
      }
    }

    throw Exception(
        'Unable to refresh the token. The response (${response.statusCode}) from Twitter was: ' + response.body);
  }

  static Future<http.Response> fetch(Uri uri, {Map<String, String>? headers}) async {
    log.info('Fetching $uri');

    var response = await http.get(uri, headers: {
      ...?headers,
      'authorization': _bearerToken,
      'x-guest-token': (await getToken()).toString(),
      'x-twitter-active-user': 'yes',
      'user-agent': faker.internet.userAgent()
    });

    var headerRateLimitReset = response.headers['x-rate-limit-reset'];
    var headerRateLimitRemaining = response.headers['x-rate-limit-remaining'];
    var headerRateLimitLimit = response.headers['x-rate-limit-limit'];

    if (headerRateLimitReset == null || headerRateLimitRemaining == null || headerRateLimitLimit == null) {
      // If the rate limit headers are missing, the endpoint probably doesn't send them back
      return response;
    }

    // Update our token's rate limit counters
    _expiresAt = int.parse(headerRateLimitReset) * 1000;
    _tokenRemaining = int.parse(headerRateLimitRemaining);
    _tokenLimit = int.parse(headerRateLimitLimit);

    return response;
  }
}

class Twitter {
  static final TwitterApi _twitterApi = TwitterApi(client: _FritterTwitterClient());

  static final FFCache _cache = FFCache();

  static Map<String, String> defaultParams = {
    'include_profile_interstitial_type': '0',
    'include_blocking': '0',
    'include_blocked_by': '0',
    'include_followed_by': '0',
    'include_mute_edge': '0',
    'include_can_dm': '0',
    'include_can_media_tag': '1',
    'skip_status': '1',
    'cards_platform': 'Web-12',
    'include_cards': '1',
    'include_composer_source': 'false',
    'include_ext_alt_text': 'true',
    'include_reply_count': '1',
    'tweet_mode': 'extended',
    'include_entities': 'true',
    'include_user_entities': 'true',
    'include_ext_media_color': 'false',
    'include_ext_media_availability': 'true',
    'send_error_codes': 'true',
    'simple_quoted_tweet': 'true',
    'ext': 'mediaStats',
    'include_quote_count': 'true'
  };

  static Future<User> getProfile(String username) async {
    var uri = Uri.https('twitter.com', '/i/api/graphql/Vf8si2dfZ1zmah8ePYPjDQ/UserByScreenNameWithoutResults', {
      'variables': jsonEncode({'screen_name': username, 'withHighlightedLabel': true})
    });

    var response = await _twitterApi.client.get(uri);
    var content = jsonDecode(response.body) as Map<String, dynamic>;

    var hasErrors = content.containsKey('errors');
    if (hasErrors && content['errors'] != null) {
      var errors = List.from(content['errors']);
      if (errors.isEmpty) {
        throw TwitterError(code: 0, message: 'Unknown error');
      } else {
        throw TwitterError(code: errors.first['code'], message: errors.first['message']);
      }
    }

    return User.fromJson({...content['data']['user']['legacy'], 'id_str': content['data']['user']['rest_id']});
  }

  static Future<Follows> getProfileFollows(String screenName, String type, {int? cursor, int? count = 200}) async {
    var response = type == 'following'
        ? await _twitterApi.userService
            .friendsList(screenName: screenName, cursor: cursor, count: count, skipStatus: true)
        : await _twitterApi.userService
            .followersList(screenName: screenName, cursor: cursor, count: count, skipStatus: true);

    return Follows(
        cursorBottom: int.parse(response.nextCursorStr ?? '-1'),
        cursorTop: int.parse(response.previousCursorStr ?? '-1'),
        users: response.users ?? []);
  }

  static List<TweetChain> createTweetChains(dynamic globalTweets, dynamic globalUsers, dynamic instructions) {
    List<TweetChain> replies = [];

    for (var entry in instructions[0]['addEntries']['entries']) {
      var entryId = entry['entryId'] as String;
      if (entryId.startsWith('tweet-')) {
        var id = entry['content']['item']['content']['tweet']['id'];

        replies.add(TweetChain(
            id: id,
            tweets: [TweetWithCard.fromCardJson(globalTweets, globalUsers, globalTweets[id])],
            isPinned: false));
      }

      if (entryId.startsWith('cursor-bottom') || entryId.startsWith('cursor-showMore')) {
        // TODO: Use as the "next page" cursor
      }

      if (entryId.startsWith('conversationThread')) {
        List<TweetWithCard> tweets = [];

        for (var item in entry['content']['item']['content']['conversationThread']['conversationComponents']) {
          var tweet = item['conversationTweetComponent']['tweet'];

          var content = tweet as Map<String, dynamic>;
          if (content.containsKey('tombstone')) {
            tweets.add(TweetWithCard.tombstone(content['tombstone']['tombstoneInfo']));
          } else {
            tweets.add(TweetWithCard.fromCardJson(globalTweets, globalUsers, globalTweets[tweet['id']]));
          }
        }

        // TODO: There must be a better way of getting the conversation ID
        replies.add(TweetChain(id: entryId.replaceFirst('conversationThread-', ''), tweets: tweets, isPinned: false));
      }
    }

    return replies;
  }

  static Future<TweetStatus> getTweet(String id, {String? cursor}) async {
    var query = {
      ...defaultParams,
      'include_tweet_replies': '1',
      'include_want_retweets': '1',
    };

    if (cursor != null) {
      query['cursor'] = cursor;
    }

    var response =
        await _twitterApi.client.get(Uri.https('api.twitter.com', '/2/timeline/conversation/$id.json', query));

    var result = json.decode(response.body);

    var globalTweets = result['globalObjects']['tweets'];
    var globalUsers = result['globalObjects']['users'];

    var instructions = List.from(result['timeline']['instructions']);
    if (instructions.isEmpty) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }

    var addEntries = List.from(instructions.firstWhere((e) => e.containsKey('addEntries'))['addEntries']['entries']);
    var repEntries = List.from(instructions.where((e) => e.containsKey('replaceEntry')));

    // TODO: Could this use createUnconversationedChains at some point?
    var chains = createTweetChains(globalTweets, globalUsers, instructions);

    String? cursorBottom = getCursor(addEntries, repEntries, 'cursor-bottom', 'Bottom');
    String? cursorTop = getCursor(addEntries, repEntries, 'cursor-top', 'Top');

    return TweetStatus(chains: chains, cursorBottom: cursorBottom, cursorTop: cursorTop);
  }

  static Future<TweetStatus> searchTweets(String query,
      {int limit = 25, String? maxId, String? cursor, String mode = ''}) async {
    var response = await _twitterApi.client.get(Uri.https('api.twitter.com', '/2/search/adaptive.json', {
      ...defaultParams,
      'count': limit.toString(),
      'cursor': cursor,
      'max_id': maxId,
      'q': query,
      'query_source': 'typed_query',
      'pc': '1',
      'tweet_search_mode': mode,
      'spelling_corrections': '1',
    }));

    var result = json.decode(response.body);

    return createUnconversationedChains(result, 'sq-I-t', false, true);
  }

  static Future<List<User>> searchUsers(String query, {int limit = 25, String? maxId, String? cursor}) async {
    var queryParameters = {
      ...defaultParams,
      'count': limit.toString(),
      'max_id': maxId,
      'q': query,
      'query_source': 'typed_query',
      'pc': '1',
      'spelling_corrections': '1',
      'result_filter': 'user'
    };

    if (cursor != null) {
      queryParameters['cursor'] = cursor;
    }

    var response =
        await _twitterApi.client.get(Uri.https('api.twitter.com', '/2/search/adaptive.json', queryParameters));

    var result = json.decode(response.body);

    // This is fairly similar to createUnconversationedChains
    var instructions = List.from(result['timeline']['instructions']);
    if (instructions.isEmpty) {
      return [];
    }

    var users = result['globalObjects']['users'] as Map<String, dynamic>;

    return List.from(instructions.firstWhere((e) => e.containsKey('addEntries'))['addEntries']['entries'])
        .where((element) => element['entryId'].startsWith('user-'))
        .sorted((a, b) => b['sortIndex'].compareTo(a['sortIndex']))
        .map((e) => users[e['content']['item']['content']['user']['id']])
        .map((e) => User.fromJson(e))
        .toList();
  }

  static Future<List<TrendLocation>> getTrendLocations() async {
    var result = await _cache.getOrCreateAsJSON('trends.locations', const Duration(days: 2), () async {
      var locations = await _twitterApi.trendsService.available();

      return jsonEncode(locations.map((e) => e.toJson()).toList());
    });

    return List.from(jsonDecode(result)).map((e) => TrendLocation.fromJson(e)).toList(growable: false);
  }

  static Future<List<Trends>> getTrends(int location) async {
    var result = await _cache.getOrCreateAsJSON('trends.$location', const Duration(minutes: 2), () async {
      var trends = await _twitterApi.trendsService.place(id: location);

      return jsonEncode(trends.map((e) => e.toJson()).toList());
    });

    return List.from(jsonDecode(result)).map((e) => Trends.fromJson(e)).toList(growable: false);
  }

  static Future<TweetStatus> getTweets(String id, String type,
      {int count = 10, String? cursor, bool includeReplies = true, bool includeRetweets = true}) async {
    var query = {
      ...defaultParams,
      'include_tweet_replies': includeReplies ? '1' : '0',
      'include_want_retweets': includeRetweets ? '1' : '0', // This may not actually do anything
      'count': count.toString(),
    };

    if (cursor != null) {
      query['cursor'] = cursor;
    }

    var response = await _twitterApi.client.get(Uri.https('api.twitter.com', '/2/timeline/$type/$id.json', query));

    var result = json.decode(response.body);

    return createUnconversationedChains(result, 'tweet', cursor == null, includeReplies == false);
  }

  static String? getCursor(List<dynamic> addEntries, List<dynamic> repEntries, String legacyType, String type) {
    String? cursor;

    Map<String, dynamic>? cursorEntry;

    var isLegacyCursor = addEntries.any((element) => element['entryId'].startsWith('cursor'));
    if (isLegacyCursor) {
      cursorEntry = addEntries.firstWhere((e) => e['entryId'].contains(legacyType), orElse: () => null);
    } else {
      cursorEntry = addEntries
          .where((e) => e['entryId'].startsWith('sq-C'))
          .firstWhere((e) => e['content']['operation']['cursor']['cursorType'] == type, orElse: () => null);
    }

    if (cursorEntry != null) {
      cursor = cursorEntry['content']['operation']['cursor']['value'];
    } else {
      // Look for a "replaceEntry" with the cursor
      var cursorReplaceEntry =
          repEntries.firstWhere((e) => e['replaceEntry']['entryIdToReplace'].contains(type), orElse: () => null);

      if (cursorReplaceEntry != null) {
        cursor = cursorReplaceEntry['replaceEntry']['entry']['content']['operation']['cursor']['value'];
      }
    }

    return cursor;
  }

  static TweetStatus createUnconversationedChains(
      dynamic result, String tweetIndicator, bool showPinned, bool mapToThreads) {
    var instructions = List.from(result['timeline']['instructions']);
    if (instructions.isEmpty) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }

    var addEntries = List.from(instructions.firstWhere((e) => e.containsKey('addEntries'))['addEntries']['entries']);
    var repEntries = List.from(instructions.where((e) => e.containsKey('replaceEntry')));

    String? cursorBottom = getCursor(addEntries, repEntries, 'cursor-bottom', 'Bottom');
    String? cursorTop = getCursor(addEntries, repEntries, 'cursor-top', 'Top');

    var tweets = _createTweets(tweetIndicator, result);

    // First, get all the IDs of the tweets we need to display
    var tweetEntries = addEntries
        .where((e) => e['entryId'].contains(tweetIndicator))
        .sorted((a, b) => b['sortIndex'].compareTo(a['sortIndex']))
        .map((e) => e['content']['item']['content']['tweet']['id'])
        .cast<String>()
        .toList();

    Map<String, List<TweetWithCard>> conversations =
        tweets.values.where((e) => tweetEntries.contains(e.idStr)).groupBy((e) {
      // TODO: I don't think a flag is the right way to handle this
      if (mapToThreads) {
        // Then group the tweets-to-display by their conversation ID
        return e.conversationIdStr;
      }

      return e.idStr;
    }).cast<String, List<TweetWithCard>>();

    List<TweetChain> chains = [];

    // Order all the conversations by newest first (assuming the ID is an incrementing key), and create a chain from them
    for (var conversation in conversations.entries.sorted((a, b) => b.key.compareTo(a.key))) {
      var chainTweets = conversation.value.sorted((a, b) => a.idStr!.compareTo(b.idStr!)).toList();

      chains.add(TweetChain(id: conversation.key, tweets: chainTweets, isPinned: false));
    }

    // If we want to show pinned tweets, add them before the chains that we already have
    if (showPinned) {
      var pinEntry = instructions.firstWhere((e) => e.containsKey('pinEntry'), orElse: () => null);
      if (pinEntry != null) {
        var id = pinEntry['pinEntry']['entry']['content']['item']['content']['tweet']['id'] as String;

        // It's possible for the pinned tweet to either not exist, or not be returned, so handle that
        if (tweets.containsKey(id)) {
          chains.insert(0, TweetChain(id: id, tweets: [tweets[id]!], isPinned: true));
        }
      }
    }

    return TweetStatus(chains: chains, cursorBottom: cursorBottom, cursorTop: cursorTop);
  }

  static Future<List<User>> getUsers(Iterable<String> ids) async {
    // Split into groups of 100, as the API only supports that many at a time
    List<Future<List<User>>> futures = [];

    var groups = partition(ids, 100);
    for (var group in groups) {
      futures.add(_getUsersPage(group));
    }

    return (await Future.wait(futures)).expand((element) => element).toList();
  }

  static Future<List<User>> _getUsersPage(Iterable<String> ids) async {
    var response = await _twitterApi.client.get(Uri.https('api.twitter.com', '/1.1/users/lookup.json', {
      'user_id': ids.join(','),
    }));

    var result = json.decode(response.body);

    return List.from(result).map((e) => User.fromJson(e)).toList(growable: false);
  }

  static Map<String, TweetWithCard> _createTweets(String entryPrefix, Map<String, dynamic> result) {
    var globalTweets = result['globalObjects']['tweets'] as Map<String, dynamic>;
    var globalUsers = result['globalObjects']['users'];

    var tweets = globalTweets.values.map((e) => TweetWithCard.fromCardJson(globalTweets, globalUsers, e)).toList();

    return {for (var e in tweets) e.idStr!: e};
  }
}

class TweetWithCard extends Tweet {
  Map<String, dynamic>? card;
  String? conversationIdStr;
  TweetWithCard? inReplyToWithCard;
  TweetWithCard? quotedStatusWithCard;
  TweetWithCard? retweetedStatusWithCard;
  bool? isTombstone;

  TweetWithCard();

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['card'] = card;
    json['conversationIdStr'] = conversationIdStr;
    json['inReplyToWithCard'] = inReplyToWithCard?.toJson();
    json['quotedStatusWithCard'] = quotedStatusWithCard?.toJson();
    json['retweetedStatusWithCard'] = retweetedStatusWithCard?.toJson();
    json['isTombstone'] = isTombstone;

    return json;
  }

  factory TweetWithCard.tombstone(dynamic e) {
    var tweetWithCard = TweetWithCard();
    tweetWithCard.idStr = '';
    tweetWithCard.isTombstone = true;
    tweetWithCard.text = ((e['richText']?['text'] ?? '') as String).replaceFirst(' Learn more', '');

    return tweetWithCard;
  }

  factory TweetWithCard.fromJson(Map<String, dynamic> e) {
    var tweet = Tweet.fromJson(e);

    var tweetWithCard = TweetWithCard();
    tweetWithCard.card = e['card'];
    tweetWithCard.conversationIdStr = e['conversationIdStr'];
    tweetWithCard.createdAt = tweet.createdAt;
    tweetWithCard.entities = tweet.entities;
    tweetWithCard.displayTextRange = tweet.displayTextRange;
    tweetWithCard.extendedEntities = tweet.extendedEntities;
    tweetWithCard.favorited = tweet.favorited;
    tweetWithCard.favoriteCount = tweet.favoriteCount;
    tweetWithCard.fullText = tweet.fullText;
    tweetWithCard.idStr = tweet.idStr;
    tweetWithCard.inReplyToScreenName = tweet.inReplyToScreenName;
    tweetWithCard.inReplyToStatusIdStr = tweet.inReplyToStatusIdStr;
    tweetWithCard.inReplyToUserIdStr = tweet.inReplyToUserIdStr;
    tweetWithCard.inReplyToWithCard =
        e['inReplyToWithCard'] == null ? null : TweetWithCard.fromJson(e['inReplyToWithCard']);
    tweetWithCard.isQuoteStatus = tweet.isQuoteStatus;
    tweetWithCard.isTombstone = e['is_tombstone'];
    tweetWithCard.lang = tweet.lang;
    tweetWithCard.quoteCount = tweet.quoteCount;
    tweetWithCard.quotedStatusIdStr = tweet.quotedStatusIdStr;
    tweetWithCard.quotedStatusPermalink = tweet.quotedStatusPermalink;
    tweetWithCard.quotedStatusWithCard =
        e['quotedStatusWithCard'] == null ? null : TweetWithCard.fromJson(e['quotedStatusWithCard']);
    tweetWithCard.replyCount = tweet.replyCount;
    tweetWithCard.retweetCount = tweet.retweetCount;
    tweetWithCard.retweeted = tweet.retweeted;
    tweetWithCard.retweetedStatus = tweet.retweetedStatus;
    tweetWithCard.retweetedStatusWithCard =
        e['retweetedStatusWithCard'] == null ? null : TweetWithCard.fromJson(e['retweetedStatusWithCard']);
    tweetWithCard.source = tweet.source;
    tweetWithCard.text = tweet.text;
    tweetWithCard.user = tweet.user;

    tweetWithCard.coordinates = tweet.coordinates;
    tweetWithCard.truncated = tweet.truncated;
    tweetWithCard.place = tweet.place;
    tweetWithCard.possiblySensitive = tweet.possiblySensitive;
    tweetWithCard.possiblySensitiveAppealable = tweet.possiblySensitiveAppealable;

    return tweetWithCard;
  }

  factory TweetWithCard.fromCardJson(Map<String, dynamic> tweets, Map<String, dynamic> users, Map<String, dynamic> e) {
    TweetWithCard tweet = TweetWithCard();
    tweet.card = e['card'];
    tweet.conversationIdStr = e['conversation_id_str'];
    tweet.createdAt = convertTwitterDateTime(e['created_at']);
    tweet.entities = e['entities'] == null ? null : Entities.fromJson(e['entities']);
    tweet.extendedEntities = e['extended_entities'] == null ? null : Entities.fromJson(e['extended_entities']);
    tweet.favorited = e['favorited'] as bool?;
    tweet.favoriteCount = e['favorite_count'] as int?;
    tweet.fullText = e['full_text'] as String?;
    tweet.idStr = e['id_str'] as String?;
    tweet.inReplyToScreenName = e['in_reply_to_screen_name'] as String?;
    tweet.inReplyToStatusIdStr = e['in_reply_to_status_id_str'] as String?;
    tweet.inReplyToUserIdStr = e['in_reply_to_user_id_str'] as String?;
    tweet.isQuoteStatus = e['is_quote_status'] as bool?;
    tweet.isTombstone = e['is_tombstone'] as bool?;
    tweet.lang = e['lang'] as String?;
    tweet.quoteCount = e['quote_count'] as int?;
    tweet.quotedStatusIdStr = e['quoted_status_id_str'] as String?;
    tweet.quotedStatusPermalink =
        e['quoted_status_permalink'] == null ? null : QuotedStatusPermalink.fromJson(e['quoted_status_permalink']);
    tweet.replyCount = e['reply_count'] as int?;
    tweet.retweetCount = e['retweet_count'] as int?;
    tweet.retweeted = e['retweeted'] as bool?;
    tweet.source = e['source'] as String?;
    tweet.text = e['text'] ?? e['full_text'] as String?;
    tweet.user = e['user_id_str'] == null ? null : User.fromJson(users[e['user_id_str']]);

    var retweetedStatus = e['retweeted_status_id_str'] == null
        ? null
        : TweetWithCard.fromCardJson(tweets, users, tweets[e['retweeted_status_id_str']]);
    tweet.retweetedStatus = retweetedStatus;
    tweet.retweetedStatusWithCard = retweetedStatus;

    // Some quotes aren't returned, even though we're given their ID, so double check and don't fail with a null value
    var quoteId = e['quoted_status_id_str'];
    if (quoteId != null && tweets[quoteId] != null) {
      var quotedStatus = TweetWithCard.fromCardJson(tweets, users, tweets[quoteId]);

      tweet.quotedStatus = quotedStatus;
      tweet.quotedStatusWithCard = quotedStatus;
    }

    var inReplyToId = e['in_reply_to_status_id_str'];
    if (inReplyToId != null && tweets[inReplyToId] != null) {
      var inReplyTo = TweetWithCard.fromCardJson(tweets, users, tweets[inReplyToId]);

      tweet.inReplyToWithCard = inReplyTo;
    }

    tweet.displayTextRange = (e['display_text_range'] as List<dynamic>?)?.map((e) => e as int).toList();

    // TODO
    tweet.coordinates = null;
    tweet.truncated = null;
    tweet.place = null;
    tweet.possiblySensitive = null;
    tweet.possiblySensitiveAppealable = null;

    return tweet;
  }
}

class TweetChain {
  final String id;
  final List<TweetWithCard> tweets;
  final bool isPinned;

  TweetChain({required this.id, required this.tweets, required this.isPinned});
}

class Follows {
  final int? cursorBottom;
  final int? cursorTop;
  final List<User> users;

  Follows({required this.cursorBottom, required this.cursorTop, required this.users});
}

class TweetStatus {
  // final TweetChain after;
  // final TweetChain before;
  final String? cursorBottom;
  final String? cursorTop;
  final List<TweetChain> chains;

  TweetStatus({required this.chains, required this.cursorBottom, required this.cursorTop});
}

class TwitterError {
  final int code;
  final String message;

  TwitterError({required this.code, required this.message});

  @override
  String toString() {
    return 'TwitterError{code: $code, message: $message}';
  }
}
