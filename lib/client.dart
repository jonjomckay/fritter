import 'dart:developer';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:fritter/models.dart';
import 'package:intl/intl.dart';
import 'package:preferences/preference_service.dart';
import 'package:retry/retry.dart';

import 'constants.dart';

class TwitterClient {
  static final RegExp ONLY_NUMBERS = new RegExp(r'[^0-9]');

  static String getBaseUrl() {
    // Select a random instance from the user's selection, or return a random one from the whole list
    var instances = PrefService.getStringList('instances');
    if (instances == null || instances.isEmpty) {
      instances = INSTANCES.entries
          .expand((element) => element.value)
          .map((e) => e.hostname)
          .toList();
    }

    return (instances..shuffle())
        .take(1)
        .map((i) => 'https://$i')
        .first;
  }

  static Future<Profile> getProfile(String profile) async {
    var document = await scrapePage('/$profile');

    var tweets = document.querySelectorAll('.timeline > .timeline-item, .timeline > .thread-line')
        .map((e) {
          // TODO: Handle threads properly
          if (e.classes.contains('thread-line')) {
            return e.children.first;
          }

          return e;
        })
        .map((e) => mapNodeToTweet(e));

    return mapNodeToProfile(document.body, tweets);
  }

  static Future<Tweet> getStatus(String username, String id) async {
    var document = await scrapePage('/$username/status/$id');
    
    return mapNodeToTweet(document.querySelector('.conversation'));
  }

  static Future<Iterable<Tweet>> searchTweets(String query) async {
    var document = await scrapePage('/search?f=tweets&q=${Uri.encodeQueryComponent(query)}');

    // TODO: This is copied from above
    return document.querySelectorAll('.timeline > .timeline-item, .timeline > .thread-line')
        .map((e) {
          // TODO: Handle threads properly
          if (e.classes.contains('thread-line')) {
            return e.children.first;
          }

          return e;
        })
        .map((e) => mapNodeToTweet(e));
  }

  static Future<Iterable<User>> searchUsers(String query) async {
    var document = await scrapePage('/search?f=users&q=${Uri.encodeQueryComponent(query)}');

    return document.querySelectorAll('.timeline > .timeline-item')
        .map((e) => mapNodeToUser(e));
  }

  static Future<Document> scrapePage(String path) async {
    return await retry(() async {
        var uri = '${getBaseUrl()}$path';

        log('Scraping $uri');

        var response = await http.get(uri, headers: {
          'Cookie': 'hlsPlayback=on'
        });

        if (response.statusCode == 429) {
          throw Exception('The server has been rate limited');
        }

        if (response.statusCode != 200) {
          throw Exception('An unexpected error happened');
        }

        return parse(response.body);
      },
      retryIf: (e) => e is Exception,
      onRetry: (e) {
        log('Request failed. Retrying...');
      },
    );
  }

  static int extractNumbers(String text) {
    return int.parse(text.replaceAll(ONLY_NUMBERS, ''));
  }

  static Profile mapNodeToProfile(Element e, Iterable<Tweet> tweets) {
    var bannerElement = e.querySelector('.profile-banner img');
    var banner = bannerElement == null
        ? null
        : '${getBaseUrl()}${bannerElement.attributes['src']}';

    var avatar = '${getBaseUrl()}${e.querySelector('.profile-card-avatar img').attributes['src']}';
    var fullName = e.querySelector('.profile-card-fullname').text;
    var username = e.querySelector('.profile-card-username').text;
    var verified = e.querySelector('.profile-card-fullname .verified-icon') != null;
    var numberOfTweets = extractNumbers(e.querySelector('.profile-statlist .posts .profile-stat-num').text);
    var numberOfFollowing = extractNumbers(e.querySelector('.profile-statlist .following .profile-stat-num').text);
    var numberOfFollowers = extractNumbers(e.querySelector('.profile-statlist .followers .profile-stat-num').text);

    return Profile(avatar, banner, fullName, numberOfFollowers, numberOfFollowing, numberOfTweets, tweets, username, verified);
  }
  
  static Tweet mapNodeToTweet(Element e) {
    var attachments = e.querySelectorAll('.attachments > div').map((e) {
      String src = 'unknown';
      String type = 'unknown';
      if (e.classes.contains('gallery-gif')) {
        src = '${getBaseUrl()}${e.querySelector('source').attributes['src']}';
        type = 'gif';
      } else if (e.classes.contains('gallery-video')) {
        var video = e.querySelector('video');
        if (video == null) {
          src = null;
        }

        src = Uri.decodeFull(video.attributes['data-url'].split('/')[3]);
        type = 'video';
      } else if (e.classes.contains('gallery-row')) {
        src = '${getBaseUrl()}${e.querySelector('img').attributes['src']}';
        type = 'image';
      } else {
        int i = 0;
      }

      return Media(src, type);
    }).toList();
    
    var comments = e.querySelectorAll('.replies > .reply').map((e) {
      return mapNodeToTweet(e);
    });

    var content = e.querySelector('.tweet-content').text;
    var date = DateFormat('d/M/yyyy, H:m:s').parse(e.querySelector('.tweet-date > a').attributes['title']);
    var link = e.querySelector('.tweet-date > a').attributes['href'];
    var numberOfComments = parseElementToNumber(e, '.tweet-stat .icon-comment');
    var numberOfLikes = parseElementToNumber(e, '.tweet-stat .icon-heart');
    var numberOfQuotes = parseElementToNumber(e, '.tweet-stat .icon-quote');
    var numberOfRetweets = parseElementToNumber(e, '.tweet-stat .icon-retweet');
    var retweet = e.querySelector('.retweet-header') != null;
    var userAvatar = '${getBaseUrl()}${e.querySelector('.tweet-avatar img').attributes['src']}';
    var userFullName = e.querySelector('.tweet-name-row .fullname').text;
    var userUsername = e.querySelector('.tweet-name-row .username').text;

    return Tweet(attachments, comments, content, date, link, numberOfComments, numberOfLikes, numberOfQuotes, numberOfRetweets, retweet, userAvatar, userFullName, userUsername);
  }

  static int parseElementToNumber(Element e, String selector) {
    var element = e.querySelector(selector);
    if (element == null || element.parent == null) {
      // TODO
      return 0;
    }

    return int.parse(element.parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
  }

  static User mapNodeToUser(Element e) {
    var avatar = '${getBaseUrl()}${e.querySelector('.tweet-avatar img').attributes['src']}';
    var fullName = e.querySelector('.tweet-header .fullname').text;
    var username = e.querySelector('.tweet-header .username').text;
    var verified = e.querySelector('.tweet-header .verified-icon') != null;

    return User(avatar, fullName, username, verified);
  }
}