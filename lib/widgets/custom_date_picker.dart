import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class CustomDatePicker extends StatelessWidget {
  final String? label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;

  const CustomDatePicker({
    super.key,
    this.label,
    this.selectedDate,
    this.onDateSelected,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && onDateSelected != null) {
      onDateSelected!(picked);
    }
  }

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
                height: 1.0,
                letterSpacing: 0.0,
                color: Colors.black,
              ),
            ),
          ),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              color: textFieldBg, // Make sure to define this color
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      selectedDate != null
                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                          : "Select Date",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 1.0,
                        letterSpacing: 0.0,
                        color: selectedDate != null
                            ? colorText // Make sure to define this color
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child:
                      Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
