// To parse this JSON data, do
//
//     final vaccineDeliveryDetails = vaccineDeliveryDetailsFromJson(jsonString);

import 'dart:convert';

List<VaccineDeliveryDetails> vaccineDeliveryDetailsFromJson(String str) =>
    List<VaccineDeliveryDetails>.from(
        json.decode(str).map((x) => VaccineDeliveryDetails.fromJson(x)));

String vaccineDeliveryDetailsToJson(List<VaccineDeliveryDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VaccineDeliveryDetails {
  String vaccineName;
  String batchNumber;
  int numberOfDose;

  VaccineDeliveryDetails({
    required this.vaccineName,
    required this.batchNumber,
    required this.numberOfDose,
  });

  factory VaccineDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      VaccineDeliveryDetails(
        vaccineName: json["vaccineName"],
        batchNumber: json["batchNumber"],
        numberOfDose: json["numberOfDose"],
      );

  Map<String, dynamic> toJson() => {
        "vaccineName": vaccineName,
        "batchNumber": batchNumber,
        "numberOfDose": numberOfDose,
      };
}
