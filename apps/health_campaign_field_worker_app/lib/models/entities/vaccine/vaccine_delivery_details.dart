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
  String productVariationId;
  String vaccineCode;
  String? batchNumber;
  int numberOfDose;

  VaccineDeliveryDetails({
    required this.productVariationId,
    required this.vaccineCode,
    this.batchNumber,
    this.numberOfDose = 0,
  });

  factory VaccineDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      VaccineDeliveryDetails(
        productVariationId: json["productVariationId"],
        vaccineCode: json["vaccineCode"],
        batchNumber: json["batchNumber"],
        numberOfDose: json["numberOfDose"],
      );

  Map<String, dynamic> toJson() => {
        "productVariationId": productVariationId,
        "vaccineCode": vaccineCode,
        "batchNumber": batchNumber,
        "numberOfDose": numberOfDose,
      };
}
