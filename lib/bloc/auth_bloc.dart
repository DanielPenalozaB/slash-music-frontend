import 'dart:async';

import 'package:slash_music_frontend/repository/auth_api_service.dart';
import 'package:slash_music_frontend/model/user_model.dart';

class AuthBloc {
  final AuthRepository _repository = AuthRepository();

  final _messageController = StreamController<String>.broadcast();

  Stream<String> get messages => _messageController.stream;

  void dispose() {
    _messageController.close();
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final user = await _repository.signup(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      _messageController.add('Welcome ${user.name}!');

      return user;
    } catch (e) {
      final err = e.toString();
      _messageController.add('Error registering: $err');
      rethrow;
    }
  }

  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    try {
      print('email: $email, password: $password');
      final user = await _repository.signin(email: email, password: password);
      _messageController.add('Welcome back!');
      return user;
    } catch (e) {
      print(e);
      final err = e.toString();
      _messageController.add('Error signing in: $err');
      rethrow;
    }
  }
}
