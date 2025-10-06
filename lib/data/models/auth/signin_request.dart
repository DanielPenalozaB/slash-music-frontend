import 'package:json_annotation/json_annotation.dart';

part 'signin_request.g.dart';

@JsonSerializable()
class SigninRequest {
  final String email;
  final String password;

  SigninRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

