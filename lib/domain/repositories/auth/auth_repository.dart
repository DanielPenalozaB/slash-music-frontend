import 'package:dartz/dartz.dart';
import 'package:slash_music_frontend/data/models/auth/auth_response.dart';
import 'package:slash_music_frontend/data/models/auth/signin_request.dart';
import 'package:slash_music_frontend/data/models/auth/signup_request.dart';

abstract class AuthRepository {
  Future<Either<String, AuthResponse>> signup(SignupRequest request);
  Future<Either<String, AuthResponse>> signin(SigninRequest request);
  Future<Either<String, void>> logout();
  Future<bool> isLoggedIn();
}

