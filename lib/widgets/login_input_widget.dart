import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String icon;
  final Widget suffixIcon;
  final bool isObscure;

  const LoginTextField({
    super.key,
    required this.keyBoardType,
    this.textInputAction,
    this.controller,
    this.onTap,
    this.onChanged,
    this.validator,
    this.hintText,
    required this.icon,
    this.suffixIcon = const SizedBox(),
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350.w, // make sure you are using flutter_screenutil
          height: 50.h,

          decoration: BoxDecoration(
            color: const Color(0x40D9D9D9), // #D9D9D940
            borderRadius: BorderRadius.circular(8.53.r),

            border: Border.all(
              color:
                  const Color(0xFFD9D9D9), // assuming border color same as bg
              width: 0.85.w,
            ),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TextFormField(
              textInputAction: textInputAction,
              keyboardType: keyBoardType,
              onChanged: onChanged,
              onTap: onTap,
              controller: controller,
              validator: validator,
              obscureText: isObscure,
              textAlign: TextAlign.start,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 15.w,
                ),
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                // You can also add prefixIcon here if needed
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
