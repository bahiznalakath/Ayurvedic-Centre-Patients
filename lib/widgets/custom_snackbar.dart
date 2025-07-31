import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void shoFloatingCustomBar(String message, {bool isError = true}) {
  final context = Get.overlayContext;
  if (context != null) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 30,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isError ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

void showCustomSnackBar(String message, {bool isError = true, int timer = 3}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
      elevation: 2,
    ));
  }
}

void topCustomSnackBar(String message, String title,
    {bool isError = true, int timer = 3}) {
  if (message.isNotEmpty) {
    Get.snackbar(title, message,
        duration: Duration(seconds: timer),
        margin: EdgeInsets.all(20.w),
        backgroundColor: isError ? Colors.red : Colors.green,
        colorText: Colors.white);
  }
}
