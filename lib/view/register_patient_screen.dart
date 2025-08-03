import 'package:ayurvedic_centre_patients/controllers/register_patient_controller.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_dropdown.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_hour_minute__picker.dart';
import 'package:ayurvedic_centre_patients/widgets/login_input_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/treatments_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/custom_date_picker.dart';
import '../widgets/treatm_bottomsheet.dart';

class RegisterPatientScreen extends StatelessWidget {
  RegisterPatientScreen({super.key});

  final RegisterPatientController controller =
      Get.put(RegisterPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(mobilePadding),
        children: [
          kHeight20,
          Text(
            'Register',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              // SemiBold
              fontSize: 30.sp,
              // if using flutter_screenutil
              height: 1.4,
              // 140% line height
              letterSpacing: 0.0,
              color: Colors.black, // change if needed
            ),
          ),
          kHeight20,
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobilePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your full name",
                  controller: controller.nameController,
                ),
                kHeight10,
                Text(
                  'Whatsapp Number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your Whatsapp number",
                  controller: controller.whatsappController,
                ),
                kHeight10,
                Text(
                  'Address',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "Enter your full address",
                  controller: controller.addressController,
                ),
                kHeight10,
                // CustomDropdown<String>(
                //   hintText: 'Select Your Location',
                //   label: 'Location',
                //   value: controller.selectedLocation.value,
                //   items: controller.locationOptions
                //       .map(
                //         (loc) => DropdownMenuItem(value: loc, child: Text(loc)),
                //       )
                //       .toList(),
                //   onChanged: (value) {
                //     controller.selectedLocation.value =
                //         value!; // Fix: assign value TO selectedLocation
                //     // Update your state if using setState() or your state management solution
                //   },
                // ),
                kHeight10,
                Obx(() {
                  return CustomDropdown<String>(
                    hintText: 'Select the branch',
                    label: 'Branch',
                    value: controller.selectedBranch.value,
                    items: controller.branchOptions.value
                        .map(
                          (loc) =>
                              DropdownMenuItem(value: loc, child: Text(loc)),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedBranch.value =
                          value!; // Fix: assign value TO selectedLocation
                      // Update your state if using setState() or your state management solution
                    },
                  );
                }),
                kHeight10,

                Text(
                  'Treatments',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                TreatmentsWidget(),
                kHeight9,
                InkWell(
                  onTap: () => Get.bottomSheet(TreatmentFormScreen()),
                  child: Container(
                    width: 350.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF81C784),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 8.w),
                          Text(
                            '+ Add Treatments',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              height: 1.0,
                              letterSpacing: 0.0,
                              color: Colors.black, // Or your preferred color
                            ),
                          ),
                          // CustomText(
                          //   text: 'Add Treatments',
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w600,
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                kHeight10,
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "00",
                  controller: controller.totalAmountController,
                ),
                kHeight10,
                Text(
                  'Discount Amount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "00",
                  controller: controller.discountAmountController,
                ),
                kHeight10,
                Text(
                  'Payment Option',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                Obx(() {
                  return Wrap(
                    spacing: 60,
                    runSpacing: 8,
                    children: [
                      _buildPaymentOption('Cash', controller),
                      _buildPaymentOption('UPI', controller),
                      _buildPaymentOption('Card', controller),
                    ],
                  );
                }),
                kHeight10,
                Text(
                  'Advance Amount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "00",
                  controller: controller.advanceAmountController,
                ),
                kHeight10,
                kHeight10,
                Text(
                  'Balance Amount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.0,
                    letterSpacing: 0.0,
                    color: Colors.black, // Or your preferred color
                  ),
                ),
                kHeight9,
                LoginTextField(
                  keyBoardType: TextInputType.name,
                  icon: 'icon',
                  hintText: "00",
                  controller: controller.balanceAmountController,
                ),
                kHeight10,
                Obx(() {
                  return CustomDatePicker(
                    label: "Treatment Date",
                    selectedDate: controller.selectedDate.value,
                    onDateSelected: controller.setSelectedDate,
                  );
                }),
                kHeight15,
                CustomHourMinutePicker(
                  label: "Treatment Time",
                  selectedHour: controller.selectedHour,
                  selectedMinute: controller.selectedMinute,
                  onTimeSelected: controller.setSelectedTime,
                ),
                kHeight15
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPaymentOption(
    String method, RegisterPatientController controller) {
  return GestureDetector(
    onTap: () => controller.selectPayment(method),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: controller.selectedPayment.value == method
            ? Colors.green
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        method,
        style: TextStyle(
          color: controller.selectedPayment.value == method
              ? Colors.white
              : Colors.black,
        ),
      ),
    ),
  );
}
