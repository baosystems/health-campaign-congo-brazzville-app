// To parse this JSON data, do
//
//     final vaccineDoseVariant = vaccineDoseVariantFromJson(jsonString);

import 'dart:convert';

VaccineDoseVariant vaccineDoseVariantFromJson(String str) =>
    VaccineDoseVariant.fromJson(json.decode(str));

String vaccineDoseVariantToJson(VaccineDoseVariant data) =>
    json.encode(data.toJson());

class VaccineDoseVariant {
  String productVariationId;
  int numberOfDose;
  List<String> vaccineDoseKeys;

  VaccineDoseVariant({
    required this.productVariationId,
    required this.numberOfDose,
    required this.vaccineDoseKeys,
  });

  factory VaccineDoseVariant.fromJson(Map<String, dynamic> json) =>
      VaccineDoseVariant(
        productVariationId: json["productVariationId"],
        numberOfDose: json["numberOfDose"],
        vaccineDoseKeys:
            List<String>.from(json["vaccineDoseKeys"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "productVariationId": productVariationId,
        "numberOfDose": numberOfDose,
        "vaccineDoseKeys": List<dynamic>.from(vaccineDoseKeys.map((x) => x)),
      };
}
