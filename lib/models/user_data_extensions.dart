import 'package:drivado_b2b_app/models/user_info_model.dart';

extension UserDataSingleCompanyQueryId on UserData {
  /// `getSingleCompany?id=` — prefer linked company `_id`, else user `_id`.
  String get singleCompanyQueryId {
    final companyId = company?.id?.trim() ?? '';
    if (companyId.isNotEmpty) return companyId;
    return id?.trim() ?? '';
  }
}

extension UserDataDisplay on UserData {
  /// Full name for profile UI; falls back to [userName].
  String get displayName {
    final first = firstName?.trim() ?? '';
    final last = lastName?.trim() ?? '';
    final combined = [first, last].where((s) => s.isNotEmpty).join(' ');
    if (combined.isNotEmpty) return combined;
    final u = userName?.trim() ?? '';
    if (u.isNotEmpty) return u;
    return '—';
  }

  /// `true` if [profilePicture] looks like an HTTP(S) URL.
  bool get hasProfilePhotoUrl {
    final u = profilePicture?.trim() ?? '';
    return u.startsWith('http://') || u.startsWith('https://');
  }

  /// First name if set, else [displayName] (for “Hello, …”).
  String get shortGreetingName {
    final f = firstName?.trim() ?? '';
    if (f.isNotEmpty) return f;
    final d = displayName;
    return d == '—' ? 'there' : d;
  }
}
