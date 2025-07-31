import 'package:ayurvedic_centre_patients/controllers/auth_controller.dart';
import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/utils/images.dart';
import 'package:ayurvedic_centre_patients/widgets/button_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/login_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: 217.h,
            width: 1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgBackgroundFrame),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image.asset(
                imgSmallLogo,
                width: 100.w,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight30,
                Text(
                  "Login or register to book your appointments",
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp,
                    height: 1.4, // 140% line height
                    color: colorText,
                    letterSpacing: 0,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  textAlign: TextAlign.left,
                ),
                kHeight30,
                Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400, // Regular
                    fontSize: 16.sp, // With flutter_screenutil
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your email",
                  controller: authController.emailController,
                ),
                kHeight10,
                Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400, // Regular
                    fontSize: 16.sp, // With flutter_screenutil
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter password",
                  controller: authController.passwordController,
                ),
                kHeight30,
                InkWell(
                    onTap: () => authController.login(),
                    child: ButtonWidget(title: "Login")),
                kHeight30,
                Container(
                  width: 350.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        height: 1.0,
                        letterSpacing: 0.12, // 1% of 12px
                        color: Colors.black,
                        fontWeight: FontWeight.w300, // Light
                      ),
                      children: [
                        const TextSpan(
                            text:
                                'By creating or logging into an account you are agreeing with our '),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.w500, // Medium
                            color: colorElectricBlue,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400, // Regular
                            color: colorElectricBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
