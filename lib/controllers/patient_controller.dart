import 'package:ayurvedic_centre_patients/models/response_models/patient_list_response.dart';
import 'package:ayurvedic_centre_patients/services/login_service.dart';
import 'package:ayurvedic_centre_patients/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {
  var patientResponse = PatientListResponse();
  var patientList = <Patient>[].obs;
  var filteredPatientList = <Patient>[].obs;
  var selectedDate = Rx<String?>(null);
  var searchQuery = ''.obs;
  var datesList = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    getPatientData();
    super.onReady();
  }

  Future<void> getPatientData() async {
    isLoading.value = true;
    try {
      final response = await Services.getPatientListUrl();
      if (response.isSuccess) {
        patientResponse = PatientListResponse.fromJson(response.response.body);
        patientList.value = patientResponse.patient ?? [];
        filteredPatientList.value = patientList;
        extractDates();
        debugPrint("Patient Data: $patientResponse");
      } else {
        showCustomSnackBar(response.message);
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void extractDates() {
    final uniqueDates = <String>{};

    for (final patient in patientList) {
      if (patient.dateNdTime != null) {
        final dateStr = patient.dateNdTime!.toLocal().toString().split(' ')[0];
        uniqueDates.add(dateStr);
      }
    }

    datesList.value = uniqueDates.toList()
      ..sort((a, b) => b.compareTo(a)); // Sort descending (newest first)

    if (datesList.isNotEmpty) {
      selectedDate.value = datesList.first;
    }
  }

  void filterPatients() {
    if (searchQuery.isEmpty && selectedDate.value == null) {
      filteredPatientList.value = patientList;
      return;
    }

    filteredPatientList.value = patientList.where((patient) {
      // Filter by date
      final dateMatch = selectedDate.value == null ||
          (patient.dateNdTime != null &&
              patient.dateNdTime!.toLocal().toString().split(' ')[0] ==
                  selectedDate.value);

      // Case-insensitive search (name or phone)
      final normalizedQuery = searchQuery.value.trim().toLowerCase();
      final searchMatch = normalizedQuery.isEmpty ||
          (patient.name?.toLowerCase().contains(normalizedQuery) == true) ||
          (patient.name
                  ?.toUpperCase()
                  .contains(normalizedQuery.toUpperCase()) ==
              true) ||
          (patient.phone?.toLowerCase().contains(normalizedQuery) == true) ||
          (patient.phone
                  ?.toUpperCase()
                  .contains(normalizedQuery.toUpperCase()) ==
              true);

      return dateMatch && searchMatch;
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterPatients();
  }

  void setSelectedDate(String? date) {
    selectedDate.value = date;
    filterPatients();
  }

  static String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  static String getTreatmentNames(Patient patient) {
    if (patient.patientdetailsSet == null ||
        patient.patientdetailsSet!.isEmpty) {
      return "No treatments";
    }
    return patient.patientdetailsSet!
        .map((detail) => detail.treatmentName ?? "Treatment")
        .join(", ");
  }

  static String getPatientType(Patient patient) {
    if (patient.patientdetailsSet == null) return "0 persons";

    int count = 0;
    for (final detail in patient.patientdetailsSet!) {
      if (detail.male != null && detail.male!.isNotEmpty) count++;
      if (detail.female != null && detail.female!.isNotEmpty) count++;
    }

    return "$count ${count == 1 ? 'person' : 'persons'}";
  }
}
