import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientCard extends StatelessWidget {
  final String patientNo;
  final String name;
  final String package;
  final String date;
  final String patientType;

  const PatientCard({
    super.key,
    required this.patientNo,
    required this.name,
    required this.package,
    required this.date,
    required this.patientType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 166.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// First Row: No and Name
          Row(
            children: [
              Text(
                "$patientNo:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          /// Second Row: Package
          SizedBox(height: 5.h),
          Text(
            package,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 16.sp,
              color: Color(0xFF006837),
            ),
          ),

          /// Third Row: Date + Calendar | Icon + Name
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 16.sp, color: Colors.red.withOpacity(0.5)),
              SizedBox(width: 5.w),
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              kWidth10,
              // Spacer(),
              Icon(CupertinoIcons.person_2,
                  color: Colors.red.withOpacity(0.5), size: 18.sp),
              SizedBox(width: 5.w),
              Text(
                patientType,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),

          /// Divider
          SizedBox(height: 10.h),
          Divider(thickness: 1, color: Colors.grey.shade300),

          /// Last Row: View Booking Details + Arrow Icon
          SizedBox(height: 5.h),
          Row(
            children: [
              Spacer(),
              Text(
                "View Booking details",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward_ios, size: 20.sp),
            ],
          ),
        ],
      ),
    );
  }
}
