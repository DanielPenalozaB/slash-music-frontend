import 'package:dartz/dartz.dart';
import 'package:slash_music_frontend/core/usecase/usecase.dart';
import 'package:slash_music_frontend/data/models/auth/auth_response.dart';
import 'package:slash_music_frontend/data/models/auth/signup_request.dart';
import 'package:slash_music_frontend/domain/repositories/auth/auth_repository.dart';

class SignupUseCase
    implements UseCase<Either<String, AuthResponse>, SignupRequest> {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<Either<String, AuthResponse>> call(SignupRequest params) {
    return _repository.signup(params);
  }
}

