class UserModel {
  final int id;
  final String email;
  final String name;
  final String role;
  final String status;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']?['id'] ?? '',
      email: json['user']?['email'] ?? '',
      name: json['user']?['name'] ?? '',
      role: json['user']?['role'] ?? '',
      status: json['user']?['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'role': role,
    'status': status,
  };
}
