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
  var selectedBranchId = ''.obs;

  List<String> locationOptions = ['Location A', 'Location B', 'Location C'];
  var branchOptions = <String>[].obs;

  @override
  void onReady() {
    getBranchListData();
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> getTreatmentData() async {
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
    showLoaderDialog();
    try {
      final response = await Services.getBranchList();
      getTreatmentData();
      Get.back();
      if (response.isSuccess) {
        branchListResponse =
            BranchListResponse.fromJson(response.response.body);
        branches.value = branchListResponse.branches ?? [];
        print("::${branches.value}::");
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
    debugPrint("branchId ${selectedBranchId.value}");
    double? totalAmount = double.tryParse(totalAmountController.text);
    double? advanceAmount = double.tryParse(advanceAmountController.text);
    double? balanceAmount = double.tryParse(balanceAmountController.text);
    double? discountAmount = double.tryParse(discountAmountController.text);
    // int? branchId = int.tryParse(selectedBranch.value);
    List<int> selectedTreatmentIds =
        selectedTreatmentsList.map((t) => int.parse(t.treatmentId)).toList();

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
                selectedBranchId.value,
                selectedTreatmentIds)
            .then((response) async {
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

  RxList<SelectedTreatment> selectedTreatmentsList = <SelectedTreatment>[].obs;

  void saveTreatmentsList() {
    if (selectedTreatment.isEmpty) {
      showCustomSnackBar("Please select a treatment", isError: true);

      return;
    }

    if (maleCount.value == 0 && femaleCount.value == 0) {
      showCustomSnackBar("Please add at least one patient");
      return;
    }

    // Save to list
    final treatmentData = SelectedTreatment(
      treatmentId: selectedTreatment.value,
      maleCount: maleCount.value,
      femaleCount: femaleCount.value,
    );

    selectedTreatmentsList.add(treatmentData);
    printSelectedTreatments();
    // Reset fields
    Get.back();
    selectedTreatment.value = '';
    maleCount.value = 0;
    femaleCount.value = 0;

    showCustomSnackBar("Treatment added successfully", isError: false);
  }

  void printSelectedTreatments() {
    for (var item in selectedTreatmentsList) {
      print(
          "Treatment ID: ${item.treatmentId}, Male: ${item.maleCount}, Female: ${item.femaleCount}");
    }
  }
}

class SelectedTreatment {
  final String treatmentId;
  final int maleCount;
  final int femaleCount;

  SelectedTreatment({
    required this.treatmentId,
    required this.maleCount,
    required this.femaleCount,
  });
}
