import 'package:ayurvedic_centre_patients/helper/shared_storage/shared_storage.dart';
import 'package:ayurvedic_centre_patients/view/login_screen.dart';
import 'package:ayurvedic_centre_patients/view/patient_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _launchPage();
  }

  checkLoginStatus() async {
    await SharedStorage().isLogin().then((result) async {
      debugPrint("hgfuhbfjbbfjbhrfrf$result");
      if (result) {
        return Get.offAll(() => PatientListScreen());
      } else {
        return Get.offAll(() => LoginScreen());
      }
    });
  }

  _launchPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }
}
