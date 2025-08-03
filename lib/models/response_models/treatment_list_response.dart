// To parse this JSON data, do
//
//     final treatmentListResponse = treatmentListResponseFromJson(jsonString);

import 'dart:convert';

TreatmentListResponse treatmentListResponseFromJson(String str) =>
    TreatmentListResponse.fromJson(json.decode(str));

String treatmentListResponseToJson(TreatmentListResponse data) =>
    json.encode(data.toJson());

class TreatmentListResponse {
  final bool? status;
  final String? message;
  final List<Treatment>? treatments;

  TreatmentListResponse({
    this.status,
    this.message,
    this.treatments,
  });

  TreatmentListResponse copyWith({
    bool? status,
    String? message,
    List<Treatment>? treatments,
  }) =>
      TreatmentListResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        treatments: treatments ?? this.treatments,
      );

  factory TreatmentListResponse.fromJson(Map<String, dynamic> json) =>
      TreatmentListResponse(
        status: json["status"],
        message: json["message"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
                json["treatments"]!.map((x) => Treatment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
      };
}

class Treatment {
  final int? id;
  final List<Branch>? branches;
  final String? name;
  final String? duration;
  final String? price;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Treatment({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Treatment copyWith({
    int? id,
    List<Branch>? branches,
    String? name,
    String? duration,
    String? price,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Treatment(
        id: id ?? this.id,
        branches: branches ?? this.branches,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        branches: json["branches"] == null
            ? []
            : List<Branch>.from(
                json["branches"]!.map((x) => Branch.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
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
        "branches": branches == null
            ? []
            : List<dynamic>.from(branches!.map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
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
