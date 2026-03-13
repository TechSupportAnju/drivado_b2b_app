import 'dart:convert';
import 'dart:developer';
import 'package:drivado_b2b_app/screens/auth/auth_models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  final baseUrl = "https://testapi.drivado.com/api/v1";

  Future<LoginResponseModel> loginWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return LoginResponseModel.fromJson(jsonResponse);
    } else {
      final errorJson = jsonDecode(response.body);
      final message = errorJson['error'] ?? 'Email not registered';
      throw Exception(message);
    }
  }

  /// Fetch extra access token using email after successful login.
  Future<String> fetchAccessToken(String email) async {
    final uri = Uri.parse("$baseUrl/user/access_Token").replace(
      queryParameters: {'email': email},
    );
    final response = await http.post(uri);
    log('Access token response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final token = jsonResponse['accessToken'];
      if (token is String && token.isNotEmpty) {
        return token;
      }
      throw Exception('Access token not found in response');
    } else {
      try {
        final errorJson = jsonDecode(response.body);
        final message = errorJson['error'] ?? 'Failed to fetch access token';
        throw Exception(message);
      } catch (_) {
        throw Exception('Failed to fetch access token');
      }
    }
  }
}
