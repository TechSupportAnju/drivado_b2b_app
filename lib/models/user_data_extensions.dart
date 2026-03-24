import 'package:drivado_b2b_app/models/user_info_model.dart';

extension UserDataSingleCompanyQueryId on UserData {
  /// `getSingleCompany?id=` — prefer linked company `_id`, else user `_id`.
  String get singleCompanyQueryId {
    final companyId = company?.id?.trim() ?? '';
    if (companyId.isNotEmpty) return companyId;
    return id?.trim() ?? '';
  }
}
