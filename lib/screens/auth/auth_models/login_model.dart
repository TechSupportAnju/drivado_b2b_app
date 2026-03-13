class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? phone;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.phone,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    String? phone;
    if (user is Map<String, dynamic>) {
      phone = user['phone'] as String?;
    }

    return LoginResponseModel(
      accessToken: json['accessToken'] as String? ?? "",
      refreshToken: json['refreshToken'] as String? ?? "",
      phone: phone ?? "",
    );
  }
}
