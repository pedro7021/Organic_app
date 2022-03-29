class User {
  String token;
  String name;
  String email;
  String password;
  String confirmPassword;

  User({this.email, this.password});

  User.Token(this.token);

  Map<String, dynamic> toMap() {
    return {
      "username": name,
      "email": email,
      "password": password,
    };
  }
}
