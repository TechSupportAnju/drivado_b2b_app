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

  UserData({
    this.id, this.firstName, this.lastName, this.userName, this.email,
    this.mobile, this.role, this.userActiveStatus, this.position,
    this.loginAttempts, this.userLocked, this.isDeleted, this.language,
    this.unpaidBooking, this.markup, this.discount, this.cityprice,
    this.company, this.createdAt, this.updatedAt, this.permission,
    this.refreshToken, this.refreshTokenExpiry, this.forgotPasswordExpiry,
    this.forgotPasswordToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
      userActiveStatus: json['userActiveStatus'],
      position: json['position'],
      loginAttempts: json['loginAttempts'],
      userLocked: json['userLocked'],
      isDeleted: json['isDeleted'],
      language: json['language'],
      unpaidBooking: json['unpaidBooking'],
      markup: json['markup'],
      discount: json['discount'],
      cityprice: json['cityprice'],
      company: json['company'] != null ? CompanyData.fromJson(json['company']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      permission: json['permission'] != null ? PermissionData.fromJson(json['permission']) : null,
      refreshToken: json['refresh_token'],
      refreshTokenExpiry: json['refresh_token_expiry'] != null ? DateTime.parse(json['refresh_token_expiry']) : null,
      forgotPasswordExpiry: json['forgotPasswordExpiry'] != null ? DateTime.parse(json['forgotPasswordExpiry']) : null,
      forgotPasswordToken: json['forgotPasswordToken'],
    );
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
      id: json['_id'],
      companyName: json['companyName'],
      companyId: json['companyId'],
      email: json['email'],
      website: json['website'],
      address: json['address'],
      isDeleted: json['isDeleted'],
      gstVat: json['gst_vat'],
      creditLimit: json['creditLimit'],
      discount: json['discount'],
      markUp: json['markUp'],
      totalUnpaidBooking: json['totalUnpaidBooking'],
      availableLimit: json['availableLimit'],
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
      newBooking: json['newBooking'],
      flatRateBooking: json['flatRateBooking'],
      manageBooking: json['manageBooking'],
      affiliate: json['affiliate'],
      regions: json['regions'],
      flatRegions: json['flatRegions'],
      generalSettings: json['generalSettings'],
      userManagement: json['userManagement'],
      vehicleTypes: json['vehicleTypes'],
      imageUploader: json['imageUploader'],
      apiDocs: json['apiDocs'],
      whiteLevelDocs: json['whiteLevelDocs'],
    );
  }
}

