import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/dimensions.dart';

class CustomHourMinutePicker extends StatefulWidget {
  final String? label;
  final int? selectedHour;
  final int? selectedMinute;
  final void Function(int hour, int minute)? onTimeSelected;

  const CustomHourMinutePicker({
    super.key,
    this.label,
    this.selectedHour,
    this.selectedMinute,
    this.onTimeSelected,
  });

  @override
  State<CustomHourMinutePicker> createState() => _CustomHourMinutePickerState();
}

class _CustomHourMinutePickerState extends State<CustomHourMinutePicker> {
  int? _selectedHour;
  int? _selectedMinute;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.selectedHour;
    _selectedMinute = widget.selectedMinute;
  }

  @override
  void didUpdateWidget(CustomHourMinutePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedHour != _selectedHour) {
      _selectedHour = widget.selectedHour;
    }
    if (widget.selectedMinute != _selectedMinute) {
      _selectedMinute = widget.selectedMinute;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                widget.label!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Colors.grey[800],
                ),
              ),
            ),
          kHeight9,
          Row(
            children: [
              // Hour Dropdown
              Expanded(
                child: Container(
                  height: 50.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    color: textFieldBg,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedHour,
                      isExpanded: true,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      hint: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          "Hour",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: List.generate(24, (hour) {
                        return DropdownMenuItem<int>(
                          value: hour,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              hour.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedHour = newValue;
                        });
                        if (newValue != null && widget.onTimeSelected != null) {
                          widget.onTimeSelected!(
                            newValue,
                            _selectedMinute ?? 0,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              // Minute Dropdown
              Expanded(
                child: Container(
                  height: 50.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    color: textFieldBg,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedMinute,
                      isExpanded: true,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      hint: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          "Minute",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: List.generate(60, (minute) {
                        return DropdownMenuItem<int>(
                          value: minute,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              minute.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedMinute = newValue;
                        });
                        if (newValue != null && widget.onTimeSelected != null) {
                          widget.onTimeSelected!(
                            _selectedHour ?? 0,
                            newValue,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
