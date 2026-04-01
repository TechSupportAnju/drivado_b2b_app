import 'dart:convert';

import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookingDetailRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// GET `v1/bookings?id=` — no auth headers.
  Future<BookingDetailData> getBookingDetail(String bookingId) async {
    final trimmed = bookingId.trim();
    if (trimmed.isEmpty) {
      throw Exception('Booking id is empty');
    }

    final uri = Uri.parse('$baseUrl/v1/bookings').replace(
      queryParameters: {'id': trimmed},
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load booking (${response.statusCode})',
      );
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded is! Map) {
      throw Exception('Invalid booking response');
    }

    final root = Map<String, dynamic>.from(decoded);
    final details = root['bookingDetails'];
    if (details is! Map) {
      throw Exception('Missing bookingDetails');
    }

    return BookingDetailData.fromBookingDetailsMap(
      Map<String, dynamic>.from(details),
    );
  }
}
