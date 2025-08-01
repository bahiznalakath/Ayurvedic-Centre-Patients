import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/widgets/login_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPatientScreen extends StatelessWidget {
  const RegisterPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(mobilePadding),
        children: [
          kHeight20,
          Text(
            'Register',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              // SemiBold
              fontSize: 30.sp,
              // if using flutter_screenutil
              height: 1.4,
              // 140% line height
              letterSpacing: 0.0,
              color: Colors.black, // change if needed
            ),
          ),
          kHeight20,
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobilePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your full name",
                ),
                kHeight10,
                Text(
                  'Whatsapp Number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your Whatsapp number",
                ),
                kHeight10,
                Text(
                  'Address',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your full address",
                ),
                kHeight10,
                Text(
                  'Location',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Choose your location",
                ),
                kHeight30,
              ],
            ),
          )
        ],
      ),
    );
  }
}
