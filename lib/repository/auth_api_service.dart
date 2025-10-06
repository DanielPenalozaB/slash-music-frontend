import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slash_music_frontend/model/auth_model.dart';
import 'package:slash_music_frontend/model/user_model.dart';
import 'package:slash_music_frontend/resource/constants.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<void> _saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessKey, access);
    await prefs.setString(Constants.refreshKey, refresh);
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse(
      '${Constants.baseUrl}/${Constants.authAPIServiceRegister}',
    );

    final payload = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    final response = await http
        .post(
          url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: payload,
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final auth = AuthModel.fromJson(json);

      // Save tokens
      await _saveTokens(auth.accessToken, auth.refreshToken);
      return UserModel.fromJson(json);
    } else {
      // Try to surface server message if present
      String serverMsg = response.body;
      try {
        final parsed = jsonDecode(response.body);
        serverMsg = parsed['message'] ?? parsed['error'] ?? response.body;
      } catch (_) {}
      throw Exception('Failed to sign up (${response.statusCode}): $serverMsg');
    }
  }

  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      '${Constants.baseUrl}/${Constants.authAPIServiceLogin}',
    );
    final payload = jsonEncode({'email': email, 'password': password});

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    // Debug: print everything
    print('=== SIGNIN REQUEST ===');
    print('URL: $url');
    print('Headers: $headers');
    print('Body: $payload');

    final response = await http
        .post(url, headers: headers, body: payload)
        .timeout(const Duration(seconds: 15));

    print('=== SIGNIN RESPONSE ===');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final auth = AuthModel.fromJson(json);

      // Save tokens
      await _saveTokens(auth.accessToken, auth.refreshToken);
      return UserModel.fromJson(json);
    } else {
      String serverMsg = response.body;
      try {
        final parsed = jsonDecode(response.body);
        serverMsg = parsed['message'] ?? parsed['error'] ?? response.body;
      } catch (_) {}
      throw Exception('Failed to sign in (${response.statusCode}): $serverMsg');
    }
  }
}
