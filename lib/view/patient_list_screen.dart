import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/view/register_patient_screen.dart';
import 'package:ayurvedic_centre_patients/widgets/button_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/patient_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(mobilePadding),
        child: InkWell(
            onTap: () => Get.to(() => RegisterPatientScreen()),
            child: ButtonWidget(title: "Register Now")),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(mobilePadding),
        children: [
          kHeight20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobilePadding),
            child: Row(
              children: [
                SizedBox(
                  width: 249.w,
                  height: 40.h,
                  child: SearchBar(),
                ),
                Spacer(),
                SizedBox(
                  width: 85.w,
                  height: 40.h,
                  child: ButtonWidget(
                    title: "Search",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          kHeight20,
          const Divider(),
          kHeight10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobilePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort by :',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500, // Medium
                    fontSize: 17.sp, // or 16.0 if not using screenutil
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.black, // or your theme color
                  ),
                ),
                DateDropdown()
              ],
            ),
          ),
          kHeight20,
          PatientCard(
            patientNo: "01",
            name: "Vikram Singh",
            package: "Couple Combo Package (Rejuven...",
            date: "31/01/2024",
            patientType: "2 persons",
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        height: 1.0,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        hintText: 'Search for treatments',
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: Colors.black.withOpacity(0.6),
        ),
        filled: true,
        fillColor: Colors.white, // #00000033
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.w),
          child: Icon(
            Icons.search,
            size: 20.w,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            width: 1,
            color: colorText,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            width: 1,
            color: colorText,
          ),
        ),
      ),
    );
  }
}

class DateDropdown extends StatefulWidget {
  const DateDropdown({super.key});

  @override
  State<DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {
  String? selectedDate;

  // Replace this with your real date list later
  final List<String> dates = ['2025-07-31', '2025-08-01', '2025-08-02'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169.w,
      height: 39.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.r),
        border: Border.all(
          color: const Color(0x4D000000), // #0000004D
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDate,
          hint: Text(
            'Date',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
          ),
          icon: Transform.rotate(
            angle: -90 * 3.1416 / 180, // -90 degrees
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20.w,
              color: Colors.black,
            ),
          ),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              selectedDate = value;
            });
          },
          items: dates.map((date) {
            return DropdownMenuItem<String>(
              value: date,
              child: Text(
                date,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
