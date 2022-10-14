class User {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['given_name'],
      email: json['email'],
      emailVerified: json['email_verified'],
    );
  }
}