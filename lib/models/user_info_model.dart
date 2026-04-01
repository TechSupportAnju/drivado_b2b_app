/// JSON numbers often decode as [double]; maps cleanly to [int?].
int? _intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class UserInformationModel<T> {
  final bool success;
  final String message;
  final T? data;

  UserInformationModel({required this.success, required this.message, this.data});
}

class UserData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? mobile;
  final String? role;
  final String? userActiveStatus;
  final String? position;
  final int? loginAttempts;
  final bool? userLocked;
  final bool? isDeleted;
  final String? language;
  final int? unpaidBooking;
  final int? markup;
  final int? discount;
  final List<dynamic>? cityprice;
  final CompanyData? company;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PermissionData? permission;
  final String? refreshToken;
  final DateTime? refreshTokenExpiry;
  final DateTime? forgotPasswordExpiry;
  final String? forgotPasswordToken;
  /// Profile image URL from API (e.g. `profilePicture`, `photo`, `image`, …).
  final String? profilePicture;

  UserData({
    this.id, this.firstName, this.lastName, this.userName, this.email,
    this.mobile, this.role, this.userActiveStatus, this.position,
    this.loginAttempts, this.userLocked, this.isDeleted, this.language,
    this.unpaidBooking, this.markup, this.discount, this.cityprice,
    this.company, this.createdAt, this.updatedAt, this.permission,
    this.refreshToken, this.refreshTokenExpiry, this.forgotPasswordExpiry,
    this.forgotPasswordToken, this.profilePicture,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      userName: json['userName']?.toString(),
      email: json['email']?.toString(),
      mobile: _stringFromJson(json['mobile']),
      role: json['role']?.toString(),
      userActiveStatus: json['userActiveStatus']?.toString(),
      position: json['position']?.toString(),
      loginAttempts: _intFromJson(json['loginAttempts']),
      userLocked: json['userLocked'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      language: json['language']?.toString(),
      unpaidBooking: _intFromJson(json['unpaidBooking']),
      markup: _intFromJson(json['markup']),
      discount: _intFromJson(json['discount']),
      cityprice: json['cityprice'],
      company: json['company'] != null ? CompanyData.fromJson(json['company']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      permission: json['permission'] != null ? PermissionData.fromJson(json['permission']) : null,
      refreshToken: json['refresh_token']?.toString(),
      refreshTokenExpiry: json['refresh_token_expiry'] != null ? DateTime.parse(json['refresh_token_expiry']) : null,
      forgotPasswordExpiry: json['forgotPasswordExpiry'] != null ? DateTime.parse(json['forgotPasswordExpiry']) : null,
      forgotPasswordToken: json['forgotPasswordToken']?.toString(),
      profilePicture: _profilePictureFromJson(json),
    );
  }

  static String? _profilePictureFromJson(Map<String, dynamic> json) {
    const keys = [
      'profilePicture',
      'profileImage',
      'profile_photo',
      'photo',
      'image',
      'avatar',
      'picture',
      'userImage',
      'profilePic',
    ];
    for (final key in keys) {
      final v = json[key];
      if (v != null && v.toString().trim().isNotEmpty) {
        return v.toString().trim();
      }
    }
    return null;
  }

  static String? _stringFromJson(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return null;
  }
}

class CompanyData {
  final String? id;
  final String? companyName;
  final String? companyId;
  final String? email;
  final String? website;
  final String? address;
  final bool? isDeleted;
  final String? gstVat;
  final int? creditLimit;
  final int? discount;
  final int? markUp;
  final int? totalUnpaidBooking;
  final int? availableLimit;
  final bool? invoiceable;
  final List<dynamic>? cityprice;
  final List<dynamic>? thresholdValues;
  final bool? root;
  final String? language;
  final String? currency;
  final List<String>? users;
  final List<String>? company;

  CompanyData({
    this.id, this.companyName, this.companyId, this.email, this.website,
    this.address, this.isDeleted, this.gstVat, this.creditLimit, this.discount,
    this.markUp, this.totalUnpaidBooking, this.availableLimit, this.invoiceable,
    this.cityprice, this.thresholdValues, this.root, this.language, this.currency,
    this.users, this.company,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      id: json['_id']?.toString(),
      companyName: json['companyName']?.toString(),
      companyId: json['companyId']?.toString(),
      email: json['email']?.toString(),
      website: json['website']?.toString(),
      address: json['address']?.toString(),
      isDeleted: json['isDeleted'] as bool?,
      gstVat: json['gst_vat']?.toString(),
      creditLimit: _intFromJson(json['creditLimit']),
      discount: _intFromJson(json['discount']),
      markUp: _intFromJson(json['markUp']),
      totalUnpaidBooking: _intFromJson(json['totalUnpaidBooking']),
      availableLimit: _intFromJson(json['availableLimit']),
      invoiceable: json['invoiceable'],
      cityprice: json['cityprice'],
      thresholdValues: json['thresholdValues'],
      root: json['root'],
      language: json['language'],
      currency: json['currency'],
      users: List<String>.from(json['users'] ?? []),
      company: List<String>.from(json['company'] ?? []),
    );
  }
}

class PermissionData {
  final Map<String, dynamic>? newBooking;
  final String? flatRateBooking;
  final Map<String, dynamic>? manageBooking;
  final String? affiliate;
  final String? regions;
  final String? flatRegions;
  final String? generalSettings;
  final Map<String, dynamic>? userManagement;
  final String? vehicleTypes;
  final String? imageUploader;
  final String? apiDocs;
  final String? whiteLevelDocs;

  PermissionData({
    this.newBooking, this.flatRateBooking, this.manageBooking, this.affiliate,
    this.regions, this.flatRegions, this.generalSettings, this.userManagement,
    this.vehicleTypes, this.imageUploader, this.apiDocs, this.whiteLevelDocs,
  });

  factory PermissionData.fromJson(Map<String, dynamic> json) {
    return PermissionData(
      newBooking: _mapFromJson(json['newBooking']),
      flatRateBooking: _stringFromJson(json['flatRateBooking']),
      manageBooking: _mapFromJson(json['manageBooking']),
      affiliate: _stringFromJson(json['affiliate']),
      regions: _stringFromJson(json['regions']),
      flatRegions: _stringFromJson(json['flatRegions']),
      generalSettings: _stringFromJson(json['generalSettings']),
      userManagement: _mapFromJson(json['userManagement']),
      vehicleTypes: _stringFromJson(json['vehicleTypes']),
      imageUploader: _stringFromJson(json['imageUploader']),
      apiDocs: _stringFromJson(json['apiDocs']),
      whiteLevelDocs: _stringFromJson(json['whiteLevelDocs']),
    );
  }

  /// API often sends `{ "permission": "..." }` where older models expected a [String].
  static String? _stringFromJson(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map) {
      final p = value['permission'];
      if (p != null) return p.toString();
      return null;
    }
    return value.toString();
  }

  static Map<String, dynamic>? _mapFromJson(dynamic value) {
    if (value == null) return null;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}

