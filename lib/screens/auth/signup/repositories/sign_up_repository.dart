import 'dart:convert';
import 'dart:developer';
import 'package:drivado_b2b_app/screens/auth/auth_models/signup_model.dart';
import 'package:http/http.dart' as http;

class SignupRepository {
  final baseUrl = "https://testapi.drivado.com/api/v1";
  Future <SignupResponseModel> SignupWithPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String companyName,
    required String address,
    required String mobile,
  }) async{
      final response = await http.post(
        Uri.parse("$baseUrl/user/registermail"),
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode(
            {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "companyName": companyName,
            "contactNumber": mobile,
            "address": address
            }
        ),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        return SignupResponseModel.fromJson(jsonResponse);
      } else {
        final errorJson = jsonDecode(response.body);
        final message = errorJson['error'] ?? 'Email not registered';
        throw Exception(message);
      }
  }
}