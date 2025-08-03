import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String hintText;
  final FormFieldValidator<T>? validator;

  const CustomDropdown({
    super.key,
    this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1.4,
                letterSpacing: 0.0,
                color: Colors.black, // change if needed
              ),
            ),
          ),
        Container(
          width: 350,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: textFieldBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFD9D9D9),
              width: 0.85.w,
            ),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                height: 1.4,
                letterSpacing: 0.0,
                color: Colors.black, // change if needed
              ),
              // hintStyle: GoogleFonts.poppins(
              //   fontSize: 16,
              //   fontWeight: FontWeight.w400,
              //   color: AppColors.textGrey,
              // ),
            ),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              height: 1.4,
              letterSpacing: 0.0,
              color: Colors.black, // change if needed
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryColor,
            ),
            iconSize: 34,
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
