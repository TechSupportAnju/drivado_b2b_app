import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Default company `availableLimit` when profile has no value (API contract sample).
const int _kCancelFlowDefaultCompanyAvailableLimit = 1000000;

class CancelBookingRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// 1. `PATCH v1/user/updateUser?id=` — `{ "unpaidBooking": 0 }`
  /// 2. `PATCH v1/company/updateCompany?id=` — `{ "totalUnpaidBooking": 0, "availableLimit": … }`
  /// 3. `PATCH v1/bookings/updateBooking` — cancel booking
  ///
  /// Pre-steps are skipped only when [profileUserId] or [companyId] is null/empty
  /// (booking cancel still attempted).
  Future<void> cancelBooking({
    required String bookingId,
    required String accessToken,
    String? profileUserId,
    String? companyId,
    int? companyAvailableLimit,
    int cancellationFee = 0,
  }) async {
    final id = bookingId.trim();
    if (id.isEmpty) {
      throw Exception('Booking id is empty');
    }

    final auth = AuthService.authorizationHeader(accessToken);
    final uid = profileUserId?.trim() ?? '';
    final cid = companyId?.trim() ?? '';

    if (uid.isNotEmpty) {
      final uri = Uri.parse('$baseUrl/v1/user/updateUser').replace(
        queryParameters: {'id': uid},
      );
      log('cancel flow → PATCH $uri body={"unpaidBooking":0}');
      await _patchJsonExpectSuccess(
        uri: uri,
        authHeader: auth,
        body: const {'unpaidBooking': 0},
        failurePrefix: 'updateUser before cancel',
      );
    }

    if (cid.isNotEmpty) {
      final avail = companyAvailableLimit ?? _kCancelFlowDefaultCompanyAvailableLimit;
      final uri = Uri.parse('$baseUrl/v1/company/updateCompany').replace(
        queryParameters: {'id': cid},
      );
      final companyBody = {
        'totalUnpaidBooking': 0,
        'availableLimit': avail,
      };
      log('cancel flow → PATCH $uri body=$companyBody');
      await _patchJsonExpectSuccess(
        uri: uri,
        authHeader: auth,
        body: companyBody,
        failurePrefix: 'updateCompany before cancel',
      );
    }

    final uri = Uri.parse('$baseUrl/v1/bookings/updateBooking');
    final bodyMap = <String, dynamic>{
      'bookingId': id,
      'cancellationFee': cancellationFee,
      'bookingStatus': 'CANCELLED',
    };
    final body = jsonEncode(bodyMap);

    log('updateBooking (cancel) → PATCH $uri body=$body');

    final response = await http.patch(
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

    _throwIfSuccessFieldFalse(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(_httpErrorMessage(response.statusCode, response.body));
    }
  }

  Future<void> _patchJsonExpectSuccess({
    required Uri uri,
    required String authHeader,
    required Map<String, dynamic> body,
    required String failurePrefix,
  }) async {
    final response = await http.patch(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (authHeader.isNotEmpty) 'Authorization': authHeader,
      },
      body: jsonEncode(body),
    );

    log(
      '$failurePrefix ← status=${response.statusCode} ${response.body}',
    );

    _throwIfSuccessFieldFalse(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        '$failurePrefix: ${_httpErrorMessage(response.statusCode, response.body)}',
      );
    }
  }

  void _throwIfSuccessFieldFalse(String bodyText) {
    if (bodyText.trim().isEmpty) return;
    try {
      final decoded = jsonDecode(bodyText);
      if (decoded is Map) {
        final m = Map<String, dynamic>.from(decoded);
        final s = m['success'];
        final ok = s == true ||
            s == 1 ||
            (s is String &&
                (s.toLowerCase() == 'true' || s.trim() == '1'));
        if (m.containsKey('success') && !ok) {
          final msg = m['message']?.toString() ?? 'Request failed.';
          throw Exception(msg);
        }
      }
    } on FormatException {
      // Non-JSON: ignore here; status check handled by caller.
    }
  }

  String _httpErrorMessage(int status, String body) {
    if (body.trim().isEmpty) {
      return 'Request failed ($status).';
    }
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map && decoded['message'] != null) {
        return decoded['message'].toString();
      }
    } catch (_) {}
    final excerpt =
        body.length > 200 ? '${body.substring(0, 200)}…' : body;
    return 'Request failed ($status). $excerpt';
  }
}
