class Constants {
  static const String baseUrl = 'http://127.0.0.1:8080';
  static const String contextPath = 'api/v1';
  static const String contentTypeHeader = 'application/json';
  static const String authorizationHeader = 'Bearer ';
  static const String accessKey = 'ACCESS_TOKEN';
  static const String refreshKey = 'REFRESH_TOKEN';

  // Auth endpoints
  static const String authAPIServiceLogin = '$contextPath/auth/login';
  static const String authAPIServiceRegister = '$contextPath/auth/register';
}
