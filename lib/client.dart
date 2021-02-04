import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:fritter/models.dart';
import 'package:intl/intl.dart';

class TwitterClient {
  static final String BASE_URL = 'https://nitter.42l.fr';
  static final RegExp ONLY_NUMBERS = new RegExp(r'[^0-9]');

  static Future<Profile> getProfile(String profile) async {
    var document = await scrapePage('$BASE_URL/$profile');

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
    var document = await scrapePage('$BASE_URL/$username/status/$id');
    
    return mapNodeToTweet(document.querySelector('.conversation'));
  }

  static Future<Iterable<Tweet>> searchTweets(String query) async {
    var document = await scrapePage('$BASE_URL/search?f=tweets&q=${Uri.encodeQueryComponent(query)}');

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
    var document = await scrapePage('$BASE_URL/search?f=users&q=${Uri.encodeQueryComponent(query)}');

    return document.querySelectorAll('.timeline > .timeline-item')
        .map((e) => mapNodeToUser(e));
  }

  static Future<Document> scrapePage(String uri) async {
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
  }

  static int extractNumbers(String text) {
    return int.parse(text.replaceAll(ONLY_NUMBERS, ''));
  }

  static Profile mapNodeToProfile(Element e, Iterable<Tweet> tweets) {
    var bannerElement = e.querySelector('.profile-banner img');
    var banner = bannerElement == null
        ? null
        : '$BASE_URL${bannerElement.attributes['src']}';

    var avatar = '$BASE_URL${e.querySelector('.profile-card-avatar img').attributes['src']}';
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
        src = '$BASE_URL${e.querySelector('source').attributes['src']}';
        type = 'gif';
      } else if (e.classes.contains('gallery-video')) {
        src = Uri.decodeFull(e.querySelector('video').attributes['data-url'].split('/')[3]);
        type = 'video';
      } else if (e.classes.contains('gallery-row')) {
        src = '$BASE_URL${e.querySelector('img').attributes['src']}';
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
    var numberOfComments = int.parse(e.querySelector('.tweet-stat .icon-comment').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    var numberOfLikes = int.parse(e.querySelector('.tweet-stat .icon-heart').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    var numberOfQuotes = int.parse(e.querySelector('.tweet-stat .icon-quote').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    var numberOfRetweets = int.parse(e.querySelector('.tweet-stat .icon-retweet').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    var retweet = e.querySelector('.retweet-header') != null;
    var userAvatar = '$BASE_URL${e.querySelector('.tweet-avatar img').attributes['src']}';
    var userFullName = e.querySelector('.tweet-name-row .fullname').text;
    var userUsername = e.querySelector('.tweet-name-row .username').text;

    return Tweet(attachments, comments, content, date, link, numberOfComments, numberOfLikes, numberOfQuotes, numberOfRetweets, retweet, userAvatar, userFullName, userUsername);
  }

  static User mapNodeToUser(Element e) {
    var avatar = '$BASE_URL${e.querySelector('.tweet-avatar img').attributes['src']}';
    var fullName = e.querySelector('.tweet-header .fullname').text;
    var username = e.querySelector('.tweet-header .username').text;
    var verified = e.querySelector('.tweet-header .verified-icon') != null;

    return User(avatar, fullName, username, verified);
  }
}