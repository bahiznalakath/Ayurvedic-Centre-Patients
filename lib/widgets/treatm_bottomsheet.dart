import 'package:ayurvedic_centre_patients/controllers/register_patient_controller.dart';
import 'package:ayurvedic_centre_patients/models/response_models/treatment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Treatment Form Screen
class TreatmentFormScreen extends StatelessWidget {
  @override
  final RegisterPatientController controller =
      Get.find<RegisterPatientController>();

  TreatmentFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Choose Treatment Section
              Text(
                'Choose Treatment',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16.h),

              // Treatment Dropdown
              Obx(() => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.w,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedTreatment.value.isEmpty
                            ? null
                            : controller.selectedTreatment.value,
                        hint: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'Choose preferred treatment',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        isExpanded: true,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                            size: 24.sp,
                          ),
                        ),
                        items: controller.treatments.map((Treatment treatment) {
                          return DropdownMenuItem<String>(
                            value: treatment.id.toString(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                treatment.name ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.setTreatment(newValue);
                          }
                        },
                      ),
                    ),
                  )),

              SizedBox(height: 32.h),

              // Add Patients Section
              Text(
                'Add Patients',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20.h),

              // Male Counter
              Obx(() => PatientCounterRow(
                    label: 'Male',
                    count: controller.maleCount.value,
                    onDecrement: controller.decrementMale,
                    onIncrement: controller.incrementMale,
                  )),

              SizedBox(height: 16.h),

              // Female Counter
              Obx(() => PatientCounterRow(
                    label: 'Female',
                    count: controller.femaleCount.value,
                    onDecrement: controller.decrementFemale,
                    onIncrement: controller.incrementFemale,
                  )),

              Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: controller.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Patient Counter Row Widget
class PatientCounterRow extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const PatientCounterRow({
    Key? key,
    required this.label,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Label
        Container(
          width: 100.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        SizedBox(width: 16.w),

        // Decrement Button
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.green[700],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onDecrement,
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: 20.sp,
            ),
            padding: EdgeInsets.zero,
          ),
        ),

        SizedBox(width: 16.w),

        // Count Display
        Container(
          width: 60.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),

        SizedBox(width: 16.w),

        // Increment Button
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.green[700],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onIncrement,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 20.sp,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
