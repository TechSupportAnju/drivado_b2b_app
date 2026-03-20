import 'dart:convert';
import 'dart:developer';
import 'package:drivado_b2b_app/models/user_info_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserInformationRepository {
  UserInformationRepository();

  final baseUrl = dotenv.env['BASE_URL'] ?? "";

  // Future<UserInformationModel<UserData>> getUserDetails({String? accessToken}) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/v1/user/getUserInformation'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         if (accessToken != null && accessToken.isNotEmpty) 
  //           'Authorization': accessToken,
  //       },
  //     );

  //     final jsonData = json.decode(response.body);
  //     log("HOMMMMEEE RESPONSE +++++ $jsonData");
  //       if (response.statusCode != 200) {
  //       throw Exception('HTTP ${response.statusCode}');
  //     }
  //     log(response.statusCode.toString());
  //     return UserInformationModel<UserData>(
  //       success: jsonData['success'] ?? false,
  //       message: jsonData['message'] ?? '',
  //       data: jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null,
  //     );
  //   } catch (e) {
  //     log("ERROR++++++++= ${e.toString()}");
  //     return UserInformationModel<UserData>(
  //       success: false,
  //       message: 'Failed to fetch user details: $e',
  //       data: null,
  //     );
  //   }
  // }
  Future<UserInformationModel<UserData>> getUserDetails({String? accessToken}) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/v1/user/getUserInformation'),
      headers: {
        'Content-Type': 'application/json',
        if (accessToken != null && accessToken.isNotEmpty) 
          'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log("USER INFORMATION RESPONSE +++++ $jsonData");

      return UserInformationModel<UserData>(
        success: jsonData['success'] ?? false,
        message: jsonData['message'] ?? '',
        data: jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null,
      );
    } else {
      
      return UserInformationModel<UserData>(
        success: false,
        message: 'Failed to fetch user details =====  ${response.statusCode}',
        data: null,
      );
    }
    } catch (e) {
      //log("ERROR++++++++= ${e.toString()}");
      return UserInformationModel<UserData>(
        success: false,
        message: 'Failed to fetch user details: $e',
        data: null,
      );
    }
  }

}
