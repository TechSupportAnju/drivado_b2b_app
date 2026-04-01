import 'package:drivado_b2b_app/models/single_user_models.dart';

/// API: `GET /v1/company/getSingleUser?userid=...`
class SingleUserResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> raw;

  const SingleUserResponse({
    required this.success,
    required this.message,
    required this.raw,
  });

  factory SingleUserResponse.fromJson(Map<String, dynamic> json) {
    final s = json['success'];
    final ok = s == true ||
        s == 1 ||
        s == '1' ||
        (s != null && s.toString().toLowerCase() == 'true');

    return SingleUserResponse(
      success: ok,
      message: json['message']?.toString() ?? '',
      raw: json,
    );
  }

  SingleUserDetail? get detail => SingleUserDetail.tryParse(raw);
}
