// To parse this JSON data, do
//
//     final patientListResponse = patientListResponseFromJson(jsonString);

import 'dart:convert';

PatientListResponse patientListResponseFromJson(String str) =>
    PatientListResponse.fromJson(json.decode(str));

String patientListResponseToJson(PatientListResponse data) =>
    json.encode(data.toJson());

class PatientListResponse {
  final bool? status;
  final String? message;
  final List<Patient>? patient;

  PatientListResponse({
    this.status,
    this.message,
    this.patient,
  });

  PatientListResponse copyWith({
    bool? status,
    String? message,
    List<Patient>? patient,
  }) =>
      PatientListResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        patient: patient ?? this.patient,
      );

  factory PatientListResponse.fromJson(Map<String, dynamic> json) =>
      PatientListResponse(
        status: json["status"],
        message: json["message"],
        patient: json["patient"] == null
            ? []
            : List<Patient>.from(
                json["patient"]!.map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "patient": patient == null
            ? []
            : List<dynamic>.from(patient!.map((x) => x.toJson())),
      };
}

class Patient {
  final int? id;
  final List<PatientdetailsSet>? patientdetailsSet;
  final Branch? branch;
  final String? user;
  final String? payment;
  final String? name;
  final String? phone;
  final String? address;
  final dynamic price;
  final int? totalAmount;
  final int? discountAmount;
  final int? advanceAmount;
  final int? balanceAmount;
  final DateTime? dateNdTime;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Patient({
    this.id,
    this.patientdetailsSet,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Patient copyWith({
    int? id,
    List<PatientdetailsSet>? patientdetailsSet,
    Branch? branch,
    String? user,
    String? payment,
    String? name,
    String? phone,
    String? address,
    dynamic price,
    int? totalAmount,
    int? discountAmount,
    int? advanceAmount,
    int? balanceAmount,
    DateTime? dateNdTime,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Patient(
        id: id ?? this.id,
        patientdetailsSet: patientdetailsSet ?? this.patientdetailsSet,
        branch: branch ?? this.branch,
        user: user ?? this.user,
        payment: payment ?? this.payment,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        price: price ?? this.price,
        totalAmount: totalAmount ?? this.totalAmount,
        discountAmount: discountAmount ?? this.discountAmount,
        advanceAmount: advanceAmount ?? this.advanceAmount,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        dateNdTime: dateNdTime ?? this.dateNdTime,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        patientdetailsSet: json["patientdetails_set"] == null
            ? []
            : List<PatientdetailsSet>.from(json["patientdetails_set"]!
                .map((x) => PatientdetailsSet.fromJson(x))),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        user: json["user"],
        payment: json["payment"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        price: json["price"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        advanceAmount: json["advance_amount"],
        balanceAmount: json["balance_amount"],
        dateNdTime: json["date_nd_time"] == null
            ? null
            : DateTime.parse(json["date_nd_time"]),
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientdetails_set": patientdetailsSet == null
            ? []
            : List<dynamic>.from(patientdetailsSet!.map((x) => x.toJson())),
        "branch": branch?.toJson(),
        "user": user,
        "payment": payment,
        "name": name,
        "phone": phone,
        "address": address,
        "price": price,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime?.toIso8601String(),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Branch {
  final int? id;
  final String? name;
  final int? patientsCount;
  final String? location;
  final String? phone;
  final String? mail;
  final String? address;
  final String? gst;
  final bool? isActive;

  Branch({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  Branch copyWith({
    int? id,
    String? name,
    int? patientsCount,
    String? location,
    String? phone,
    String? mail,
    String? address,
    String? gst,
    bool? isActive,
  }) =>
      Branch(
        id: id ?? this.id,
        name: name ?? this.name,
        patientsCount: patientsCount ?? this.patientsCount,
        location: location ?? this.location,
        phone: phone ?? this.phone,
        mail: mail ?? this.mail,
        address: address ?? this.address,
        gst: gst ?? this.gst,
        isActive: isActive ?? this.isActive,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        patientsCount: json["patients_count"],
        location: json["location"],
        phone: json["phone"],
        mail: json["mail"],
        address: json["address"],
        gst: json["gst"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "patients_count": patientsCount,
        "location": location,
        "phone": phone,
        "mail": mail,
        "address": address,
        "gst": gst,
        "is_active": isActive,
      };
}

class PatientdetailsSet {
  final int? id;
  final String? male;
  final String? female;
  final int? patient;
  final int? treatment;
  final String? treatmentName;

  PatientdetailsSet({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  PatientdetailsSet copyWith({
    int? id,
    String? male,
    String? female,
    int? patient,
    int? treatment,
    String? treatmentName,
  }) =>
      PatientdetailsSet(
        id: id ?? this.id,
        male: male ?? this.male,
        female: female ?? this.female,
        patient: patient ?? this.patient,
        treatment: treatment ?? this.treatment,
        treatmentName: treatmentName ?? this.treatmentName,
      );

  factory PatientdetailsSet.fromJson(Map<String, dynamic> json) =>
      PatientdetailsSet(
        id: json["id"],
        male: json["male"],
        female: json["female"],
        patient: json["patient"],
        treatment: json["treatment"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "male": male,
        "female": female,
        "patient": patient,
        "treatment": treatment,
        "treatment_name": treatmentName,
      };
}
