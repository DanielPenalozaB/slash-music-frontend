class ApiUrls {
  // URL Base del backend en AWS
  static const String baseUrl = 'http://ec2-54-167-13-29.compute-1.amazonaws.com:7777';
  
  // API Version prefix
  static const String apiPrefix = '/api/v1/auth';
  
  // Endpoints de autenticación
  static const String register = '$apiPrefix/register';
  static const String login = '$apiPrefix/login';
  static const String logout = '$apiPrefix/logout';
  static const String refresh = '$apiPrefix/refresh';
  static const String me = '$apiPrefix/me';
  static const String changePassword = '$apiPrefix/change-password';
  
  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
}

