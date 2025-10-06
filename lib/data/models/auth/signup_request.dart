import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;

  SignupRequest({
    required this.email,
    required this.name,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

