import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FlightDataRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// GET `/v1/bookings/getFlightData` — authenticated; query params match API.
  Future<Map<String, dynamic>> getFlightData({
    required String flightNumber,
    required DateTime dateLocal,
    required String accessToken,
  }) async {
    final fn = flightNumber.trim();
    if (fn.isEmpty) {
      throw Exception('Flight number is empty');
    }

    final y = DateFormat('yyyy').format(dateLocal);
    final mo = DateFormat('MM').format(dateLocal);
    final d = DateFormat('dd').format(dateLocal);

    final uri = Uri.parse('$baseUrl/v1/bookings/getFlightData').replace(
      queryParameters: {
        'flightNumber': fn,
        'year': y,
        'month': mo,
        'date': d,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken.trim(),
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Flight status request failed (${response.statusCode})',
      );
    }

    final decoded = json.decode(response.body);
    if (decoded is! Map) {
      throw Exception('Invalid flight data response');
    }

    return Map<String, dynamic>.from(decoded);
  }
}
