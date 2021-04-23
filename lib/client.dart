import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:dart_twitter_api/src/utils/date_utils.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;

const Duration _defaultTimeout = Duration(seconds: 10);
const String _bearerToken = 'Bearer AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA';

class _FritterTwitterClient extends TwitterClient {
  _FritterTwitterClient() : super(
    consumerKey: '',
    consumerSecret: '',
    token: '',
    secret: ''
  );

  static String? _token;
  static int _expiresAt = -1;
  static int _tokenLimit = -1;
  static int _tokenRemaining = -1;

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers, Duration? timeout}) {
    return fetch(uri, headers: headers)
        .timeout(timeout ?? _defaultTimeout)
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return Future.error(response);
      }
    });
  }

  static Future<String> getToken() async {
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

    // TODO
    throw new Exception('Unable to refresh the token');
  }

  static Future<http.Response> fetch(Uri uri, {Map<String, String>? headers}) async {
    log('Fetching $uri');

    var response = await http.get(uri, headers: {
      ...?headers,
      'authorization': _bearerToken,
      'x-guest-token': await getToken(),
      'x-twitter-active-user': 'yes',
      'user-agent': faker.internet.userAgent()
    });

    var headerRateLimitReset = response.headers['x-rate-limit-reset'];
    var headerRateLimitRemaining = response.headers['x-rate-limit-remaining'];
    var headerRateLimitLimit = response.headers['x-rate-limit-limit'];

    if (headerRateLimitReset == null || headerRateLimitRemaining == null || headerRateLimitLimit == null) {
      throw new Exception('One or more of the rate limit headers are missing');
    }

    // Update our token's rate limit counters
    _expiresAt = int.parse(headerRateLimitReset) * 1000;
    _tokenRemaining = int.parse(headerRateLimitRemaining);
    _tokenLimit = int.parse(headerRateLimitLimit);

    return response;
  }

}

class Twitter {
  static TwitterApi _twitterApi = TwitterApi(client: _FritterTwitterClient());
  
  static Future<User> getProfile(String username) async {
    var result = await _twitterApi.userService.usersShow(
      screenName: username
    );

    return result;
  }

  static Future<Tweet> getTweet(String id) async {
    var result = await _twitterApi.tweetService.show(
      id: id,
    );

    return result;
  }

  static Future<List<Tweet>> getTweetReplies(String id, { String after = "" }) async {
    var response = await _twitterApi.client.get(
      Uri.https('api.twitter.com', '/2/timeline/conversation/$id.json')
    );

    var result = json.decode(response.body);

    var globalTweets = result['globalObjects']['tweets'];
    var instructions = result['timeline']['instructions'];
    var globalUsers = result['globalObjects']['users'];

    return List.from(instructions[0]['addEntries']['entries'])
        .where((entry) => entry['entryId'].startsWith('conversationThread') as bool)
        .where((entry) {
          // I love this API!
          if (entry['content']['timelineModule'] != null &&
              entry['content']['timelineModule']['items'] != null &&
              entry['content']['timelineModule']['items'][0] != null &&
              entry['content']['timelineModule']['items'][0]['item'] != null &&
              entry['content']['timelineModule']['items'][0]['item']['content'] != null &&
              entry['content']['timelineModule']['items'][0]['item']['content']['tweet'] != null &&
              entry['content']['timelineModule']['items'][0]['item']['content']['tweet']['id'] != null) {
            return true;
          }

          return false;
        })
        .map((e) => tweetFromJson(globalTweets, globalUsers, globalTweets[e['content']['timelineModule']['items'][0]['item']['content']['tweet']['id']]))
        .toList(growable: false);
  }

  static Future<List<Tweet>> searchTweets(String query, {int limit = 25, String? maxId}) async {
    var result = await _twitterApi.tweetSearchService.searchTweets(
      q: query,
      includeEntities: true,
      count: limit,
      maxId: maxId
    );

    return result.statuses ?? [];
  }

  static Future<List<User>> searchUsers(String query) async {
    var result = await _twitterApi.userService.usersSearch(
      q: query,
    );

    return result;
  }

  static Future<List<Trends>> getTrends() async {
    var result = await _twitterApi.trendsService.place(
      id: 1
    );

    return result;
  }

  static Future<TweetList> getTweets(String id, { int count = 10, String? cursor }) async {
    var query = {
      'count': count.toString(),
      'include_tweet_replies': 'false',
      'include_profile_interstitial_type': '0',
      'include_blocking': '0',
      'include_blocked_by': '0',
      'include_followed_by': '0',
      'include_want_retweets': '0',
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

    if (cursor != null) {
      query['cursor'] = cursor;
    }

    var response = await _twitterApi.client.get(
      Uri.https('api.twitter.com', '/2/timeline/profile/$id.json', query)
    );

    var result = json.decode(response.body);

    var globalTweets = result['globalObjects']['tweets'] as Map<String, dynamic>;
    var instructions = result['timeline']['instructions'];
    var globalUsers = result['globalObjects']['users'];
    var entries = instructions[0]['addEntries']['entries'] as List<dynamic>;

    var cursorBottom = entries
        .where((entry) => entry['entryId'].startsWith('cursor-bottom'))
        .map((e) => e['content']['operation']['cursor']['value'])
        .cast<String>()
        .first;

    var tweets = entries
        .where((entry) => entry['entryId'].startsWith('tweet') as bool)
        .where((entry) => globalTweets.containsKey(entry['sortIndex'])) // TODO: This ignores tweets from suspended accounts, e.g. 1215411856564768768
        .map<Tweet>((entry) => tweetFromJson(globalTweets, globalUsers, globalTweets[entry['sortIndex']]))
        .toList(growable: false);

    return TweetList(tweets: tweets, cursorBottom: cursorBottom);
  }

  static Tweet tweetFromJson(Map<String, dynamic> tweets, Map<String, dynamic> users, Map<String, dynamic> e) {
    Tweet tweet = Tweet();
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
    tweet.lang = e['lang'] as String?;
    tweet.quoteCount = e['quote_count'] as int?;
    tweet.quotedStatusIdStr = e['quoted_status_id_str'] as String?;
    tweet.quotedStatusPermalink = e['quoted_status_permalink'] == null ? null : QuotedStatusPermalink.fromJson(e['quoted_status_permalink']);
    tweet.replyCount = e['reply_count'] as int?;
    tweet.retweetCount = e['retweet_count'] as int?;
    tweet.retweeted = e['retweeted'] as bool?;
    tweet.retweetedStatus = e['retweeted_status_id_str'] == null ? null : tweetFromJson(tweets, users, tweets[e['retweeted_status_id_str']]);
    tweet.source = e['source'] as String?;
    tweet.text = e['text'] ?? e['full_text'] as String?;
    tweet.user = e['user_id_str'] == null ? null : User.fromJson(users[e['user_id_str']]);

    tweet.displayTextRange = (e['display_text_range'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList();

    // Some quotes aren't returned, even though we're given their ID, so double check and don't fail with a null value
    var quoteId = e['quoted_status_id_str'];
    if (quoteId != null && tweets[quoteId] != null) {
      tweet.quotedStatus = tweetFromJson(tweets, users, tweets[quoteId]);
    }

    // TODO
    tweet.coordinates = null;
    tweet.truncated = null;
    tweet.place = null;
    tweet.possiblySensitive = null;
    tweet.possiblySensitiveAppealable = null;

    return tweet;
  }
}

class TweetList {
  final List<Tweet> tweets;
  final String? cursorBottom;

  TweetList({required this.tweets, required this.cursorBottom });
}