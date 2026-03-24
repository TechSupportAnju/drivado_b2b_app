import 'package:drivado_b2b_app/models/single_company_management_models.dart';

/// API: `GET /v1/company/getSingleCompany?id=...`
class SingleCompanyResponse {
  final bool success;
  final String message;

  /// Full decoded JSON body (supports `data.singleCompanyDetails` or root keys).
  final Map<String, dynamic> raw;

  const SingleCompanyResponse({
    required this.success,
    required this.message,
    required this.raw,
  });

  factory SingleCompanyResponse.fromJson(Map<String, dynamic> json) {
    return SingleCompanyResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      raw: json,
    );
  }

  /// Legacy `data` object when API wraps payload.
  Map<String, dynamic>? get data {
    final d = raw['data'];
    return d is Map ? Map<String, dynamic>.from(d) : null;
  }

  SingleCompanyManagementPayload? get managementPayload =>
      SingleCompanyManagementPayload.tryParse(raw);
}
