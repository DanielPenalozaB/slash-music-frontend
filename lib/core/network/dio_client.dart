import 'package:dio/dio.dart';
import 'package:slash_music_frontend/core/constants/api_urls.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors para logging y manejo de errores
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('📤 REQUEST[${options.method}] => PATH: ${options.path}');
          print('📤 DATA: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');
          print('❌ ERROR DATA: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  // Método para agregar token de autenticación
  void setAuthToken(String token) {
    _dio.options.headers[ApiUrls.authorization] = 'Bearer $token';
  }

  // Método para remover token
  void removeAuthToken() {
    _dio.options.headers.remove(ApiUrls.authorization);
  }
}

