class User {
  final String username;
  final String password;
  String access_token;
  String role;

  User(
      {required this.username,
      required this.password,
      this.access_token = "",
      this.role = ""});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
