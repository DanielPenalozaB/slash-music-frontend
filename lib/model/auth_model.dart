class AuthModel {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String email;
  final String name;
  final String role;
  final String status;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      id: json['user']?['id'] ?? '',
      email: json['user']?['email'] ?? '',
      name: json['user']?['name'] ?? '',
      role: json['user']?['role'] ?? '',
      status: json['user']?['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'id': id,
    'email': email,
    'name': name,
    'role': role,
    'status': status,
  };
}
