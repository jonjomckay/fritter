import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:fritter/models.dart';
import 'package:intl/intl.dart';

class TwitterClient {
  static final RegExp ONLY_NUMBERS = new RegExp(r'[^0-9]');

  static int extractNumbers(String text) {
    return int.parse(text.replaceAll(ONLY_NUMBERS, ''));
  }

  static Future<Profile> getProfile(String profile) async {
    var response = await http.get('https://nitter.42l.fr/$profile', headers: {
      'Cookie': 'hlsPlayback=on'
    });

    // TODO: Handle errors, 429

    var document = parse(response.body);

    var baseUrl = 'https://nitter.42l.fr';

    var bannerElement = document.querySelector('.profile-banner img');
    var banner = bannerElement == null
        ? null
        : '$baseUrl${bannerElement.attributes['src']}';

    var avatar = '$baseUrl${document.querySelector('.profile-card-avatar img').attributes['src']}';
    var fullName = document.querySelector('.profile-card-fullname').text;
    var username = document.querySelector('.profile-card-username').text;
    var verified = document.querySelector('.profile-card-fullname .verified-icon') != null;
    var numberOfTweets = extractNumbers(document.querySelector('.profile-statlist .posts .profile-stat-num').text);
    var numberOfFollowing = extractNumbers(document.querySelector('.profile-statlist .following .profile-stat-num').text);
    var numberOfFollowers = extractNumbers(document.querySelector('.profile-statlist .followers .profile-stat-num').text);

    var tweets = document.querySelectorAll('.timeline > .timeline-item, .timeline > .thread-line').map((e) {
      // TODO: Handle threads properly
      if (e.classes.contains('thread-line')) {
        return e.children.first;
      }

      return e;
    })
        .map((e) {
      var attachments = e.querySelectorAll('.attachments > div').map((e) {
        String src = 'unknown';
        String type = 'unknown';
        if (e.classes.contains('gallery-gif')) {
          src = '$baseUrl${e.querySelector('source').attributes['src']}';
          type = 'gif';
        } else if (e.classes.contains('gallery-video')) {
          src = Uri.decodeFull(e.querySelector('video').attributes['data-url'].split('/')[3]);
          type = 'video';
        } else if (e.classes.contains('gallery-row')) {
          src = '$baseUrl${e.querySelector('img').attributes['src']}';
          type = 'image';
        } else {
          int i = 0;
        }

        return Media(src, type);
      }).toList();

      var content = e.querySelector('.tweet-content').text;
      var date = DateFormat('d/M/yyyy, H:m:s').parse(e.querySelector('.tweet-date > a').attributes['title']);
      var link = e.querySelector('.tweet-link').attributes['href'];
      var numberOfComments = int.parse(e.querySelector('.tweet-stat .icon-comment').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
      var numberOfLikes = int.parse(e.querySelector('.tweet-stat .icon-heart').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
      var numberOfQuotes = int.parse(e.querySelector('.tweet-stat .icon-quote').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
      var numberOfRetweets = int.parse(e.querySelector('.tweet-stat .icon-retweet').parent.text.replaceAll(new RegExp(r'[^0-9]'), ''));
      var retweet = e.querySelector('.retweet-header') != null;
      var userAvatar = '$baseUrl${e.querySelector('.tweet-avatar img').attributes['src']}';
      var userFullName = e.querySelector('.tweet-name-row .fullname').text;
      var userUsername = e.querySelector('.tweet-name-row .username').text;

      return Tweet(attachments, content, date, link, numberOfComments, numberOfLikes, numberOfQuotes, numberOfRetweets, retweet, userAvatar, userFullName, userUsername);
    });

    return Profile(avatar, banner, fullName, numberOfFollowers, numberOfFollowing, numberOfTweets, tweets, username, verified);
  }
}