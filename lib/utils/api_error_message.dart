import 'dart:convert';

/// Reads a user-facing string from typical API error JSON bodies.
String parseApiErrorMessage(String responseBody, {required String fallback}) {
  try {
    final dynamic decoded = jsonDecode(responseBody);
    if (decoded is Map<String, dynamic>) {
      final msg = decoded['message'] ?? decoded['error'] ?? decoded['msg'];
      if (msg != null && msg.toString().trim().isNotEmpty) {
        return msg.toString();
      }
    }
  } catch (_) {}
  return fallback;
}
