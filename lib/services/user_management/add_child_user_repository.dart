import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/models/add_child_user_request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AddChildUserRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// POST `v1/company/addChildUser?parentCompanyid=` — auth header raw token.
  Future<void> addChildUser({
    required String parentCompanyId,
    required AddChildUserRequest request,
    required String accessToken,
  }) async {
    final trimmedParent = parentCompanyId.trim();
    if (trimmedParent.isEmpty) {
      throw Exception('Parent company id is empty');
    }

    final uri = Uri.parse('$baseUrl/v1/company/addChildUser').replace(
      queryParameters: <String, String>{
        'parentCompanyid': trimmedParent,
      },
    );

    final body = jsonEncode(request.toJson());

    log('addChildUser → POST $uri bodyLen=${body.length}');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': accessToken.trim(),
      },
      body: body,
    );

    log(
      'addChildUser ← status=${response.statusCode} '
      '${response.body.length > 400 ? response.body.substring(0, 400) : response.body}',
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Request failed (${response.statusCode}). ${response.body}',
      );
    }

    if (response.body.trim().isEmpty) return;

    try {
      final decoded = json.decode(response.body);
      if (decoded is Map && decoded['success'] == false) {
        final msg = decoded['message']?.toString() ?? 'Request failed';
        throw Exception(msg);
      }
    } catch (e) {
      if (e is FormatException) return;
      rethrow;
    }
  }
}
