import 'package:shared_preferences/shared_preferences.dart';
import '../../config/env.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _apiKeyKey = 'api_key';
  static const String _emailKey = 'user_email';

  /// Dummy login: cek email & password, simpan token + apiKey di local storage
  Future<bool> login(String email, String password) async {
    const dummyEmail = 'user@example.com';
    const dummyPassword = '123456';

    if (email == dummyEmail && password == dummyPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, Env.bearerToken);
      await prefs.setString(_apiKeyKey, Env.apiKey);
      await prefs.setString(_emailKey, email);
      return true;
    } else {
      return false;
    }
  }

  /// Cek login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty; // selalu return bool
  }

  /// Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_apiKeyKey);
    await prefs.remove(_emailKey);
  }

  /// Ambil token & apiKey
  Future<Map<String, String?>> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_tokenKey),
      'apiKey': prefs.getString(_apiKeyKey),
      'email': prefs.getString(_emailKey),
    };
  }
}
