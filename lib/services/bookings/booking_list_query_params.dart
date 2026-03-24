import 'package:drivado_b2b_app/models/user_info_model.dart';

/// Query values for [getAllBookingV2] from [UserData].
class BookingListQueryParams {
  final String viewBookingPermission;
  final String companyId;
  final String userRole;
  final String userName;

  const BookingListQueryParams({
    required this.viewBookingPermission,
    required this.companyId,
    required this.userRole,
    required this.userName,
  });

  /// `manageBooking.viewBooking.permission`, `company._id`, `role`, `userName`.
  static BookingListQueryParams? tryFromUserData(UserData user) {
    final permission = _viewBookingPermission(user.permission);
    final companyId = user.company?.id?.trim() ?? '';
    final role = user.role?.trim() ?? '';
    final userName = (user.userName ?? user.email ?? '').trim();

    if (permission == null ||
        permission.isEmpty ||
        companyId.isEmpty ||
        role.isEmpty ||
        userName.isEmpty) {
      return null;
    }

    return BookingListQueryParams(
      viewBookingPermission: permission,
      companyId: companyId,
      userRole: role,
      userName: userName,
    );
  }

  /// For logs when [tryFromUserData] returns null.
  static String missingSummary(UserData user) {
    final permission = _viewBookingPermission(user.permission);
    final companyId = user.company?.id?.trim() ?? '';
    final role = user.role?.trim() ?? '';
    final userName = (user.userName ?? user.email ?? '').trim();
    final mb = user.permission?.manageBooking;
    final mbType = mb == null ? 'null' : mb.runtimeType.toString();
    return 'viewBookingPerm=$permission companyId=${companyId.isEmpty ? "(empty)" : "ok"} '
        'role=${role.isEmpty ? "(empty)" : "ok"} userName=${userName.isEmpty ? "(empty)" : "ok"} '
        'manageBooking.type=$mbType';
  }

  static String? _viewBookingPermission(PermissionData? p) {
    final mb = p?.manageBooking;
    if (mb == null) return null;
    final vb = mb['viewBooking'];
    if (vb is Map) {
      final m = Map<String, dynamic>.from(vb);
      final perm = m['permission'];
      if (perm != null && perm.toString().trim().isNotEmpty) {
        return perm.toString();
      }
    }
    return null;
  }
}
