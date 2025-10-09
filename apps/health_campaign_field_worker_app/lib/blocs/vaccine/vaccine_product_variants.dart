// GENERATED using mason_cli
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:digit_data_model/data_model.dart';

import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/entities/vaccine/vaccine_dose_variant.dart';
import '../../utils/constants.dart';
import '../../utils/typedefs.dart';

// import '../utils/typedefs.dart';

part 'vaccine_product_variants.freezed.dart';

typedef VaccineProductVariantEmitter = Emitter<VaccineProductVariantState>;

// Bloc for handling product variant related events and states
class VaccineProductVariantBloc
    extends Bloc<VaccineProductVariantEvent, VaccineProductVariantState> {
  final ProjectResourceDataRepository projectResourceDataRepository;
  final ProductVariantDataRepository productVariantDataRepository;

  VaccineProductVariantBloc(super.initialState,
      {required this.projectResourceDataRepository,
      required this.productVariantDataRepository}) {
    on(_handleLoad);
  }

  // Event handler for loading product variants
  FutureOr<void> _handleLoad(
    VaccineProductVariantLoadEvent event,
    VaccineProductVariantEmitter emit,
  ) async {
    // Emitting the loading state
    emit(state.copyWith(loading: true));
    // Fetching the product variants
    final projectResources = await projectResourceDataRepository.search(
      ProjectResourceSearchModel(projectId: [event.projectId]),
    );

    final productVariants = await productVariantDataRepository.search(
      ProductVariantSearchModel(
        id: projectResources.map((e) {
          return e.resource.productVariantId;
        }).toList(),
      ),
    );

    List<VaccineDoseData> vaccineDataList = event.vaccineDataList ?? [];
    Set allVaccineCodes = {};
    for (var v in vaccineDataList) {
      allVaccineCodes.add(v.code);
    }
    Map<String, VaccineDoseVariant> vaccineDoseDataVariation = {};
    for (var code in allVaccineCodes) {
      String productVariationId = productVariants
              .firstWhereOrNull((element) => element.sku == code)
              ?.id ??
          '';
      List<String> vaccineDoseKeys = vaccineDataList
          .where((element) => element.code == code)
          .map((e) => e.doseCode)
          .toList();
      vaccineDoseDataVariation[code] = VaccineDoseVariant(
          productVariationId: productVariationId,
          numberOfDose: vaccineDoseKeys.length,
          vaccineDoseKeys: vaccineDoseKeys);
    }
    emit(state.copyWith(
      loading: false,
      productVariants: productVariants,
      vaccineDataList: vaccineDataList,
      vaccineDoseDataVariation: vaccineDoseDataVariation,
    ));
  }
}

// Freezed union class for product variant events
@freezed
class VaccineProductVariantEvent with _$VaccineProductVariantEvent {
  // Event for loading product variants
  const factory VaccineProductVariantEvent.load({
    required String projectId,
    required List<VaccineDoseData>? vaccineDataList,
  }) = VaccineProductVariantLoadEvent;
}

// Freezed union class for product variant states
@freezed
class VaccineProductVariantState with _$VaccineProductVariantState {
  const factory VaccineProductVariantState({
    bool? loading,
    List<ProductVariantModel>? productVariants,
    List<VaccineDoseData>? vaccineDataList,
    Map<String, VaccineDoseVariant>? vaccineDoseDataVariation,
  }) = _VaccineProductVariantState;
}
