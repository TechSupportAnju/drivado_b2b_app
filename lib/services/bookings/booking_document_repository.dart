import 'dart:convert';
import 'dart:developer';

import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/models/booking_document_mail_body.dart';
import 'package:drivado_b2b_app/models/booking_document_mail_kind.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BookingDocumentRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  /// Path segment under `v1/bookings/` for each mail type.
  static String pathFor(BookingDocumentMailKind kind) {
    switch (kind) {
      case BookingDocumentMailKind.voucher:
        return 'voucherMail';
      case BookingDocumentMailKind.invoice:
        return 'invoiceMail';
      case BookingDocumentMailKind.driverDetails:
        return 'driverdetailMail';
    }
  }

  /// POST body includes booking snapshot fields from [detail] plus [companyName] for invoice.
  Future<void> sendDocumentMail({
    required BookingDocumentMailKind kind,
    required BookingDetailData detail,
    required String email,
    required String accessToken,
    required String companyName,
  }) async {
    final path = pathFor(kind);
    final uri = Uri.parse('$baseUrl/v1/bookings/$path');

    final effectiveCompany =
        companyName.trim().isNotEmpty
            ? companyName.trim()
            : (detail.bookingCompanyName?.trim() ?? '');

    final bodyMap = BookingDocumentMailBody.build(
      kind: kind,
      email: email.trim(),
      detail: detail,
      companyName: effectiveCompany,
    );
    final body = jsonEncode(bodyMap);

    log('booking document mail → POST $uri');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: body,
    );

    log(
      'booking document mail ← status=${response.statusCode} '
      'body=${response.body.length > 300 ? response.body.substring(0, 300) : response.body}',
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Request failed (${response.statusCode}). ${response.body}',
      );
    }

    try {
      final decoded = json.decode(response.body);
      if (decoded is Map && decoded['success'] == false) {
        final msg = decoded['message']?.toString() ?? 'Request failed';
        throw Exception(msg);
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Request failed')) rethrow;
      // Non-JSON success responses are treated as OK.
    }
  }
}
