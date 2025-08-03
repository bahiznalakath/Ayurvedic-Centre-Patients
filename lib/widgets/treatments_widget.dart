import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreatmentsWidget extends StatelessWidget {
  final String treatmentName;
  final int maleCount;
  final int femaleCount;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TreatmentsWidget({
    Key? key,
    required this.treatmentName,
    required this.maleCount,
    required this.femaleCount,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        treatmentName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          height: 1.0,
                          letterSpacing: 0.0,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6B6B),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text("Male", style: _textStyle()),
                      SizedBox(width: 6),
                      Text("$maleCount", style: _textStyle()),
                    ]),
                    Row(children: [
                      Text("Female", style: _textStyle()),
                      SizedBox(width: 6),
                      Text("$femaleCount", style: _textStyle()),
                    ]),
                    GestureDetector(
                      onTap: onEdit,
                      child: Icon(Icons.edit, color: primaryColor, size: 24),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  TextStyle _textStyle() => TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: Colors.black,
      );
}
