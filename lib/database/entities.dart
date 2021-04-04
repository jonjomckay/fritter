class Following {
  final int id;
  final String screenName;
  final String name;
  final String? profileImageUrlHttps;

  Following({ required this.id, required this.screenName, required this.name, required this.profileImageUrlHttps });

  factory Following.fromMap(Map<String, Object?> map) {
    return Following(
        id: map['id'] as int,
        screenName: map['screen_name'] as String,
        name: map['name'] as String,
        profileImageUrlHttps: map['profile_image_url_https'] as String?
    );
  }
}