import 'package:ayurvedic_centre_patients/models/models/response_model.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'api_client/api_client.dart';

class LoginServices {
  static Future<ResponseModel> checkLogin(String email, String password) async {
    var body = {
      'username': email,
      'password': password,
    };
    print(body);
    Response response = await ApiClient().postData(AppConstants.loginUrl, body);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.statusText ?? '', response);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? '', response);
    }
    return responseModel;
  }
}
