import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CancelBookingRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// POST `v1/bookings/cancelBooking` — [accessToken] raw Bearer-style value.
  Future<void> cancelBooking({
    required String bookingId,
    required String accessToken,
  }) async {
    final id = bookingId.trim();
    if (id.isEmpty) {
      throw Exception('Booking id is empty');
    }

    final uri = Uri.parse('$baseUrl/v1/bookings/cancelBooking');
    final body = jsonEncode(<String, String>{'bookingId': id});

    log('cancelBooking → POST $uri');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': accessToken.trim(),
      },
      body: body,
    );

    log('cancelBooking ← status=${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Cancel failed (${response.statusCode}). ${response.body}',
      );
    }

    if (response.body.trim().isEmpty) return;

    try {
      final decoded = json.decode(response.body);
      if (decoded is Map && decoded['success'] == false) {
        final msg = decoded['message']?.toString() ?? 'Cancel failed';
        throw Exception(msg);
      }
    } on FormatException {
      return;
    }
  }
}
