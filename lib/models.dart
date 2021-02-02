class Media {
  final String src;
  final String type;

  Media(this.src, this.type);
}

class Profile {
  final String avatar;
  final String banner;
  final String fullName;
  final int numberOfFollowers;
  final int numberOfFollowing;
  final int numberOfTweets;
  final Iterable<Tweet> tweets;
  final String username;
  final bool verified;

  Profile(this.avatar, this.banner, this.fullName, this.numberOfFollowers, this.numberOfFollowing, this.numberOfTweets, this.tweets, this.username, this.verified);
}

class Tweet {
  final List<Media> attachments;
  final String content;
  final DateTime date;
  final String link;
  final int numberOfComments;
  final int numberOfLikes;
  final int numberOfQuotes;
  final int numberOfRetweets;
  final bool retweet;
  final String userAvatar;
  final String userFullName;
  final String userUsername;

  Tweet(this.attachments, this.content, this.date, this.link, this.numberOfComments, this.numberOfLikes, this.numberOfQuotes, this.numberOfRetweets, this.retweet, this.userAvatar, this.userFullName, this.userUsername);
}