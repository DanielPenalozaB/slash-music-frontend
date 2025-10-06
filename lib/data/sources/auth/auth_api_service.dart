import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:slash_music_frontend/core/constants/api_urls.dart';
import 'package:slash_music_frontend/core/network/dio_client.dart';
import 'package:slash_music_frontend/data/models/auth/auth_response.dart';
import 'package:slash_music_frontend/data/models/auth/signin_request.dart';
import 'package:slash_music_frontend/data/models/auth/signup_request.dart';

abstract class AuthApiService {
  Future<Either<String, AuthResponse>> signup(SignupRequest request);
  Future<Either<String, AuthResponse>> signin(SigninRequest request);
  Future<Either<String, void>> logout();
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient _dioClient;

  AuthApiServiceImpl(this._dioClient);

  @override
  Future<Either<String, AuthResponse>> signup(SignupRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        ApiUrls.register,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(AuthResponse.fromJson(response.data));
      }

      return Left(response.data['message'] ?? 'Signup failed');
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<Either<String, AuthResponse>> signin(SigninRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        ApiUrls.login,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(AuthResponse.fromJson(response.data));
      }

      return Left(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      final response = await _dioClient.dio.post(ApiUrls.logout);

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(response.data['message'] ?? 'Logout failed');
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout';
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map) {
          return data['message'] ?? 'Server error';
        }
        return 'Server error';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error. Please check your connection.';
    }
  }
}

