import 'dart:async';
import 'dart:convert';

import 'package:dart_twitter_api/src/utils/date_utils.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:ffcache/ffcache.dart';
import 'package:fritter/catcher/errors.dart';
import 'package:fritter/catcher/exceptions.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/profile/filter_model.dart';
import 'package:fritter/profile/profile_model.dart';
import 'package:fritter/user.dart';
import 'package:fritter/utils/cache.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';
import 'package:quiver/iterables.dart';
import 'WebFlowAuth/webFlowAuth_model.dart';




const Duration _defaultTimeout = Duration(seconds: 30);

class _FritterTwitterClient extends TwitterClient {
  static final log = Logger('_FritterTwitterClient');
  static var userAgentHeader = {
    'user-agent':
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36",
    // "Pragma": "no-cache",
    "Cache-Control": "no-cache"
    // "If-Modified-Since": "Sat, 1 Jan 2000 00:00:00 GMT",
  };
  _FritterTwitterClient() : super(consumerKey: '', consumerSecret: '', token: '', secret: '');


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

  static Future<http.Response> fetch(Uri uri, {Map<String, String>? headers}) async {
    log.info('Fetching $uri');
    var prefs= await PrefServiceShared.init(prefix: 'pref_');
    WebFlowAuthModel webFlowAuthModel=WebFlowAuthModel(prefs);
    var authHeader=await webFlowAuthModel.GetAuthHeader(userAgentHeader);
    var response = await http.get(uri, headers: {
      ...?headers,...?authHeader,...?userAgentHeader,
      //'authorization': _bearerToken,
      //'x-guest-token': (await getToken()).toString(),
      'x-twitter-active-user': 'yes',
      //'user-agent': faker.internet.userAgent()
    });

    var headerRateLimitReset = response.headers['x-rate-limit-reset'];
    var headerRateLimitRemaining = response.headers['x-rate-limit-remaining'];
    var headerRateLimitLimit = response.headers['x-rate-limit-limit'];

    if (headerRateLimitReset == null || headerRateLimitRemaining == null || headerRateLimitLimit == null) {
      // If the rate limit headers are missing, the endpoint probably doesn't send them back
      return response;
    }



    return response;
  }
}

class UnknownProfileResultType with SyntheticException implements Exception {
  final String type;
  final String message;
  final String uri;

  UnknownProfileResultType(this.type, this.message, this.uri);

  @override
  String toString() {
    return 'Unknown profile result type: {type: $type, message: $message, uri: $uri}';
  }
}

class UnknownProfileUnavailableReason with SyntheticException implements Exception {
  final String reason;
  final String uri;

  UnknownProfileUnavailableReason(this.reason, this.uri);

  @override
  String toString() {
    return 'Unknown profile unavailable reason: {reason: $reason, uri: $uri}';
  }
}


class Twitter {
  static final TwitterApi _twitterApi = TwitterApi(client: _FritterTwitterClient());

  static final FFCache _cache = FFCache();

  static Map<String, String> defaultParams = {
    'include_profile_interstitial_type': '1',
    'include_blocking': '1',
    'include_blocked_by': '1',
    'include_followed_by': '1',
    'include_mute_edge': '1',
    'include_can_dm': '1',
    'include_can_media_tag': '1',
    'include_ext_has_nft_avatar': '1',
    'include_ext_is_blue_verified': '1',
    'skip_status': '1',
    'cards_platform': 'Web-12',
    'include_cards': '1',
    'include_ext_alt_text': 'true',
    'include_ext_limited_action_results': 'false',
    'include_quote_count': 'true',
    'include_reply_count': '1',
    'tweet_mode': 'extended',
    'include_ext_collab_control': 'true',
    'include_entities': 'true',
    'include_user_entities': 'true',
    'include_ext_media_color': 'true',
    'include_ext_media_availability': 'true',
    'include_ext_sensitive_media_warning': 'true',
    'include_ext_trusted_friends_metadata': 'true',
    'send_error_codes': 'true',
    'simple_quoted_tweet': 'true',
    'pc': '1',
    'spelling_corrections': '1',
    'include_ext_edit_control': 'true',
    'ext': 'mediaStats,highlightedLabel,hasNftAvatar,voiceInfo,enrichments,superFollowMetadata,unmentionInfo,editControl,collab_control,vibe,'
  };

  static Future<Profile> getProfileById(String id) async {
    var uri = Uri.https('twitter.com', '/i/api/graphql/Lxg1V9AiIzzXEiP2c8dRnw/UserByRestId', {
      'variables': jsonEncode({
        'userId': id,
        'withHighlightedLabel': true,
        'withSafetyModeUserFields': true,
        'withSuperFollowsUserFields': true
      }),
      'features': jsonEncode({
        'hidden_profile_likes_enabled': false,
        'responsive_web_graphql_exclude_directive_enabled': true,
        'verified_phone_label_enabled': false,
        'highlights_tweets_tab_ui_enabled': true,
        'creator_subscriptions_tweet_preview_api_enabled': true,
        'responsive_web_graphql_skip_user_profile_image_extensions_enabled': false,
        'responsive_web_graphql_timeline_navigation_enabled': true
      })
    });

    return _getProfile(uri);
  }

  static Future<Profile> getProfileByScreenName(String screenName) async {
    var uri = Uri.https('twitter.com', '/i/api/graphql/oUZZZ8Oddwxs8Cd3iW3UEA/UserByScreenName', {
      'variables': jsonEncode({
        'screen_name': screenName,
        'withHighlightedLabel': true,
        'withSafetyModeUserFields': true,
        'withSuperFollowsUserFields': true
      }),
      'features': jsonEncode({
        'hidden_profile_likes_enabled': false,
        'responsive_web_graphql_exclude_directive_enabled': true,
        'verified_phone_label_enabled': false,
        'subscriptions_verification_info_verified_since_enabled': true,
        'highlights_tweets_tab_ui_enabled': true,
        'creator_subscriptions_tweet_preview_api_enabled': true,
        'responsive_web_graphql_skip_user_profile_image_extensions_enabled': false,
        'responsive_web_graphql_timeline_navigation_enabled': true
      })
    });

    return _getProfile(uri);
  }

  static Future<Profile> _getProfile(Uri uri) async {
    var response = await _twitterApi.client.get(uri);
    var content = jsonDecode(response.body) as Map<String, dynamic>;

    var hasErrors = content.containsKey('errors');
    if (hasErrors && content['errors'] != null) {
      var errors = List.from(content['errors']);
      if (errors.isEmpty) {
        throw TwitterError(code: 0, message: 'Unknown error', uri: uri.toString());
      } else {
        throw TwitterError(code: errors.first['code'], message: errors.first['message'], uri: uri.toString());
      }
    }

    var result = content['data']?['user']?['result'];
    if (result == null) {
      throw TwitterError(uri: uri.toString(), code: 50, message: L10n.current.user_not_found);
    }

    var resultType = result['__typename'];
    if (resultType != null) {
      switch (resultType) {
        case 'UserUnavailable':
          var code = result['reason'];
          if (code == 'Suspended') {
            throw TwitterError(code: 63, message: result['reason'], uri: uri.toString());
          } else {
            Catcher.reportSyntheticException(UnknownProfileUnavailableReason(code, uri.toString()));
            throw TwitterError(code: -1, message: result['reason'], uri: uri.toString());
          }
        case 'User':
          // This means everything's fine
          break;
        default:
          Catcher.reportSyntheticException(UnknownProfileResultType(resultType, result['reason'], uri.toString()));
          break;
      }
    }

    var user = UserWithExtra.fromJson({...result['legacy'], 'id_str': result['rest_id'], 'ext_is_blue_verified': result['is_blue_verified']});
    var pins = List<String>.from(result['legacy']['pinned_tweet_ids_str']);

    return Profile(user, pins);
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
        users: response.users?.map((e) => UserWithExtra.fromJson(e.toJson())).toList() ?? []);
  }
  static List<TweetChain> createTweetChains(List<dynamic> addEntries) {
    List<TweetChain> replies = [];

    for (var entry in addEntries) {
      var entryId = entry['entryId'] as String;
      if (entryId.startsWith('tweet-')) {
        var result;
        if(entry['content']['itemContent']['tweet_results']['result']["__typename"]=="TweetWithVisibilityResults")
           result = entry['content']['itemContent']['tweet_results']['result']['tweet'];
        else
           result = entry['content']['itemContent']['tweet_results']['result'];

        replies.add(TweetChain(
            id: result['rest_id'],
            tweets: [TweetWithCard.fromGraphqlJson(result)],
            isPinned: false));
      }

      if (entryId.startsWith('cursor-bottom') || entryId.startsWith('cursor-showMore')) {
        // TODO: Use as the "next page" cursor
      }

      if (entryId.startsWith('conversationthread')) {
        List<TweetWithCard> tweets = [];

        // TODO: This is missing tombstone support
        for (var item in entry['content']['items']) {
          var itemType = item['item']?['itemContent']?['itemType'];
          if (itemType == 'TimelineTweet') {
            if (item['item']['itemContent']['tweet_results']?['result'] != null) {
              tweets.add(TweetWithCard.fromGraphqlJson(item['item']['itemContent']['tweet_results']['result']));
            }
          } else {
            Catcher.reportSyntheticException(UnknownTimelineItemType(itemType, entryId));
          }
        }

        // TODO: There must be a better way of getting the conversation ID
        replies.add(TweetChain(id: entryId.replaceFirst('conversationthread-', ''), tweets: tweets, isPinned: false));
      }
    }

    return replies;
  }

  static List<TweetChain> createTweets(List<dynamic> addEntries,FilterModel filterModel,[bool isPinned=false]) {
    List<TweetChain> replies = [];

    for (var entry in addEntries) {
      var entryId = entry['entryId'] as String;
      if (entryId.startsWith('tweet-')) {
        var result = entry['content']['itemContent']['tweet_results']['result'];
        TweetWithCard? tweet = TweetWithCard.fromGraphqlJson(result);
        if (tweet != null) {

            if (!FilterTweetRegEx(filterModel,tweet)) {
              replies.add(TweetChain(
                  id: result['rest_id']??result['tweet']['rest_id'],
                  tweets: [tweet],
                  isPinned: isPinned));
          }

        }
      }

      if (entryId.startsWith('cursor-bottom') || entryId.startsWith('cursor-showMore')) {
        // TODO: Use as the "next page" cursor
      }

      if (entryId.startsWith('profile-conversation')) {
        List<TweetWithCard> tweets = [];

        // TODO: This is missing tombstone support
        for (var item in entry['content']['items']) {
          var itemType = item['item']?['itemContent']?['itemType'];
          if (itemType == 'TimelineTweet') {
            if (item['item']['itemContent']['tweet_results']?['result'] != null) {
              if(item['item']['itemContent']['tweet_results']['result']['tweet']==null) {
                var  tweet= TweetWithCard.fromGraphqlJson(item['item']['itemContent']['tweet_results']['result']);
                if (!FilterTweetRegEx(filterModel,tweet))
                tweets.add(tweet);
              }
              else {
                var  tweet=TweetWithCard.fromGraphqlJson(item['item']['itemContent']['tweet_results']['result']['tweet']);
                if (!FilterTweetRegEx(filterModel,tweet))
                tweets.add(tweet);
              }
            }
          } else {
            Catcher.reportSyntheticException(UnknownTimelineItemType(itemType, entryId));
          }
        }

        // TODO: There must be a better way of getting the conversation ID
        replies.add(TweetChain(id: entryId.replaceFirst('profile-conversation-', ''), tweets: tweets, isPinned: false));
      }
    }
    return replies;
  }
  static bool FilterTweetRegEx(FilterModel filterModel, TweetWithCard tweet){
    RegExp ?regexFilter;
    if (filterModel.GetRegex() != null && filterModel.GetRegex()!.isNotEmpty){
      regexFilter = RegExp(filterModel.GetRegex()!, caseSensitive: false, multiLine: true);
    }
    //Add the tweet into the tweet chain if there is no RegEx expression stored
    // in the model of profile, or text of the tweet doesnt contain an expression given
    // by the model.
    if (regexFilter == null || !regexFilter!.hasMatch( tweet.fullText.toString() )) {
      return false;
    }
    else
      return true;

  }
  static Future<TweetStatus> getTweet(String id, {String? cursor}) async {
    Map<String,Object> defaultParam = {
      "variables":"{\"focalTweetId\":\"1696081434153214389\",\"referrer\":\"profile\",\"controller_data\":\"DAACDAABDAABCgABAAAAAAAAAAAKAAkNObspUxawBQAAAAA=\",\"with_rux_injections\":false,\"includePromotedContent\":true,\"withCommunity\":true,\"withQuickPromoteEligibilityTweetFields\":true,\"withBirdwatchNotes\":true,\"withVoice\":true,\"withV2Timeline\":true}",
      "features":"{\"rweb_lists_timeline_redesign_enabled\":true,\"responsive_web_graphql_exclude_directive_enabled\":true,\"verified_phone_label_enabled\":false,\"creator_subscriptions_tweet_preview_api_enabled\":true,\"responsive_web_graphql_timeline_navigation_enabled\":true,\"responsive_web_graphql_skip_user_profile_image_extensions_enabled\":false,\"tweetypie_unmention_optimization_enabled\":true,\"responsive_web_edit_tweet_api_enabled\":true,\"graphql_is_translatable_rweb_tweet_is_translatable_enabled\":true,\"view_counts_everywhere_api_enabled\":true,\"longform_notetweets_consumption_enabled\":true,\"responsive_web_twitter_article_tweet_consumption_enabled\":false,\"tweet_awards_web_tipping_enabled\":false,\"freedom_of_speech_not_reach_fetch_enabled\":true,\"standardized_nudges_misinfo\":true,\"tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled\":true,\"longform_notetweets_rich_text_read_enabled\":true,\"longform_notetweets_inline_media_enabled\":true,\"responsive_web_media_download_video_enabled\":false,\"responsive_web_enhance_cards_enabled\":false}",
      "fieldToggles":"{\"withArticleRichContentState\":false}"
    };

    Map<String, dynamic> variables=json.decode(defaultParam["variables"].toString());
    variables["focalTweetId"]=id;
    if (cursor != null) {
      variables['cursor'] = cursor;
    }
    defaultParam["variables"]=json.encode(variables);

    var response =
    await _twitterApi.client.get(Uri.https('twitter.com', '/i/api/graphql/3XDB26fBve-MmjHaWTUZxA/TweetDetail', defaultParam));

    var result = json.decode(response.body);

    var instructions = List.from(result?['data']?['threaded_conversation_with_injections_v2']?['instructions']);
    if (instructions.isEmpty) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }

    var addEntriesInstructions = instructions.firstWhereOrNull((e) => e['type'] == 'TimelineAddEntries');
    if (addEntriesInstructions == null) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }

    var addEntries = List.from(addEntriesInstructions['entries']);
    var repEntries = List.from(instructions.where((e) => e['type'] == 'TimelineReplaceEntry'));

    // TODO: Could this use createUnconversationedChains at some point?
    var chains = createTweetChains(addEntries);
    var rootTweet = chains.first;
    chains.remove(rootTweet);
    chains.sort((a, b){
      return  b.id!.compareTo(a.id!);});
    chains.insert(0, rootTweet);
    String? cursorBottom = getCursor(addEntries, repEntries, 'cursor-bottom', 'Bottom');
    String? cursorTop = getCursor(addEntries, repEntries, 'cursor-top', 'Top');

    return TweetStatus(chains: chains, cursorBottom: cursorBottom, cursorTop: cursorTop);
  }

  static Future<List<UserWithExtra>> searchUsers(String query, {int limit = 25, String? maxId, String? cursor}) async {
    var queryParameters = {
      ...defaultParams,
      'count': limit.toString(),
      'max_id': maxId,
      'q': query,
      'pc': '1',
      'spelling_corrections': '1',
      'result_filter': 'user'
    };

    if (cursor != null) {
      queryParameters['cursor'] = cursor;
    }

    var response = await _twitterApi.client.get(Uri.https('api.twitter.com', '/1.1/users/search.json', queryParameters));

    List result = json.decode(response.body);

    if (result.isEmpty) {
      return [];
    }

    return result
        .map((e) => UserWithExtra.fromJson(e))
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
  static Future<TweetStatus> getTimelineTweets(String id, String type, List<String> pinnedTweets,
      {int count = 10, String? cursor, bool includeReplies = true,
        bool includeRetweets = true, required int Function() getTweetsCounter,
        required void Function() incrementTweetsCounter, required FilterModel filterModel}) async {
    bool showPinnedTweet=true;
    var query = {
      ...defaultParams,
      'include_tweet_replies': includeReplies ? '1' : '0',
      'include_want_retweets': includeRetweets ? '1' : '0', // This may not actually do anything
      'count': count.toString(),
    };
    Map<String,Object> defaultUserTweetsParam=
    {
      "variables":"{\"userId\":\"160534877\",\"count\":20,\"includePromotedContent\":true,\"withQuickPromoteEligibilityTweetFields\":true,\"withVoice\":true,\"withV2Timeline\":true}",
      "features":"{\"rweb_lists_timeline_redesign_enabled\":true,\"responsive_web_graphql_exclude_directive_enabled\":true,\"verified_phone_label_enabled\":false,\"creator_subscriptions_tweet_preview_api_enabled\":true,\"responsive_web_graphql_timeline_navigation_enabled\":true,\"responsive_web_graphql_skip_user_profile_image_extensions_enabled\":false,\"tweetypie_unmention_optimization_enabled\":true,\"responsive_web_edit_tweet_api_enabled\":true,\"graphql_is_translatable_rweb_tweet_is_translatable_enabled\":true,\"view_counts_everywhere_api_enabled\":true,\"longform_notetweets_consumption_enabled\":true,\"responsive_web_twitter_article_tweet_consumption_enabled\":false,\"tweet_awards_web_tipping_enabled\":false,\"freedom_of_speech_not_reach_fetch_enabled\":true,\"standardized_nudges_misinfo\":true,\"tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled\":true,\"longform_notetweets_rich_text_read_enabled\":true,\"longform_notetweets_inline_media_enabled\":true,\"responsive_web_media_download_video_enabled\":false,\"responsive_web_enhance_cards_enabled\":false}",
      "fieldToggles":"{\"withAuxiliaryUserLabels\":false,\"withArticleRichContentState\":false}"
    };

    Map<String, dynamic> variables=json.decode(defaultUserTweetsParam["variables"].toString());
    variables["userId"]=id;
    if (cursor != null) {
      variables['cursor'] = cursor;
    }
    variables['count'] = count;
    defaultUserTweetsParam["variables"]=json.encode(variables);

    var response = await _twitterApi.client.get(Uri.https('twitter.com', 'i/api/graphql/W4Tpu1uueTGK53paUgxF0Q/HomeTimeline', defaultUserTweetsParam));
    var result = json.decode(response.body);
    //if this page is not first one on the profile page, dont add pinned tweet
    if(variables['cursor'] != null)
      showPinnedTweet=false;
    return createTimelineChains(result, 'tweet', pinnedTweets, includeReplies == false,
        includeReplies,showPinnedTweet,getTweetsCounter,incrementTweetsCounter,filterModel:filterModel);
  }
  static Future<TweetStatus> getTweets(String id, String type, List<String> pinnedTweets,
      {int count = 10, String? cursor, bool includeReplies = true,
        bool includeRetweets = true, required int Function() getTweetsCounter,
        required void Function() incrementTweetsCounter, required FilterModel filterModel}) async {
    bool showPinnedTweet=true;
    var query = {
      ...defaultParams,
      'include_tweet_replies': includeReplies ? '1' : '0',
      'include_want_retweets': includeRetweets ? '1' : '0', // This may not actually do anything
      'count': count.toString(),
    };
     Map<String,Object> defaultUserTweetsParam=
    {
      "variables":"{\"userId\":\"160534877\",\"count\":20,\"includePromotedContent\":true,\"withQuickPromoteEligibilityTweetFields\":true,\"withVoice\":true,\"withV2Timeline\":true}",
      "features":"{\"rweb_lists_timeline_redesign_enabled\":true,\"responsive_web_graphql_exclude_directive_enabled\":true,\"verified_phone_label_enabled\":false,\"creator_subscriptions_tweet_preview_api_enabled\":true,\"responsive_web_graphql_timeline_navigation_enabled\":true,\"responsive_web_graphql_skip_user_profile_image_extensions_enabled\":false,\"tweetypie_unmention_optimization_enabled\":true,\"responsive_web_edit_tweet_api_enabled\":true,\"graphql_is_translatable_rweb_tweet_is_translatable_enabled\":true,\"view_counts_everywhere_api_enabled\":true,\"longform_notetweets_consumption_enabled\":true,\"responsive_web_twitter_article_tweet_consumption_enabled\":false,\"tweet_awards_web_tipping_enabled\":false,\"freedom_of_speech_not_reach_fetch_enabled\":true,\"standardized_nudges_misinfo\":true,\"tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled\":true,\"longform_notetweets_rich_text_read_enabled\":true,\"longform_notetweets_inline_media_enabled\":true,\"responsive_web_media_download_video_enabled\":false,\"responsive_web_enhance_cards_enabled\":false}",
      "fieldToggles":"{\"withAuxiliaryUserLabels\":false,\"withArticleRichContentState\":false}"
    };

    Map<String, dynamic> variables=json.decode(defaultUserTweetsParam["variables"].toString());
     variables["userId"]=id;
    if (cursor != null) {
      variables['cursor'] = cursor;
    }
    variables['count'] = count;
    defaultUserTweetsParam["variables"]=json.encode(variables);

    var response = await _twitterApi.client.get(Uri.https('twitter.com', '/i/api/graphql/2GIWTr7XwadIixZDtyXd4A/UserTweets', defaultUserTweetsParam));
    var result = json.decode(response.body);
    //if this page is not first one on the profile page, dont add pinned tweet
    if(variables['cursor'] != null)
      showPinnedTweet=false;
    return createUnconversationedChains(result, 'tweet', pinnedTweets, includeReplies == false,
        includeReplies,showPinnedTweet,getTweetsCounter,incrementTweetsCounter,filterModel:filterModel);
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
      var content = cursorEntry['content'];
      if (content.containsKey('value')) {
        cursor = content['value'];
      } else if (content.containsKey('operation')) {
        cursor = content['operation']['cursor']['value'];
      } else {
        cursor = content['itemContent']['value'];
      }
    } else {
      // Look for a "replaceEntry" with the cursor
      var cursorReplaceEntry =
        repEntries.firstWhere((e) => e.containsKey('replaceEntry') ? e['replaceEntry']['entryIdToReplace'].contains(type) : e['entry']['content']['cursorType'].contains(type), orElse: () => null);

      if (cursorReplaceEntry != null) {
        cursor = cursorReplaceEntry.containsKey('replaceEntry') ? cursorReplaceEntry['replaceEntry']['entry']['content']['operation']['cursor']['value'] : cursorReplaceEntry['entry']['content']['value'];
      }
    }

    return cursor;
  }
  static TweetStatus createUnconversationedChains(
      Map<String, dynamic> result, String tweetIndicator, List<String> pinnedTweets,
      bool mapToThreads, bool includeReplies,bool showPinnedTweet, int Function() getTweetsCounter,
      void Function() increaseTweetCounter, {required FilterModel filterModel}
      ) {
    var instructions = List.from(result["data"]["user"]["result"]["timeline_v2"]['timeline']['instructions']);
    var addEntriesInstructions = instructions.firstWhereOrNull((e) => e['type'] == 'TimelineAddEntries');
    if (addEntriesInstructions == null) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }
    var addPinnedTweetsInstructions = instructions.firstWhereOrNull((e) => e['type'] == 'TimelinePinEntry');
    var addEntries = List.from(addEntriesInstructions['entries']);
    var repEntries = List.from(instructions.where((e) => e['type'] == 'TimelineReplaceEntry'));
    List addPinnedEntries = List<dynamic>.empty(growable: true);
    if (addPinnedTweetsInstructions != null) {
        addPinnedEntries.add(addPinnedTweetsInstructions['entry'] ?? null);
  }

    String? cursorBottom = getCursor(addEntries, repEntries, 'cursor-bottom', 'Bottom');
    String? cursorTop = getCursor(addEntries, repEntries, 'cursor-top', 'Top');
    var chains = createTweets(addEntries,filterModel);
   // var debugTweets = json.encode(chains);
    //var debugTweets2 = json.encode(addEntries);
    var pinnedChains =createTweets(addPinnedEntries,filterModel,true);


   // Order all the conversations by newest first (assuming the ID is an incrementing key),
    // and create a chain from them
      chains.sort((a, b){
      return  b.id!.compareTo(a.id!);});

    //If we want to show pinned tweets, add them before the others that we already have
    if (pinnedTweets.isNotEmpty & showPinnedTweet) {
      chains.insertAll(0, pinnedChains);
    }
    //To prevent infinte loading of tweets while filtering via regex , we have to count added tweets.
    //(infinite loading originating in paged_silver_builder.dart at line 246)
    if(chains.length < 5)
      increaseTweetCounter();
    //As soon as there is no tweet left that passes regex critera and we also reached maximum attemps
    //to find them, than stop loading more.
    if(chains.length <= 5 && getTweetsCounter()>filterModel.GetLoadTweetsCounter()) {
      cursorBottom=null;
    }
    return TweetStatus(chains: chains, cursorBottom: cursorBottom, cursorTop: cursorTop);
  }

  static TweetStatus createTimelineChains(
      Map<String, dynamic> result, String tweetIndicator, List<String> pinnedTweets,
      bool mapToThreads, bool includeReplies,bool showPinnedTweet, int Function() getTweetsCounter,
      void Function() increaseTweetCounter, {required FilterModel filterModel}
      ) {
    var instructions = List.from(result["data"]["home"]["home_timeline_urt"]['instructions']);
    var addEntriesInstructions = instructions.firstWhereOrNull((e) => e['type'] == 'TimelineAddEntries');
    if (addEntriesInstructions == null) {
      return TweetStatus(chains: [], cursorBottom: null, cursorTop: null);
    }
    var addPinnedTweetsInstructions = instructions.firstWhereOrNull((e) => e['type'] == 'TimelinePinEntry');
    var addEntries = List.from(addEntriesInstructions['entries']);
    var repEntries = List.from(instructions.where((e) => e['type'] == 'TimelineReplaceEntry'));
    List addPinnedEntries = List<dynamic>.empty(growable: true);
    if (addPinnedTweetsInstructions != null) {
      addPinnedEntries.add(addPinnedTweetsInstructions['entry'] ?? null);
    }

    String? cursorBottom = getCursor(addEntries, repEntries, 'cursor-bottom', 'Bottom');
    String? cursorTop = getCursor(addEntries, repEntries, 'cursor-top', 'Top');
    var chains = createTweets(addEntries,filterModel);
    // var debugTweets = json.encode(chains);
    //var debugTweets2 = json.encode(addEntries);
    var pinnedChains =createTweets(addPinnedEntries,filterModel,true);


    // Order all the conversations by newest first (assuming the ID is an incrementing key),
    // and create a chain from them
    chains.sort((a, b){
      return  b.id!.compareTo(a.id!);});

    //If we want to show pinned tweets, add them before the others that we already have
    if (pinnedTweets.isNotEmpty & showPinnedTweet) {
      chains.insertAll(0, pinnedChains);
    }
    //To prevent infinte loading of tweets while filtering via regex , we have to count added tweets.
    //(infinite loading originating in paged_silver_builder.dart at line 246)
    if(chains.length < 5)
      increaseTweetCounter();
    //As soon as there is no tweet left that passes regex critera and we also reached maximum attemps
    //to find them, than stop loading more.
    if(chains.length <= 5 && getTweetsCounter()>filterModel.GetLoadTweetsCounter()) {
      cursorBottom=null;
    }
    return TweetStatus(chains: chains, cursorBottom: cursorBottom, cursorTop: cursorTop);
  }
  static Future<List<UserWithExtra>> getUsers(Iterable<String> ids) async {
    // Split into groups of 100, as the API only supports that many at a time
    List<Future<List<UserWithExtra>>> futures = [];

    var groups = partition(ids, 100);
    for (var group in groups) {
      futures.add(_getUsersPage(group));
    }

    return (await Future.wait(futures)).expand((element) => element).toList();
  }

  static Future<List<UserWithExtra>> _getUsersPage(Iterable<String> ids) async {
    var response = await _twitterApi.client.get(Uri.https('api.twitter.com', '/1.1/users/lookup.json', {
      'user_id': ids.join(','),
    }));

    var result = json.decode(response.body);

    return List.from(result).map((e) => UserWithExtra.fromJson(e)).toList(growable: false);
  }

  static Map<String, TweetWithCard> _createTweets(
      String entryPrefix, Map<String, dynamic> result, bool includeReplies) {
    var globalTweets = result['globalObjects']['tweets'] as Map<String, dynamic>;
    var globalUsers = result['globalObjects']['users'];

    bool includeTweet(dynamic t) {
      if (includeReplies) {
        return true;
      }

      return t['in_reply_to_status_id'] == null || t['in_reply_to_user_id'] == null;
    }

    var tweets = globalTweets.values
        .where(includeTweet)
        .map((e) => TweetWithCard.fromCardJson(globalTweets, globalUsers, e))
        .toList();

    return {for (var e in tweets) e.idStr!: e};
  }

  static Future<Map<String, dynamic>> getBroadcastDetails(String key) async {
    var response = await _twitterApi.client.get(Uri.https('twitter.com', '/i/api/1.1/live_video_stream/status/$key'));

    return json.decode(response.body);
  }
}

class TweetWithCard extends Tweet {
  String? noteText;
  Map<String, dynamic>? card;
  String? conversationIdStr;
  TweetWithCard? quotedStatusWithCard;
  TweetWithCard? retweetedStatusWithCard;
  bool? isTombstone;

  TweetWithCard();

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['card'] = card;
    json['conversationIdStr'] = conversationIdStr;
    json['quotedStatusWithCard'] = quotedStatusWithCard?.toJson();
    json['retweetedStatusWithCard'] = retweetedStatusWithCard?.toJson();
    json['isTombstone'] = isTombstone;

    return json;
  }

  factory TweetWithCard.tombstone(dynamic e) {
    var tweetWithCard = TweetWithCard();
    tweetWithCard.idStr = '';
    tweetWithCard.isTombstone = true;
    tweetWithCard.text = ((e['richText']?['text'] ?? e['text']?['text'] ?? L10n.current.this_tweet_is_unavailable) as String)
        .replaceFirst(' Learn more', '');

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

  factory TweetWithCard.fromGraphqlJson(Map<String, dynamic> result) {
    var retweetedStatus;
     // if(result['tweet']!= null){
     //   int a=1;
     // }
    if(result['tweet']!= null)
      result=result['tweet'];
    else if(result['legacy']?['retweeted_status_result']?['result']!=null) {
      retweetedStatus=TweetWithCard.fromGraphqlJson(result['legacy']['retweeted_status_result']['result']);
    }
    else {
      retweetedStatus=null;
    }
    var quotedStatus = result['quoted_status_result'] == null ||
        result['quoted_status_result']['result']["__typename"]=="TweetWithVisibilityResults" ? null : TweetWithCard.fromGraphqlJson(result['quoted_status_result']['result']);
    var resCore = result['core']?['user_results']?['result'];
    var user = resCore?['legacy'] == null ? null : UserWithExtra.fromJson({...resCore['legacy'], 'id_str': resCore['rest_id'], 'ext_is_blue_verified': resCore['is_blue_verified']});

    String? noteText;
    Entities? noteEntities;
    var noteResult = result['note_tweet']?['note_tweet_results']?['result'];
    if (noteResult != null) {
      noteText = noteResult['text'];
      noteEntities = Entities.fromJson(noteResult['entity_set']);
    }
    if(result['tombstone'] != null){
      TweetWithCard tweet = TweetWithCard.tombstone(result['tombstone']);
      return tweet;
    }
    TweetWithCard tweet = TweetWithCard.fromData(result['legacy'], noteText, noteEntities, user, retweetedStatus, quotedStatus);
    if (tweet.card == null && result['card']?['legacy'] != null) {
      tweet.card = result['card']['legacy'];
      List bindingValuesList = tweet.card!['binding_values'] as List;
      Map<String, dynamic> bindingValues = bindingValuesList.fold({}, (prev, elm) { prev[elm['key']] = elm['value']; return prev; });
      tweet.card!['binding_values'] = bindingValues;
    }
    return tweet;
  }

  factory TweetWithCard.fromCardJson(Map<String, dynamic> tweets, Map<String, dynamic> users, Map<String, dynamic> e) {
    var user = e['user_id_str'] == null ? null : UserWithExtra.fromJson(users[e['user_id_str']]);

    var retweetedStatus = e['retweeted_status_id_str'] == null
        ? null
        : TweetWithCard.fromCardJson(tweets, users, tweets[e['retweeted_status_id_str']]);

    // Some quotes aren't returned, even though we're given their ID, so double check and don't fail with a null value
    TweetWithCard? quotedStatus;
    var quoteId = e['quoted_status_id_str'];
    if (quoteId != null && tweets[quoteId] != null) {
      quotedStatus = TweetWithCard.fromCardJson(tweets, users, tweets[quoteId]);
    }

    return TweetWithCard.fromData(e, null, null, user, retweetedStatus, quotedStatus);
  }

  factory TweetWithCard.fromData(Map<String, dynamic> e, String? noteText, Entities? noteEntities, UserWithExtra? user, TweetWithCard? retweetedStatus, TweetWithCard? quotedStatus) {
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
    tweet.possiblySensitive = e['possibly_sensitive'] as bool?;
    tweet.quoteCount = e['quote_count'] as int?;
    tweet.quotedStatusIdStr = e['quoted_status_id_str'] as String?;
    tweet.quotedStatusPermalink =
    e['quoted_status_permalink'] == null ? null : QuotedStatusPermalink.fromJson(e['quoted_status_permalink']);
    tweet.replyCount = e['reply_count'] as int?;
    tweet.retweetCount = e['retweet_count'] as int?;
    tweet.retweeted = e['retweeted'] as bool?;
    tweet.source = e['source'] as String?;
    tweet.text = e['text'] ?? e['full_text'] as String?;
    tweet.user = user;

    tweet.retweetedStatus = retweetedStatus;
    tweet.retweetedStatusWithCard = retweetedStatus;
    tweet.quotedStatus = quotedStatus;
    tweet.quotedStatusWithCard = quotedStatus;

    tweet.displayTextRange = (e['display_text_range'] as List<dynamic>?)?.map((e) => e as int).toList();

    // TODO
    tweet.coordinates = null;
    tweet.truncated = null;
    tweet.place = null;
    tweet.possiblySensitiveAppealable = null;

    Entities copyEntities(Entities src, Entities trg) {
      if (src.media != null) {
        trg.media = src.media;
      }
      if (src.urls != null) {
        trg.urls = src.urls;
      }
      if (src.userMentions != null) {
        trg.userMentions = src.userMentions;
      }
      if (src.hashtags != null) {
        trg.hashtags = src.hashtags;
      }
      if (src.symbols != null) {
        trg.symbols = src.symbols;
      }
      if (src.polls != null) {
        trg.polls = src.polls;
      }
      return trg;
    }

    tweet.noteText = noteText;
    if (noteEntities != null) {
      tweet.entities = tweet.entities == null ? noteEntities : copyEntities(noteEntities, tweet.entities!);
      tweet.extendedEntities = tweet.extendedEntities == null ? noteEntities : copyEntities(noteEntities, tweet.extendedEntities!);
    }

    return tweet;
  }

}

class TweetChain {
  final String id;
  final List<TweetWithCard> tweets;
  final bool isPinned;

  TweetChain({required this.id, required this.tweets, required this.isPinned});

  factory TweetChain.fromJson(Map<String, dynamic> e) {
    var tweets = List.from(e['tweets'])
        .map((e) => TweetWithCard.fromJson(e))
        .toList();

    return TweetChain(id: e['id'], tweets: tweets, isPinned: e['isPinned']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tweets': tweets.map((e) => e.toJson()).toList(),
      'isPinned': isPinned
    };
  }
}

class Follows {
  final int? cursorBottom;
  final int? cursorTop;
  final List<UserWithExtra> users;

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
  final String uri;
  final int code;
  final String message;

  TwitterError({required this.uri, required this.code, required this.message});

  @override
  String toString() {
    return 'TwitterError{code: $code, message: $message, url: $uri}';
  }
}

class UnknownTimelineItemType with SyntheticException implements Exception {
  final String type;
  final String entryId;

  UnknownTimelineItemType(this.type, this.entryId);

  @override
  String toString() {
    return 'Unknown timeline item type: {type: $type, entryId: $entryId}';
  }
}
