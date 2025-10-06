import 'package:dartz/dartz.dart';
import 'package:slash_music_frontend/core/network/dio_client.dart';
import 'package:slash_music_frontend/data/models/auth/auth_response.dart';
import 'package:slash_music_frontend/data/models/auth/signin_request.dart';
import 'package:slash_music_frontend/data/models/auth/signup_request.dart';
import 'package:slash_music_frontend/data/sources/auth/auth_api_service.dart';
import 'package:slash_music_frontend/data/sources/auth/auth_local_service.dart';
import 'package:slash_music_frontend/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;
  final AuthLocalService _localService;
  final DioClient _dioClient;

  AuthRepositoryImpl(
    this._apiService,
    this._localService,
    this._dioClient,
  );

  @override
  Future<Either<String, AuthResponse>> signup(SignupRequest request) async {
    final result = await _apiService.signup(request);

    return result.fold(
      (error) => Left(error),
      (response) async {
        await _localService.saveToken(response.accessToken);
        await _localService.saveRefreshToken(response.refreshToken);
        _dioClient.setAuthToken(response.accessToken);
        return Right(response);
      },
    );
  }

  @override
  Future<Either<String, AuthResponse>> signin(SigninRequest request) async {
    final result = await _apiService.signin(request);

    return result.fold(
      (error) => Left(error),
      (response) async {
        await _localService.saveToken(response.accessToken);
        await _localService.saveRefreshToken(response.refreshToken);
        _dioClient.setAuthToken(response.accessToken);
        return Right(response);
      },
    );
  }

  @override
  Future<Either<String, void>> logout() async {
    final result = await _apiService.logout();

    return result.fold(
      (error) => Left(error),
      (_) async {
        await _localService.clearTokens();
        _dioClient.removeAuthToken();
        return const Right(null);
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _localService.isLoggedIn();
  }
}

