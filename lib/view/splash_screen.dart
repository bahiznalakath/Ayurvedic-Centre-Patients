import 'package:ayurvedic_centre_patients/controllers/splash_controller.dart';
import 'package:ayurvedic_centre_patients/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          imgSplashLogo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
