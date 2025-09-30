// GENERATED using mason_cli
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:digit_data_model/data_model.dart';

import '../../utils/typedefs.dart';

// import '../utils/typedefs.dart';

part 'vaccine_product_variants.freezed.dart';

typedef VaccineProductVariantEmitter = Emitter<VaccineProductVariantState>;

// Bloc for handling product variant related events and states
class VaccineProductVariantBloc
    extends Bloc<VaccineProductVariantEvent, VaccineProductVariantState> {
  final ProjectResourceDataRepository projectResourceDataRepository;
  final ProductVariantDataRepository productVariantDataRepository;

  VaccineProductVariantBloc(
      {required this.projectResourceDataRepository,
      required this.productVariantDataRepository})
      : super(const VaccineProductVariantState.loading()) {
    on<VaccineProductVariantLoadEvent>(_handleLoad);
  }

  // Event handler for loading product variants
  FutureOr<void> _handleLoad(
    VaccineProductVariantLoadEvent event,
    VaccineProductVariantEmitter emit,
  ) async {
    // Emitting the loading state
    emit(const VaccineProductVariantLoadingState());
    // Fetching the product variants
    final projectResources = await projectResourceDataRepository.search(
      event.query,
    );

    final productVariants = await productVariantDataRepository.search(
      ProductVariantSearchModel(
        id: projectResources.map((e) {
          return e.resource.productVariantId;
        }).toList(),
      ),
    );

    // Checking if the product variants are null
    if (productVariants.isEmpty) {
      // Emitting the empty state if product variants are null
      emit((const VaccineProductVariantEmptyState()));
    } else {
      // Emitting the fetched state with the fetched product variants
      emit(
          VaccineProductVariantState.fetched(productVariants: productVariants));
    }
  }
}

// Freezed union class for product variant events
@freezed
class VaccineProductVariantEvent with _$VaccineProductVariantEvent {
  // Event for loading product variants
  const factory VaccineProductVariantEvent.load({
    required ProjectResourceSearchModel query,
  }) = VaccineProductVariantLoadEvent;
}

// Freezed union class for product variant states
@freezed
class VaccineProductVariantState with _$VaccineProductVariantState {
  // State for when the product variants are being loaded
  const factory VaccineProductVariantState.loading() =
      VaccineProductVariantLoadingState;

  // State for when there are no product variants
  const factory VaccineProductVariantState.empty() =
      VaccineProductVariantEmptyState;

  // State for when the product variants have been fetched
  const factory VaccineProductVariantState.fetched({
    required List<ProductVariantModel> productVariants,
  }) = VaccineProductVariantFetchedState;
}
