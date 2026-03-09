class SignupResponseModel {
  final String? message;
  SignupResponseModel({
    this.message,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'] ?? "",
    );
  }
}