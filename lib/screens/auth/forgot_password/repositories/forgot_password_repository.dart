import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/utils/api_error_message.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordRepository {
  final String baseUrl = "https://testapi.drivado.com/api/v1";

  Future<void> requestReset({required String email}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/forgotPassword"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userName': email,
      }),
    );

    log(response.body.toString());

    if (response.statusCode != 200) {
      final message = parseApiErrorMessage(
        response.body,
        fallback: 'Unable to send reset email',
      );
      throw Exception(message);
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/user/resetPassword"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'otp': otp,
        'password': newPassword,
      }),
    );

    log(response.body.toString());

    if (response.statusCode != 200) {
      final message = parseApiErrorMessage(
        response.body,
        fallback: 'Unable to reset password',
      );
      throw Exception(message);
    }
  }
}

