import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  void setSharedString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void setLoginStatus(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<String> getBaseUrl() async {
    String url = await SharedStorage().getSharedData(AppConstants.baseUrl);
    debugPrint('get base shared url: $url');
    return url;
  }

  void logoutUser() async {
    removeSharedData();

    // Get.back();
    // showLoaderDialog();
    // try {
    //   LogoutService.clearPushToken().then((value) {
    //     Get.back();
    //     removeSharedData();
    //     Get.offAll(() => LoginScreen());
    //   });
    // } finally {}
  }

  getSharedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.get(key);
    return data;
  }

  void removeSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(AppConstants.userToken);
    prefs.remove(AppConstants.userId);
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(AppConstants.userToken);
  }

  String getUserToken() {
    SharedPreferences? sharedPreferences;
    return sharedPreferences?.getString(AppConstants.userToken) ?? "";
  }
}
