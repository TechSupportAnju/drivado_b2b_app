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
    return LoginResponseModel(
      accessToken: json['accessToken'] ?? "",
      refreshToken: json['refreshToken'] ?? "",
      phone: json['user']['phone'] ?? "",
    );
  }
}
class SignupOtpResponseModel {
  final String? refreshToken;
  final String? message;
  SignupOtpResponseModel({
    this.refreshToken,
    this.message,
  });

  factory SignupOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupOtpResponseModel(
      refreshToken: json['refreshToken'] ?? "",
      message: json['message'] ?? "",
    );
  }
}