import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<bool> isLoggedIn();
}

class AuthLocalServiceImpl implements AuthLocalService {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  final SharedPreferences _prefs;

  AuthLocalServiceImpl(this._prefs);

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_refreshTokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

