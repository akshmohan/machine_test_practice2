class UserModel {
  final String? username;
  final String accesstoken;

  UserModel({
    this.username,
    required this.accesstoken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      accesstoken: json['accessToken'] ?? '',
    );
  }
}
