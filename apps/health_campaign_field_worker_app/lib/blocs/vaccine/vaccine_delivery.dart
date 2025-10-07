import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/task.dart';

import '../../models/entities/vaccine/vaccine_delivery_details.dart';
import '../../utils/constants.dart';

part 'vaccine_delivery.freezed.dart';

typedef VaccineDeliveryEmitter = Emitter<VaccineDeliveryState>;

class VaccineDeliveryBloc
    extends Bloc<VaccineDeliveryEvent, VaccineDeliveryState> {
  final DataRepository<TaskModel, TaskSearchModel> taskRepository;

  VaccineDeliveryBloc(
    super.initialState, {
    required this.taskRepository,
  }) {
    on(_handleAdditionalVaccineDose);
    on(_handleCurrentVaccineDose);
    on(_handleSubmit);
  }

  // Event handler for submitting a task
  FutureOr<void> _handleSubmit(
    VaccineDeliverySubmitEvent event,
    VaccineDeliveryEmitter emit,
  ) async {
    // Update loading state to indicate an operation is in progress
    emit(state.copyWith(loading: true));
    try {
      await taskRepository.update(event.task);
      if (event.currentDoseTask != null) {
        await taskRepository.create(event.currentDoseTask!);
      }
      emit(state.copyWith(loading: false));
    } catch (error) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  FutureOr<void> _handleCurrentVaccineDose(
    VaccineDeliveryVaccineSelectionEvent event,
    VaccineDeliveryEmitter emit,
  ) {
    emit(state.copyWith(loading: true));

    // Get all eligible vaccine codes by age index from the provided map
    List<String> eligibleVaccinesCode =
        _getEligibleVaccineDoseCodes(event.eligibleVaccinesCodeByAgeIndex);

    Set<String> filterVaccineDoseCodes = {};
    filterVaccineDoseCodes.addAll(event.availedVaccineDoseCodes);
    filterVaccineDoseCodes.addAll(state.filterVaccineDoseCodes ?? []);

    // Filter out vaccines that have already been availed
    Set<String> deliverableVaccineCodes = eligibleVaccinesCode
        .whereNot((e) => (filterVaccineDoseCodes.contains(e)))
        .toSet();

    deliverableVaccineCodes.addAll(state.additionalVaccineDoseCodes ?? []);

    // Determine the current vaccine dose codes that can be administered according to the availed vaccines
    Set<String> currentVaccineDoseDataCodes =
        deliverableVaccineCodes.where((vaccineCode) {
      //Only allow if previous dose was availed (for versioned vaccines)
      return _isVaccineAllowed(
        vaccineCode: vaccineCode,
        availedVaccineCodes: event.availedVaccineDoseCodes,
        allVaccineCodes: event.allVaccineDoseCodes,
      );
    }).toSet();

    // Determine the next vaccine dose codes that can be administered
    Set<String> nextVaccineDoseDataCodes = deliverableVaccineCodes
        .whereNot((e) => currentVaccineDoseDataCodes.contains(e))
        .toSet();

    List<VaccineDeliveryDetails> currentVaccineDoseData =
        currentVaccineDoseDataCodes.map((vaccineCode) {
      String productVariationId = event.productVariants
              .firstWhereOrNull(
                  (element) => vaccineCode.contains(element.sku ?? ""))
              ?.id ??
          '';
      return VaccineDeliveryDetails(
        productVariationId: productVariationId,
        vaccineCode: vaccineCode,
      );
    }).toList();

    emit(state.copyWith(
      loading: false,
      availedVaccineDoseCodes: event.availedVaccineDoseCodes,
      currentVaccineDoseData: currentVaccineDoseData,
      nextVaccineDoseData: nextVaccineDoseDataCodes,
    ));
  }

  FutureOr<void> _handleAdditionalVaccineDose(
    VaccineDeliveryAdditionalVaccineDoseEvent event,
    VaccineDeliveryEmitter emit,
  ) {
    if (event.filterVaccineDoseCodes != null) {
      emit(state.copyWith(
        filterVaccineDoseCodes: event.filterVaccineDoseCodes,
      ));
    }
    if (event.additionalVaccineDoseCodes != null) {
      emit(state.copyWith(
        additionalVaccineDoseCodes: event.additionalVaccineDoseCodes,
      ));
    }
  }

  List<String> _getEligibleVaccineDoseCodes(
      Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex) {
    List<String> eligibleVaccinesCode = [];
    for (var age in eligibleVaccinesCodeByAgeIndex.keys) {
      eligibleVaccinesCode
          .addAll((eligibleVaccinesCodeByAgeIndex[age] ?? {}).toList());
    }
    return eligibleVaccinesCode;
  }

  bool _isVaccineAllowed({
    required String vaccineCode,
    required List<String> availedVaccineCodes,
    required List<String> allVaccineCodes,
  }) {
    final match = RegExp(r'^(.*?)([_-])(\d+)$').firstMatch(vaccineCode);

    // Vaccine code is not versioned (like just 'BCG'), allow by default
    if (match == null) {
      return true;
    }

    final base = match.group(1)!;
    final sep = match.group(2)!;
    final number = int.tryParse(match.group(3)!);

    // Either no number or first dose — allow
    if (number == null || number == 0) {
      return true;
    }

    final prevCode = '$base$sep${number - 1}';

    // If there's no previous code, allow by default
    if (allVaccineCodes.contains(prevCode) == false) {
      return true;
    }

    // Allow only if previous code was selected as "YES"
    return availedVaccineCodes.contains(prevCode);
  }
}

@freezed
class VaccineDeliveryEvent with _$VaccineDeliveryEvent {
  const factory VaccineDeliveryEvent.submit({
    required TaskModel task,
    TaskModel? currentDoseTask,
  }) = VaccineDeliverySubmitEvent;
  const factory VaccineDeliveryEvent.vaccineSelection({
    required List<ProductVariantModel> productVariants,
    required Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex,
    required List<String> availedVaccineDoseCodes,
    required List<String> allVaccineDoseCodes,
  }) = VaccineDeliveryVaccineSelectionEvent;
  const factory VaccineDeliveryEvent.additionalVaccineDose({
    Set<String>? filterVaccineDoseCodes,
    Set<String>? additionalVaccineDoseCodes,
  }) = VaccineDeliveryAdditionalVaccineDoseEvent;
}

@freezed
class VaccineDeliveryState with _$VaccineDeliveryState {
  const factory VaccineDeliveryState({
    @Default(false) bool loading,
    List<String>? availedVaccineDoseCodes,
    List<VaccineDeliveryDetails>? currentVaccineDoseData,
    Set<String>? nextVaccineDoseData,
    Set<String>? filterVaccineDoseCodes,
    Set<String>? additionalVaccineDoseCodes,
  }) = _VaccineDeliveryState;
}
