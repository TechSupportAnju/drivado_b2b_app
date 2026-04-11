/// Body for POST `/v1/company/addChildUser`.
class AddChildUserRequest {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String mobile;

  const AddChildUserRequest({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': password,
        'mobile': mobile,
      };
}
