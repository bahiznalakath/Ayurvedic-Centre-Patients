import 'package:ayurvedic_centre_patients/models/response_models/branch_list_response.dart';
import 'package:ayurvedic_centre_patients/models/response_models/treatment_list_response.dart';
import 'package:ayurvedic_centre_patients/services/login_service.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_snackbar.dart';
import 'package:ayurvedic_centre_patients/widgets/show_loader_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterPatientController extends GetxController {
  RxString selectedTreatment = ''.obs;
  var selectedPayment = 'Cash'.obs;

  RxInt maleCount = 0.obs;
  RxInt femaleCount = 0.obs;

  var treatmentListResponse = TreatmentListResponse();
  var branchListResponse = BranchListResponse();

  var treatments = <Treatment>[].obs;
  var branches = <BranchList>[].obs; // Renamed for clarity

  void selectPayment(String method) {
    selectedPayment.value = method;
  }

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  int? selectedHour;
  int? selectedMinute;

  void setSelectedTime(int hour, int minute) {
    selectedHour = hour;
    selectedMinute = minute;
    update(); // Notify UI to rebuild
  }

  // Use reactive nullable types
  var selectedLocation = "".obs;
  var selectedBranch = "".obs;

  List<String> locationOptions = ['Location A', 'Location B', 'Location C'];
  var branchOptions = <String>[].obs;

  @override
  void onInit() {
    loadInitialData();
    super.onInit();
  }

  Future<void> loadInitialData() async {
    showLoaderDialog();
    try {
      await Future.wait([
        getBranchListData(),
        getTreatmentData(), // Renamed from getPatientData
      ]);
    } catch (e) {
      showCustomSnackBar("Initialization failed: $e");
    } finally {
      Get.back(); // Close loader
    }
  }

  Future<void> getTreatmentData() async {
    // Renamed for clarity
    try {
      final response = await Services.getTreatmentUrl();
      if (response.isSuccess) {
        treatmentListResponse =
            TreatmentListResponse.fromJson(response.response.body);
        treatments.value = treatmentListResponse.treatments ?? [];
      } else {
        showCustomSnackBar(response.message);
      }
    } catch (e) {
      showCustomSnackBar("Failed to load treatments: $e");
    }
  }

  Future<void> getBranchListData() async {
    try {
      final response = await Services.getBranchList();
      if (response.isSuccess) {
        branchListResponse =
            BranchListResponse.fromJson(response.response.body);
        branches.value = branchListResponse.branches ?? [];
        branchOptions.value =
            branches.map((branch) => branch.name ?? 'Unnamed Branch').toList();
      } else {
        showCustomSnackBar(response.message);
      }
    } catch (e) {
      showCustomSnackBar("Failed to load branches: $e");
    }
  }

  // --- Counter Functions (preserved as requested) ---
  void incrementMale() => maleCount.value++;

  void decrementMale() {
    if (maleCount.value > 0) maleCount.value--;
  }

  void incrementFemale() => femaleCount.value++;

  void decrementFemale() {
    if (femaleCount.value > 0) femaleCount.value--;
  }

  // ------------------------------------------------

  void setTreatment(String treatment) {
    selectedTreatment.value = treatment;
  }

  var nameController = TextEditingController();
  var whatsappController = TextEditingController();
  var addressController = TextEditingController();
  var totalAmountController = TextEditingController();
  var advanceAmountController = TextEditingController();
  var discountAmountController = TextEditingController();
  var balanceAmountController = TextEditingController();

  void submit() async {
    double? totalAmount = double.tryParse(totalAmountController.text);
    double? advanceAmount = double.tryParse(advanceAmountController.text);
    double? balanceAmount = double.tryParse(balanceAmountController.text);
    double? discountAmount = double.tryParse(discountAmountController.text);
    String convertedDate = selectedDate.value != null
        ? DateFormat('dd/MM/yyyy - hh:mm a').format(selectedDate.value!)
        : '';
    if (nameController.text.isEmpty) {
      showCustomSnackBar('Name field is required.!', isError: true);
    } else if (whatsappController.text.isEmpty) {
      showCustomSnackBar('WhatsApp field is required.!', isError: true);
    } else if (addressController.text.isEmpty) {
      showCustomSnackBar('Address field is required.!', isError: true);
    } else if (addressController.text.isEmpty) {
      showCustomSnackBar('Address field is required.!', isError: true);
    } else if (totalAmountController.text.isEmpty) {
      showCustomSnackBar('Total Amount field is required.!', isError: true);
    } else if (advanceAmountController.text.isEmpty) {
      showCustomSnackBar('Total Amount field is required.!', isError: true);
    } else if (selectedDate.value == '') {
      showCustomSnackBar('Total Amount field is required.!', isError: true);
    } else {
      try {
        showLoaderDialog();
        Services.registerationSubmit(
            nameController.text,
            whatsappController.text,
            addressController.text,
            selectedLocation.value,
            selectedBranch.value,
            totalAmount!,
            discountAmount!,
            advanceAmount!,
            balanceAmount!,
            convertedDate,
            '',
            '',
            int.parse(selectedBranch.value), []).then((response) async {
          Get.back();
          if (response.isSuccess) {
            // loginResponse = LoginResponse.fromJson(response.response.body);
            // SharedStorage().setSharedString(
            //   AppConstants.userToken,
            //   loginResponse.token ?? "",
            // );
            //
            // debugPrint("hehhehheh${loginResponse.token}");
            // saveResponse(loginResponse);
            // Get.back();
            // Get.offAll(PatientListScreen());
            showCustomSnackBar(response.message);
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } finally {}
    }
  }
}
