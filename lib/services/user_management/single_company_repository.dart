import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/models/single_company_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SingleCompanyRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// [id] — from user profile: prefer `UserData.company.id`, else `UserData.id`.
  Future<SingleCompanyResponse> getSingleCompany({
    required String id,
    required String accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl/v1/company/getSingleCompany').replace(
      queryParameters: <String, String>{'id': id},
    );

    log('getSingleCompany → GET $uri');

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (accessToken.isNotEmpty) 'Authorization': accessToken,
      },
    );

    log('getSingleCompany ← status=${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load company (${response.statusCode})');
    }

    final decoded = json.decode(response.body);
    if (decoded is! Map) {
      throw Exception('Invalid company response');
    }

    return SingleCompanyResponse.fromJson(Map<String, dynamic>.from(decoded));
  }
}
