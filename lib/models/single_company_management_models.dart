import 'package:equatable/equatable.dart';

/// User row under a company (`users` array).
class CompanyLinkedUser extends Equatable {
  final String id;
  final String userName;
  final String role;

  const CompanyLinkedUser({
    required this.id,
    required this.userName,
    required this.role,
  });

  factory CompanyLinkedUser.fromJson(Map<String, dynamic> json) {
    return CompanyLinkedUser(
      id: json['_id']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }

  /// List row label (userName only).
  String get displayTitle => userName;

  @override
  List<Object?> get props => [id, userName, role];
}

/// Company node with nested `users` and `company` arrays (recursive).
class ManagedChildCompany extends Equatable {
  final String id;
  final String companyName;
  final String? email;
  final String? website;
  final String? address;
  final String? gstVat;
  final List<CompanyLinkedUser> users;
  final List<ManagedChildCompany> childCompanies;

  const ManagedChildCompany({
    required this.id,
    required this.companyName,
    this.email,
    this.website,
    this.address,
    this.gstVat,
    this.users = const [],
    this.childCompanies = const [],
  });

  factory ManagedChildCompany.fromJson(Map<String, dynamic> json) {
    final userList = <CompanyLinkedUser>[];
    final rawUsers = json['users'];
    if (rawUsers is List) {
      for (final e in rawUsers) {
        if (e is Map) {
          userList.add(
            CompanyLinkedUser.fromJson(Map<String, dynamic>.from(e)),
          );
        }
      }
    }

    final children = <ManagedChildCompany>[];
    final rawCompany = json['company'];
    if (rawCompany is List) {
      for (final e in rawCompany) {
        if (e is Map) {
          children.add(
            ManagedChildCompany.fromJson(Map<String, dynamic>.from(e)),
          );
        }
      }
    }

    return ManagedChildCompany(
      id: json['_id']?.toString() ?? '',
      companyName: json['companyName']?.toString() ?? '',
      email: json['email']?.toString(),
      website: json['website']?.toString(),
      address: json['address']?.toString(),
      gstVat: json['gst_vat']?.toString() ?? json['gstVat']?.toString(),
      users: userList,
      childCompanies: children,
    );
  }

  /// List row label (companyName only).
  String get displayTitle => companyName;

  @override
  List<Object?> get props =>
      [id, companyName, email, website, address, gstVat, users, childCompanies];
}

/// Parsed first element of `singleCompanyDetails` for User Management UI.
class SingleCompanyManagementPayload extends Equatable {
  final String rootCompanyName;
  final String? rootCompanyId;
  final List<CompanyLinkedUser> users;
  final List<ManagedChildCompany> childCompanies;

  const SingleCompanyManagementPayload({
    required this.rootCompanyName,
    this.rootCompanyId,
    required this.users,
    required this.childCompanies,
  });

  /// Accepts full HTTP JSON: may be `{ data: { singleCompanyDetails: [...] } }` or
  /// `{ singleCompanyDetails: [...] }` or `success/message/data` shapes.
  static SingleCompanyManagementPayload? tryParse(Map<String, dynamic> root) {
    List<dynamic>? details;

    final data = root['data'];
    if (data is Map) {
      final m = Map<String, dynamic>.from(data);
      details = m['singleCompanyDetails'] as List?;
    }
    details ??= root['singleCompanyDetails'] as List?;

    if (details == null || details.isEmpty) return null;
    final first = details.first;
    if (first is! Map) return null;
    final row = Map<String, dynamic>.from(first);

    final users = <CompanyLinkedUser>[];
    final rawUsers = row['users'];
    if (rawUsers is List) {
      for (final e in rawUsers) {
        if (e is Map) {
          users.add(CompanyLinkedUser.fromJson(Map<String, dynamic>.from(e)));
        }
      }
    }

    final children = <ManagedChildCompany>[];
    final rawCompanies = row['company'];
    if (rawCompanies is List) {
      for (final e in rawCompanies) {
        if (e is Map) {
          children.add(
            ManagedChildCompany.fromJson(Map<String, dynamic>.from(e)),
          );
        }
      }
    }

    return SingleCompanyManagementPayload(
      rootCompanyName: row['companyName']?.toString() ?? '',
      rootCompanyId: row['_id']?.toString(),
      users: users,
      childCompanies: children,
    );
  }

  @override
  List<Object?> get props =>
      [rootCompanyName, rootCompanyId, users, childCompanies];
}
