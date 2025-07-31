import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final double? fontSize;

  const ButtonWidget({
    super.key,
    required this.title,
    this.fontSize = 17,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      width: 1.sw,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        // boxShadow: const [boxShadow],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: fontSize?.sp, // if using flutter_screenutil
          height: 1.0, // line-height 100%
          letterSpacing: 0.17, // 1% of 17px = ~0.17
          color: Colors.white,
        ),
      ),
    );
  }
}
