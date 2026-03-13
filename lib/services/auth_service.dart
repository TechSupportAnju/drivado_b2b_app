import 'package:drivado_b2b_app/screens/auth/auth_models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyEmail = 'user_email';
  static const String _keyExtraAccessToken = 'extra_access_token';

  static Future<void> saveLogin({
    required LoginResponseModel loginResponse,
    required String email,
    String? extraAccessToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyEmail, email);
    if (loginResponse.accessToken != null && loginResponse.accessToken!.isNotEmpty) {
      await prefs.setString(_keyAccessToken, loginResponse.accessToken!);
    }
    if (loginResponse.refreshToken != null && loginResponse.refreshToken!.isNotEmpty) {
      await prefs.setString(_keyRefreshToken, loginResponse.refreshToken!);
    }
    if (extraAccessToken != null && extraAccessToken.isNotEmpty) {
      await prefs.setString(_keyExtraAccessToken, extraAccessToken);
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyRefreshToken);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyExtraAccessToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  static Future<String?> getExtraAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyExtraAccessToken);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }
}

