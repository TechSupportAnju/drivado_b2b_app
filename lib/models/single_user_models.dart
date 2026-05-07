import 'package:equatable/equatable.dart';

/// One user row from `getSingleUser` (several possible JSON nests).
class SingleUserDetail extends Equatable {
  final String id;
  final String firstName;
  final String? email;
  final String? role;
  final String? phone;
  final String? language;
  final String? currency;
  final String? totalUnpaidLabel;
  final String? availableCreditLabel;

  const SingleUserDetail({
    required this.id,
    required this.firstName,
    this.email,
    this.role,
    this.phone,
    this.language,
    this.currency,
    this.totalUnpaidLabel,
    this.availableCreditLabel,
  });

  factory SingleUserDetail.fromJson(Map<String, dynamic> json) {
    String? pickCredit(Map<String, dynamic> m, List<String> keys) {
      for (final k in keys) {
        final v = m[k];
        if (v != null && v.toString().trim().isNotEmpty) {
          return v.toString();
        }
      }
      return null;
    }

    final company = _asMap(json['company']);

    final currencyFromCompany = company != null
        ? pickCredit(company, const ['currency', 'prefCurrency'])
        : null;
    final currencyRoot = json['currency']?.toString().trim();
    final currencyResolved =
        (currencyFromCompany != null && currencyFromCompany.trim().isNotEmpty)
            ? currencyFromCompany.trim()
            : (currencyRoot != null && currencyRoot.isNotEmpty
                ? currencyRoot
                : null);

    final totalUnpaidLabel = pickCredit(json, const [
          'unpaidBooking',
          'totalUnpaidBooking',
          'total_unpaid_booking',
        ]) ??
        (company != null
            ? pickCredit(company, const [
                'totalUnpaidBooking',
                'unpaidBooking',
                'total_unpaid_booking',
              ])
            : null);

    final availableCreditLabel = company != null
        ? pickCredit(company, const [
            'availableLimit',
            'available_limit',
            'availableCreditLimit',
            'available_credit_limit',
          ])
        : pickCredit(json, const [
            'availableLimit',
            'available_credit_limit',
            'availableCreditLimit',
          ]);

    return SingleUserDetail(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      email: json['email']?.toString(),
      role: json['role']?.toString(),
      phone: json['phone']?.toString() ??
          json['mobile']?.toString() ??
          json['mobileNumber']?.toString() ??
          json['phoneNumber']?.toString(),
      language: json['language']?.toString() ??
          json['prefLanguage']?.toString() ??
          json['preferredLanguage']?.toString(),
      currency: currencyResolved,
      totalUnpaidLabel: totalUnpaidLabel,
      availableCreditLabel: availableCreditLabel,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic v) {
    if (v is Map) return Map<String, dynamic>.from(v);
    return null;
  }

  static Map<String, dynamic>? _firstMapInList(dynamic list) {
    if (list is! List || list.isEmpty) return null;
    return _asMap(list.first);
  }

  /// Avoid mistaking a company node for a user (company list items use `companyName`).
  static bool _isProbableUserDoc(Map<String, dynamic> m) {
    final id =
        m['_id']?.toString().trim() ?? m['id']?.toString().trim() ?? '';
    if (id.isEmpty) return false;

    final companyName = m['companyName']?.toString().trim() ?? '';
    final userName = m['userName']?.toString().trim() ??
        m['username']?.toString().trim() ??
        '';
    final email = m['email']?.toString().trim() ?? '';
    final first = m['firstName']?.toString().trim() ?? '';
    final last = m['lastName']?.toString().trim() ?? '';
    final hasPersonName =
        userName.isNotEmpty || first.isNotEmpty || last.isNotEmpty;

    if (companyName.isNotEmpty &&
        !hasPersonName &&
        email.isEmpty &&
        m['role'] == null) {
      return false;
    }

    return hasPersonName || email.isNotEmpty;
  }

  static SingleUserDetail? _tryKnownPaths(Map<String, dynamic> root) {
    final paths = <Map<String, dynamic>?>[
      _firstMapInList(root['singleUserDetails']),
      _firstMapInList(root['single_user_details']),
      _firstMapInList(root['singleUserDetail']),
      _asMap(root['user']),
      _firstMapInList(root['users']),
    ];

    final rawData = root['data'];
    if (rawData is List) {
      paths.add(_firstMapInList(rawData));
    }
    final data = _asMap(rawData);
    if (data != null) {
      paths.addAll([
        _firstMapInList(data['singleUserDetails']),
        _firstMapInList(data['single_user_details']),
        _firstMapInList(data['singleUserDetail']),
        _firstMapInList(data['users']),
        _asMap(data['user']),
        _asMap(data['userData']),
        _asMap(data['result']),
        _asMap(data['payload']),
      ]);
      if (data['data'] != null) {
        paths.add(_asMap(data['data']));
        paths.add(_firstMapInList(data['data']));
      }
    }

    for (final m in paths) {
      if (m != null && _isProbableUserDoc(m)) {
        return SingleUserDetail.fromJson(m);
      }
    }

    if (data != null && _isProbableUserDoc(data)) {
      return SingleUserDetail.fromJson(data);
    }

    return null;
  }

  /// Last resort: shallow scan (some APIs nest the user under uncommon keys).
  static SingleUserDetail? _deepFindUser(
    Map<String, dynamic> m, [
    int depth = 0,
  ]) {
    if (depth > 5) return null;
    if (_isProbableUserDoc(m)) {
      return SingleUserDetail.fromJson(m);
    }
    for (final v in m.values) {
      final child = _asMap(v);
      if (child != null) {
        final hit = _deepFindUser(child, depth + 1);
        if (hit != null) return hit;
      }
      if (v is List) {
        for (final item in v) {
          final cm = _asMap(item);
          if (cm != null) {
            final hit = _deepFindUser(cm, depth + 1);
            if (hit != null) return hit;
          }
        }
      }
    }
    return null;
  }

  static SingleUserDetail? tryParse(Map<String, dynamic> root) {
    return _tryKnownPaths(root) ??
        _deepFindUser(root) ??
        (_asMap(root['data']) != null
            ? _deepFindUser(_asMap(root['data'])!)
            : null);
  }

  String dash(String? s) =>
      (s == null || s.trim().isEmpty) ? '—' : s;

  @override
  List<Object?> get props => [
        id,
        firstName,
        email,
        role,
        phone,
        language,
        currency,
        totalUnpaidLabel,
        availableCreditLabel,
      ];
}
