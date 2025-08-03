import 'package:ayurvedic_centre_patients/models/models/response_model.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'api_client/api_client.dart';

class Services {
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

  static Future<ResponseModel> registerationSubmit(
    String name,
    String excecutive,
    String payment,
    String phone,
    String address,
    double totalAmount,
    double discountAmount,
    double advanceAmount,
    double balanceAmount,
    String date_nd_time,
    String male,
    String female,
    int branch,
    List<int> treatments,
  ) async {
    var fields = {
      'name': name,
      'excecutive': excecutive,
      'payment': payment,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': date_nd_time,
      'id': '',
      'male': male,
      'female': female,
      'branch': branch,
      'treatments': treatments,
    };

    Response response = await ApiClient().postData(
      AppConstants.patientUpdateUrl,
      fields,
    );

    return ResponseModel(
      response.statusCode == 200,
      response.statusText ?? '',
      response,
    );
  }

  static Future<ResponseModel> getPatientListUrl() async {
    Response response = await ApiClient().getData(AppConstants.patientListUrl);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.statusText ?? '', response);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? '', response);
    }
    return responseModel;
  }

  static Future<ResponseModel> getTreatmentUrl() async {
    Response response =
        await ApiClient().getData(AppConstants.treatmentListUrl);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.statusText ?? '', response);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? '', response);
    }
    return responseModel;
  }

  static Future<ResponseModel> getBranchList() async {
    Response response = await ApiClient().getData(AppConstants.branchListUrl);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.statusText ?? '', response);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? '', response);
    }
    return responseModel;
  }
}
