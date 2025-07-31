import 'package:ayurvedic_centre_patients/models/response_models/login_respose.dart';
import 'package:ayurvedic_centre_patients/services/login_service.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:ayurvedic_centre_patients/view/patient_list_screen.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_snackbar.dart';
import 'package:ayurvedic_centre_patients/widgets/show_loader_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/shared_storage/shared_storage.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginResponse = LoginResponse();

  void login() async {
    if (emailController.text.isEmpty) {
      showCustomSnackBar('Email field is required.!', isError: true);
    } else if (passwordController.text.isEmpty) {
      showCustomSnackBar('Password field is required.!', isError: true);
    } else {
      try {
        showLoaderDialog();
        isLoading(true);
        LoginServices.checkLogin(emailController.text, passwordController.text)
            .then((response) async {
          isLoading(false);
          if (response.isSuccess) {
            loginResponse = LoginResponse.fromJson(response.response.body);
            saveResponse(loginResponse);
            Get.back();
            Get.offAll(PatientListScreen());
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } finally {}
    }
  }

  saveResponse(LoginResponse response) {
    SharedStorage().setSharedString(
      response.token ?? "",
      AppConstants.userToken,
    );
  }
}
