class Country {
  final String flag;
  final String name;

  Country(this.flag, this.name);
}

class Instance {
  final String hostname;
  final String country;

  Instance(this.hostname, this.country);
}

class Media {
  final String src;
  final String type;

  Media(this.src, this.type);
}

class Profile {
  final String avatar;
  final String banner;
  final String biography;
  final String fullName;
  final int id;
  final DateTime joinDate;
  final String location;
  final int numberOfFollowers;
  final int numberOfFollowing;
  final int numberOfLikes;
  final int numberOfTweets;
  final Iterable<Tweet> tweets;
  final String username;
  final bool verified;
  final Uri websiteLink;
  final String websiteText;

  Profile(this.avatar, this.banner, this.biography, this.fullName, this.id, this.joinDate, this.location, this.numberOfFollowers, this.numberOfFollowing, this.numberOfLikes, this.numberOfTweets, this.tweets, this.username, this.verified, this.websiteLink, this.websiteText);
}

class ProfileResponse {
  final Profile profile;
  final int statusCode;

  ProfileResponse(this.profile, this.statusCode);
}

class Tweet {
  final Iterable<Media> attachments;
  final Iterable<Tweet> comments;
  final String content;
  final DateTime date;
  final String link;
  final int numberOfComments;
  final int numberOfLikes;
  final int numberOfQuotes;
  final int numberOfRetweets;
  final bool quote;
  final Tweet quotedTweet;
  final bool retweet;
  final String userAvatar;
  final String userFullName;
  final String userUsername;

  Tweet(this.attachments, this.comments, this.content, this.date, this.link, this.numberOfComments, this.numberOfLikes, this.numberOfQuotes, this.numberOfRetweets, this.quote, this.quotedTweet, this.retweet, this.userAvatar, this.userFullName, this.userUsername);

  static Tweet emptyTweet() {
    return Tweet([], [], '', DateTime.now(), '', 0, 0, 0, 0, false, null, false, '', '', '');
  }
}

class User {
  final String avatar;
  final String fullName;
  final String username;
  final bool verified;

  User(this.avatar, this.fullName, this.username, this.verified);
}