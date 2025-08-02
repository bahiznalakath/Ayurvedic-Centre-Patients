import 'package:ayurvedic_centre_patients/controllers/patient_controller.dart';
import 'package:ayurvedic_centre_patients/utils/color.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/view/patient_details_screen.dart';
import 'package:ayurvedic_centre_patients/view/register_patient_screen.dart';
import 'package:ayurvedic_centre_patients/widgets/button_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/patient_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientListScreen extends StatelessWidget {
  PatientListScreen({super.key});

  final PatientController controller = Get.put(PatientController());
  final ScrollController _scrollController = ScrollController();

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
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () => controller.getPatientData(),
          child: ListView(
            controller: _scrollController,
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
                      child: SearchBar(
                        onChanged: (value) => controller.setSearchQuery(value),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 85.w,
                      height: 40.h,
                      child: InkWell(
                        onTap: () => controller.filterPatients(),
                        child: ButtonWidget(
                          title: "Search",
                          fontSize: 14,
                        ),
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
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        height: 1.0,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                    Obx(() => DateDropdown(
                          dates: controller.datesList,
                          selectedDate: controller.selectedDate.value,
                          onDateSelected: controller.setSelectedDate,
                        )),
                  ],
                ),
              ),
              kHeight20,
              if (controller.isLoading.value)
                Center(child: CircularProgressIndicator()),
              if (!controller.isLoading.value &&
                  controller.filteredPatientList.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Text(
                      'No patients found',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              if (!controller.isLoading.value &&
                  controller.filteredPatientList.isNotEmpty)
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.filteredPatientList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.filteredPatientList[index];
                    return InkWell(
                      onTap: () =>
                          Get.to(() => PatientDetailsScreen(patient: item)),
                      child: PatientCard(
                        patientNo: (index + 1).toString().padLeft(2, '0'),
                        name: item.name ?? "",
                        package: PatientController.getTreatmentNames(item),
                        date: item.dateNdTime != null
                            ? PatientController.formatDate(item.dateNdTime!)
                            : "N/A",
                        patientType: PatientController.getPatientType(item),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return kHeight10;
                  },
                ),
            ],
          ),
        );
      }),
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        height: 1.0,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        hintText: 'Search by name or phone',
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: Colors.black.withOpacity(0.6),
        ),
        filled: true,
        fillColor: Colors.white,
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

class DateDropdown extends StatelessWidget {
  final List<String> dates;
  final String? selectedDate;
  final Function(String?) onDateSelected;

  const DateDropdown({
    super.key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169.w,
      height: 39.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.r),
        border: Border.all(
          color: const Color(0x4D000000),
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
            angle: -90 * 3.1416 / 180,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20.w,
              color: Colors.black,
            ),
          ),
          isExpanded: true,
          onChanged: onDateSelected,
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
