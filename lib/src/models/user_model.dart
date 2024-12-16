class UserFromDB{
  String userId;
  String username;
  String email;
  String password;
  String image;
  String phone;
  final String role;

  UserFromDB({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.image,
    required this.phone,
    required this.role
  });
  factory UserFromDB.fromJson(Map<String, dynamic> json) {
    return UserFromDB(
        userId: json['user_id'] ?? '',
        username: json['username'] ?? '',
        image: json['image'] ?? '',
        email: json['email'] ?? '',
        password: json['password_hash'] ?? '',
        phone: json['phone'] ?? '',
        role: json['role'] ?? 'user'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'image': image,
      'email': email,
      'password_hash': password,
      'phone': phone,
      'role': role
    };
  }
}