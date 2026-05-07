import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/models/user_info_model.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';

/// Email-like tokens extracted from arbitrary display strings (`Name <user@host>`).
final RegExp _emailInTextPattern = RegExp(
  r'[\w.%+-]+@[\w.-]+\.[A-Za-z]{2,}',
  caseSensitive: false,
);

Set<String> _normalizedEmailsInText(String text) {
  if (text.isEmpty) return const {};
  return _emailInTextPattern
      .allMatches(text)
      .map((m) => m.group(0)!.toLowerCase().trim())
      .where((e) => e.isNotEmpty)
      .toSet();
}

/// Strip invisible unicode; trim & lowercase identity strings.
String _normIdentity(String? s) {
  if (s == null || s.isEmpty) return '';
  return s
      .trim()
      .replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '')
      .toLowerCase();
}

/// Collect identifiers for “who is logged in” across profile + session prefs.
Iterable<String> _loginIdentityCandidates(UserData user, String? prefsLoginEmail) sync* {
  final e = _normIdentity(user.email);
  if (e.isNotEmpty) yield e;

  yield* _normalizedEmailsInText(user.email ?? '');
  yield* _normalizedEmailsInText(user.userName ?? '');

  final u = _normIdentity(user.userName);
  if (u.isNotEmpty) yield u;

  final session = _normIdentity(prefsLoginEmail);
  if (session.isNotEmpty) yield session;
  yield* _normalizedEmailsInText(prefsLoginEmail ?? '');
}

bool _identifiersMatchBooking({
  required Set<String> loginIdsLower,
  required String bookedRaw,
}) {
  final bookedNorm = _normIdentity(bookedRaw);
  if (bookedNorm.isEmpty || bookedNorm == '—') return false;

  if (loginIdsLower.contains(bookedNorm)) return true;

  final inBooked = _normalizedEmailsInText(bookedRaw);
  if (inBooked.any(loginIdsLower.contains)) return true;

  final loginEmails = loginIdsLower.where((e) => e.contains('@')).toSet();
  for (final le in loginEmails) {
    if (bookedNorm.contains(le)) return true;
  }
  return false;
}

/// Visible when profile allows cancel, booking is not already cancelled, and
/// **Booked by** (or root **`userName`** on booking details) matches login identity.
bool canShowCancelBookingForDetail(
  UserInformationState userState,
  BookingDetailData detail, {
  String? prefsLoginEmail,
}) {
  if (userState is! UserInformationLoaded) return false;

  if (detail.isBookingStatusCancelled) {
    return false;
  }

  if (!(userState.userData.permission?.isCancelBookingEnabled ?? false)) {
    return false;
  }

  final loginIds =
      _loginIdentityCandidates(userState.userData, prefsLoginEmail)
          .map(_normIdentity)
          .where((x) => x.isNotEmpty)
          .toSet();

  return _identifiersMatchBooking(loginIdsLower: loginIds, bookedRaw: detail.bookedBy) ||
      _identifiersMatchBooking(
        loginIdsLower: loginIds,
        bookedRaw: detail.bookingDetailsUserName,
      );
}

