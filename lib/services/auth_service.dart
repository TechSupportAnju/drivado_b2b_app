import 'package:drivado_b2b_app/screens/auth/auth_models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyEmail = 'user_email';
  static const String _keyExtraAccessToken = 'extra_access_token';
  static const String _keyRememberMe = 'remember_me';
  static const String _keySavedEmail = 'saved_email';
  static const String _keySavedPassword = 'saved_password';

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
    // Fresh token from `/user/access_Token` overrides login token (single access token).
    if (extraAccessToken != null && extraAccessToken.isNotEmpty) {
      await prefs.setString(_keyAccessToken, extraAccessToken);
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

  /// Overwrites stored access token (e.g. after `/user/access_Token` on each app open).
  static Future<void> saveAccessToken(String token) async {
    if (token.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, token);
  }

  static Future<String?> getExtraAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyExtraAccessToken);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  /// Remember me: save email and password (only when user checks Remember me).
  /// Not cleared on logout so last credentials can be restored.
  static Future<void> saveRememberMeCredentials({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, true);
    await prefs.setString(_keySavedEmail, email);
    await prefs.setString(_keySavedPassword, password);
  }

  static Future<void> clearRememberMeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, false);
    await prefs.remove(_keySavedEmail);
    await prefs.remove(_keySavedPassword);
  }

  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberMe) ?? false;
  }

  static Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySavedEmail);
  }

  static Future<String?> getSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySavedPassword);
  }
}

