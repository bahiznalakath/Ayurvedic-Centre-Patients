import 'package:ayurvedic_centre_patients/helper/shared_storage/shared_storage.dart';
import 'package:ayurvedic_centre_patients/view/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    checkLoginStatus();
  }

  checkLoginStatus() async {
    await SharedStorage().isLogin().then((result) async {
      if (result) {
        return Get.offAll(() => LoginScreen());
      } else {
        return Get.offAll(() => LoginScreen());
      }
    });
  }

  // _launchPage() async {
  //   await Future.delayed(const Duration(seconds: 3), () {
  //     if (!openedFromNotification) {
  //       checkLoginStatus();
  //     }
  //   });
  // }
}
