class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.token = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '_id': String id,
      'name': String name,
      'email': String email,
      'phone': String phone,
      'token': String token,
      } =>
          User(
            id: id,
            name: name,
            email: email,
            phone: phone,
            token: token,
          ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}