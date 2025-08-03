import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreatmentsWidget extends StatelessWidget {
  const TreatmentsWidget({super.key});

  Widget buildCounter(
    int count, {
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      constraints: BoxConstraints(minWidth: 60, maxWidth: 90),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.remove, size: 16, color: Colors.grey[600]),
            ),
          ),
          Container(
            width: 24,
            alignment: Alignment.center,
            child: Text(
              count.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                height: 1.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.add, size: 16, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

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
                        'Couple Combo package i..',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          height: 1.0,
                          letterSpacing: 0.0,
                          color: Colors.black,
                        ),
                      ),
                      // CustomText(
                      //   text: 'Couple Combo package i..',
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w600,
                      //   color: Colors.grey[800],
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'Male',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                              ),
                            ),
                            // CustomText(
                            //   text: 'Male',
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w500,
                            //   color: Color(0xFF4CAF50),
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ),
                          SizedBox(width: 6),
                          // buildCounter(
                          //   provider.maleCount,
                          //   onDecrement: provider.decrementMale,
                          //   onIncrement: provider.incrementMale,
                          // ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'Female',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                              ),
                            ),

                            // CustomText(
                            //   text: 'Female',
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w500,
                            //   color: Color(0xFF4CAF50),
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ),
                          SizedBox(width: 6),
                          // buildCounter(
                          //   provider.femaleCount,
                          //   onDecrement: provider.decrementFemale,
                          //   onIncrement: provider.incrementFemale,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.edit, color: primaryColor, size: 24),
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
}
