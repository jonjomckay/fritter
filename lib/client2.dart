import 'dart:convert';
import 'dart:developer';

import 'package:faker/faker.dart';
import 'package:fritter/models.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TwitterClient2 {
  static Future<ProfileResponse> getProfile(String username) async {
    var response = await fetch('/1.1/users/show.json', {
      'screen_name': username
    });

    Profile profile;
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      profile = Profile(
          result['profile_image_url_https'].replaceAll('normal', '400x400'),
          result['profile_banner_url'],
          result['name'],
          result['id'],
          result['followers_count'],
          result['friends_count'],
          result['statuses_count'],
          [],
          result['screen_name'],
          result['verified']
      );
    }

    return ProfileResponse(profile, response.statusCode);
  }

  static Future<TweetsResponse> getTweets(int id) async {
    var response = await fetch('/2/timeline/profile/$id.json', {
      'userId': id.toString(),
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
    });

    Iterable<Tweet> tweets;
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      var globalTweets = result['globalObjects']['tweets'];
      var instructions = result['timeline']['instructions'];
      var globalUsers = result['globalObjects']['users'];

      var dateFormat = DateFormat('EEE MMM dd HH:mm:ss yyyy');

      tweets = instructions[0]['addEntries']['entries']
          .where((entry) => entry['entryId'].startsWith('tweet') as bool)
          .map<Tweet>((entry) {
        var tweet = globalTweets[entry['sortIndex']];

        var createdAt = (tweet['created_at'] as String)
            .split(' ');

        createdAt.removeAt(4);

        Iterable<Media> attachments = [];
        if (tweet['extended_entities'] != null && tweet['extended_entities']['media'] != null) {
          attachments = (tweet['extended_entities']['media'] ?? []).map<Media>((media) {
            String src = '';

            switch (media['type']) {
              case 'animated_gif':
                src = media['video_info']['variants'][0]['url'];
                break;
              case 'photo':
                src = media['media_url_https'];
                break;
              case 'video':
                src = media['video_info']['variants'][0]['url'];
                break;
              default:
                print('Unknown media type encountered: ${media['type']}');
                break;
            }


            return Media(src, media['type']);
          });
        }

        var author = globalUsers[tweet['user_id_str']];

        List<Tweet> comments = [];
        var content = tweet['full_text'];
        var date = dateFormat.parse(createdAt.join(' '));
        var link = '/${author['screen_name']}/status/${tweet['id_str']}';
        var numberOfComments = tweet['reply_count'];
        var numberOfLikes = tweet['favorite_count'];
        var numberOfQuotes = tweet['quote_count'];
        var numberOfRetweets = tweet['retweet_count'];
        var retweet = tweet['retweeted_status_id_str'] != null;
        var userAvatar = author['profile_image_url_https'];
        var userFullName = author['name'];
        var userUsername = author['screen_name'];

        return Tweet(attachments, comments, content, date, link, numberOfComments, numberOfLikes, numberOfQuotes, numberOfRetweets, retweet, userAvatar, userFullName, userUsername);
      });
    }

    return TweetsResponse(tweets, response.statusCode);
  }

  static String _token;
  static int _expiresAt;
  static int _tokenLimit;
  static int _tokenRemaining;

  static Future<String> getToken() async {
    if (_token != null) {
      // If we don't have an expiry or limit, it's probably because we haven't made a request yet, so assume they're OK
      if (_expiresAt == null && _tokenLimit == null && _tokenRemaining == null) {
        return _token;
      }

      // Check if the token we have hasn't expired yet
      if (DateTime.now().millisecondsSinceEpoch < _expiresAt) {
        // Check if the token we have still has usages remaining
        if (_tokenRemaining < _tokenLimit) {
          return _token;
        }
      }
    }

    // Otherwise, fetch a new token
    _token = null;
    _tokenLimit = null;
    _tokenRemaining = null;
    _expiresAt = null;

    var response = await http.post('https://api.twitter.com/1.1/guest/activate.json', headers: {
      'authorization': 'Bearer AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA',
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result.containsKey('guest_token')) {
        _token = result['guest_token'];

        return _token;
      }
    }

    // TODO
    int i = 0;
  }

  static Future<http.Response> fetch(String path, Map<String, String> queryParameters) async {
    // Get a valid token
    var token = await getToken();

    var uri = Uri.https('api.twitter.com', path, queryParameters);

    log('Fetching $uri');

    var response = await http.get(uri, headers: {
      'authorization': 'Bearer AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA',
      'x-guest-token': token,
      'x-twitter-active-user': 'yes',
      'user-agent': faker.internet.userAgent()
    });

    // Update our token's rate limit counters
    _expiresAt = int.parse(response.headers['x-rate-limit-reset']) * 1000;
    _tokenRemaining = int.parse(response.headers['x-rate-limit-remaining']);
    _tokenLimit = int.parse(response.headers['x-rate-limit-limit']);

    return response;

    // if (response.statusCode == 200) {
    //   return response.body;
    // }
    //
    // int i = 0;

    // TODO
  }
}