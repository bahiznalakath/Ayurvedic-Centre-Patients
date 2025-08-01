import 'package:ayurvedic_centre_patients/models/models/response_model.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'api_client/api_client.dart';

class LoginServices {
  /// Multipart-based login API example
  static Future<ResponseModel> checkLoginMultipart(
      String email, String password) async {
    var fields = {
      'username': email,
      'password': password,
    };

    Response response = await ApiClient().comment(
      uri: AppConstants.loginUrl,
      fields: fields,
    );

    return ResponseModel(
      response.statusCode == 200,
      response.statusText ?? '',
      response,
    );
  }
}
