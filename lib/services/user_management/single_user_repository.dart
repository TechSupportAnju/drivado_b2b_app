import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/models/single_user_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SingleUserRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<SingleUserResponse> getSingleUser({
    required String userId,
    required String accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl/v1/company/getSingleUser').replace(
      queryParameters: <String, String>{'userid': userId},
    );

    log('getSingleUser → GET $uri');

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (accessToken.isNotEmpty) 'Authorization': accessToken,
      },
    );

    log('getSingleUser ← status=${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load user (${response.statusCode})');
    }

    final decoded = json.decode(response.body);
    if (decoded is! Map) {
      throw Exception('Invalid user response');
    }
    return SingleUserResponse.fromJson(Map<String, dynamic>.from(decoded));
  }
}
