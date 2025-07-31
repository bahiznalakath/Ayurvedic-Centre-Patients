import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showLoaderDialog() {
  showDialog(
    barrierDismissible: false,
    context: Get.overlayContext!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100.w,
                padding: const EdgeInsets.all(16),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   color: Colors.white,
                // ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
