import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookingWithVechileRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<Map<String, dynamic>> createBooking({
    required Map<String, dynamic> payload,
    String? accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl/v1/bookings/bookingWithVechile');

    final headers = <String, String>{'Content-Type': 'application/json'};
    final token = accessToken?.trim() ?? '';
    if (token.isNotEmpty) {
      headers['Authorization'] = token;
    }

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(payload),
    );

    Map<String, dynamic> decoded = <String, dynamic>{};
    if (response.body.trim().isNotEmpty) {
      final dynamic body = jsonDecode(response.body);
      if (body is Map) {
        decoded = Map<String, dynamic>.from(body);
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final msg =
          decoded['message']?.toString() ??
          'Booking failed (${response.statusCode})';
      throw Exception(msg);
    }

    if (decoded.isNotEmpty && decoded['success'] == false) {
      throw Exception(decoded['message']?.toString() ?? 'Booking failed');
    }

    return decoded;
  }
}
