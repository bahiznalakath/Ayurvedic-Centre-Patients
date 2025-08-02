import 'package:ayurvedic_centre_patients/models/response_models/patient_list_response.dart';
import 'package:ayurvedic_centre_patients/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(mobilePadding),
        children: [
          _buildDetailCard(),
          SizedBox(height: 20.h),
          _buildTreatmentSection(),
          SizedBox(height: 20.h),
          _buildPaymentSection(),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Name', patient.name ?? 'N/A'),
            _buildDetailRow('Phone', patient.phone ?? 'N/A'),
            _buildDetailRow('Address', patient.address ?? 'N/A'),
            _buildDetailRow('Branch', patient.branch?.name ?? 'N/A'),
            _buildDetailRow(
                'Date & Time',
                patient.dateNdTime != null
                    ? '${_formatDate(patient.dateNdTime!)} ${_formatTime(patient.dateNdTime!)}'
                    : 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Treatments', style: _sectionHeaderStyle()),
            SizedBox(height: 10.h),
            if (patient.patientdetailsSet?.isEmpty ?? true)
              Text('No treatments found', style: _normalTextStyle()),
            if (patient.patientdetailsSet?.isNotEmpty ?? false)
              ...patient.patientdetailsSet!
                  .map((detail) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (detail.treatmentName != null)
                              Text(detail.treatmentName!,
                                  style: _boldTextStyle()),
                            if (detail.male != null && detail.male!.isNotEmpty)
                              Text('Male: ${detail.male}',
                                  style: _normalTextStyle()),
                            if (detail.female != null &&
                                detail.female!.isNotEmpty)
                              Text('Female: ${detail.female}',
                                  style: _normalTextStyle()),
                          ],
                        ),
                      ))
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Details', style: _sectionHeaderStyle()),
            SizedBox(height: 10.h),
            _buildPaymentRow('Total Amount', patient.totalAmount),
            _buildPaymentRow('Discount Amount', patient.discountAmount),
            _buildPaymentRow('Advance Amount', patient.advanceAmount),
            Divider(height: 20.h),
            _buildPaymentRow('Balance Amount', patient.balanceAmount,
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(title, style: _boldTextStyle()),
          ),
          Expanded(
            child: Text(value, style: _normalTextStyle()),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String title, int? value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isTotal ? _boldTextStyle() : _normalTextStyle()),
          Text(
            '₹${value?.toString() ?? '0'}',
            style: isTotal
                ? _boldTextStyle().copyWith(color: Colors.green)
                : _normalTextStyle(),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  String _formatTime(DateTime date) {
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  TextStyle _sectionHeaderStyle() {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
      color: Colors.black,
    );
  }

  TextStyle _boldTextStyle() {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: Colors.black,
    );
  }

  TextStyle _normalTextStyle() {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: Colors.black87,
    );
  }
}
