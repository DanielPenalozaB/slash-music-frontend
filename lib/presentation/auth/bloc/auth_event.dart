import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignupButtonPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const SignupButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class SigninButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const SigninButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutButtonPressed extends AuthEvent {}

