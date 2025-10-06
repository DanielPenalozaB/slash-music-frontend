import 'package:dartz/dartz.dart';
import 'package:slash_music_frontend/core/usecase/usecase.dart';
import 'package:slash_music_frontend/data/models/auth/auth_response.dart';
import 'package:slash_music_frontend/data/models/auth/signin_request.dart';
import 'package:slash_music_frontend/domain/repositories/auth/auth_repository.dart';

class SigninUseCase
    implements UseCase<Either<String, AuthResponse>, SigninRequest> {
  final AuthRepository _repository;

  SigninUseCase(this._repository);

  @override
  Future<Either<String, AuthResponse>> call(SigninRequest params) {
    return _repository.signin(params);
  }
}

