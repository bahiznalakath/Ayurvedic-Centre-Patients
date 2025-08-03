import 'package:ayurvedic_centre_patients/controllers/register_patient_controller.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:ayurvedic_centre_patients/widgets/button_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_dropdown.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_hour_minute__picker.dart';
import 'package:ayurvedic_centre_patients/widgets/login_input_widget.dart';
import 'package:ayurvedic_centre_patients/widgets/treatments_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../models/response_models/treatment_list_response.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/treatm_bottomsheet.dart';

class RegisterPatientScreen extends StatelessWidget {
  RegisterPatientScreen({super.key});

  final RegisterPatientController controller =
      Get.put(RegisterPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(mobilePadding),
        child: InkWell(
            onTap: () => controller.submit(),
            child: ButtonWidget(title: "Register Now")),
      ),
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
                Text(
                  'Location',
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
                  return CustomSelectionDropdown(
                    label: 'Select Your Location',
                    onChanged: (item) {
                      controller.selectedLocation.value = item!;
                    },
                    itemValue: controller.selectedLocation.value,
                    items: controller.locationOptions
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value ?? "",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            height: 1.4,
                            letterSpacing: 0.0,
                            color: Colors.black, // change if needed
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                Text(
                  'Branch',
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
                  return CustomSelectionDropdown(
                    label: 'Select Your branch',
                    onChanged: (item) {
                      controller.selectedBranchId.value = item!;
                    },
                    itemValue: controller.selectedBranchId.value,
                    items: controller.branches
                        .map<DropdownMenuItem<String>>((value) {
                      // debugPrint()
                      return DropdownMenuItem<String>(
                        value: value.name.toString(),
                        child: Text(
                          value.name ?? "",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            height: 1.4,
                            letterSpacing: 0.0,
                            color: Colors.black, // change if needed
                          ),
                        ),
                      );
                    }).toList(),
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
                Obx(() => Column(
                      children: controller.selectedTreatmentsList.map((item) {
                        final treatment = controller.treatments.firstWhere(
                          (t) => t.id.toString() == item.treatmentId,
                          orElse: () => Treatment(
                              id: int.parse(item.treatmentId), name: 'Unknown'),
                        );

                        return TreatmentsWidget(
                          treatmentName: treatment.name ?? "Unknown",
                          maleCount: item.maleCount,
                          femaleCount: item.femaleCount,
                          onDelete: () {
                            controller.selectedTreatmentsList.remove(item);
                          },
                          onEdit: () {
                            Get.bottomSheet(
                              TreatmentFormScreen(
                                treatmentId: item.treatmentId,
                                male: item.maleCount,
                                female: item.femaleCount,
                              ),
                            );
                            controller.selectedTreatmentsList.remove(item);
                          },
                        );
                      }).toList(),
                    )),
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
                  keyBoardType: TextInputType.number,
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
                  keyBoardType: TextInputType.number,
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
                  keyBoardType: TextInputType.number,
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
                  keyBoardType: TextInputType.number,
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
          ),
          kHeight30,
          kHeight30,
          kHeight30,
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
