import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CancelBookingRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// POST `v1/bookings/updateBooking` — sets status to CANCELLED (see API contract).
  ///
  /// Body:
  /// `{ "bookingId": "…", "cancellationFee": 0, "bookingStatus": "CANCELLED" }`
  Future<void> cancelBooking({
    required String bookingId,
    required String accessToken,
    int cancellationFee = 0,
  }) async {
    final id = bookingId.trim();
    if (id.isEmpty) {
      throw Exception('Booking id is empty');
    }

    final uri = Uri.parse('$baseUrl/v1/bookings/updateBooking');
    final bodyMap = <String, dynamic>{
      'bookingId': id,
      'cancellationFee': cancellationFee,
      'bookingStatus': 'CANCELLED',
    };
    final body = jsonEncode(bodyMap);

    log('updateBooking (cancel) → POST $uri body=$body');

    final auth = AuthService.authorizationHeader(accessToken);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (auth.isNotEmpty) 'Authorization': auth,
      },
      body: body,
    );

    log(
      'updateBooking (cancel) ← status=${response.statusCode} ${response.body}',
    );

    if (response.body.trim().isNotEmpty) {
      try {
        final decoded = json.decode(response.body);
        if (decoded is Map) {
          final m = Map<String, dynamic>.from(decoded);
          final s = m['success'];
          final ok =
              s == true ||
              s == 1 ||
              (s is String &&
                  (s.toLowerCase() == 'true' || s.trim() == '1'));
          if (m.containsKey('success') && !ok) {
            final msg =
                m['message']?.toString() ?? 'Could not cancel booking.';
            throw Exception(msg);
          }
        }
      } on FormatException {
        // Non-JSON body: fall through to status check
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        _httpErrorMessage(response.statusCode, response.body),
      );
    }
  }

  String _httpErrorMessage(int status, String body) {
    if (body.trim().isEmpty) {
      return 'Cancel failed ($status).';
    }
    try {
      final decoded = json.decode(body);
      if (decoded is Map && decoded['message'] != null) {
        return decoded['message'].toString();
      }
    } catch (_) {}
    final excerpt =
        body.length > 200 ? '${body.substring(0, 200)}…' : body;
    return 'Cancel failed ($status). $excerpt';
  }
}
