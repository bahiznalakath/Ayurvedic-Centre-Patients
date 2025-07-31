import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
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
              fontWeight: FontWeight.w600, // SemiBold
              fontSize: 30.sp, // if using flutter_screenutil
              height: 1.4, // 140% line height
              letterSpacing: 0.0,
              color: Colors.black, // change if needed
            ),
          ),
          kHeight20,
          Divider()
        ],
      ),
    );
  }
}
