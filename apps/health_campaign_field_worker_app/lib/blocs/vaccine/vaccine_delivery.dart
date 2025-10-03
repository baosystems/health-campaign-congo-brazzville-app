import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/task.dart';

import '../../models/entities/vaccine/vaccine_delivery_details.dart';

part 'vaccine_delivery.freezed.dart';

typedef VaccineDeliveryEmitter = Emitter<VaccineDeliveryState>;

class VaccineDeliveryBloc
    extends Bloc<VaccineDeliveryEvent, VaccineDeliveryState> {
  final DataRepository<TaskModel, TaskSearchModel> taskRepository;

  VaccineDeliveryBloc(
    super.initialState, {
    required this.taskRepository,
  }) {
    on(_handleSubmit);
    on(_handleVaccineSelection);
  }

  // Event handler for submitting a task
  FutureOr<void> _handleSubmit(
    VaccineDeliverySubmitEvent event,
    VaccineDeliveryEmitter emit,
  ) async {
    // Update loading state to indicate an operation is in progress
    emit(state.copyWith(loading: true));
    try {
      TaskModel updatedTask = event.task.copyWith(
        clientAuditDetails: (event.task.clientAuditDetails?.createdBy != null &&
                event.task.clientAuditDetails?.createdTime != null)
            ? ClientAuditDetails(
                createdBy: event.task.clientAuditDetails!.createdBy,
                createdTime: event.task.clientAuditDetails!.createdTime,
                lastModifiedBy: event.task.auditDetails?.lastModifiedBy ??
                    event.task.clientAuditDetails!.createdBy,
                lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
              )
            : null,
      );
      await taskRepository.update(updatedTask);
      if (event.currentDoseTask != null) {
        await taskRepository.update(event.currentDoseTask!);
      }
      emit(state.copyWith(loading: false));
    } catch (error) {
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  FutureOr<void> _handleVaccineSelection(
    VaccineDeliveryVaccineSelectionEvent event,
    VaccineDeliveryEmitter emit,
  ) {
    List<String> eligibleVaccinesCode =
        _getEligibleVaccineDoseCodes(event.eligibleVaccinesCodeByAgeIndex);

    List<String> deliverableVaccineCodes = eligibleVaccinesCode
        .whereNot((e) => event.availedVaccineDoseCodes.contains(e))
        .toList();

    List<VaccineDeliveryDetails> currentVaccineDoseData =
        deliverableVaccineCodes.where((vaccineCode) {
      return _isVaccineAllowed(
        vaccineCode: vaccineCode,
        availedVaccineCodes: event.availedVaccineDoseCodes,
        allVaccineCodes: eligibleVaccinesCode,
      );
    }).map((vaccineCode) {
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

    List<String> nextVaccineDoseData = deliverableVaccineCodes.whereNot((e) {
      for (VaccineDeliveryDetails element in currentVaccineDoseData) {
        if (element.vaccineCode == e) {
          return true;
        }
      }
      return false;
    }).toList();

    emit(state.copyWith(
      loading: false,
      availedVaccineDoseCodes: event.availedVaccineDoseCodes,
      currentVaccineDoseData: currentVaccineDoseData,
      nextVaccineDoseData: nextVaccineDoseData,
    ));
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
    required Set<String> filterVaccineDoseCodes,
  }) = VaccineDeliveryVaccineSelectionEvent;
}

@freezed
class VaccineDeliveryState with _$VaccineDeliveryState {
  const factory VaccineDeliveryState({
    @Default(false) bool loading,
    List<String>? availedVaccineDoseCodes,
    List<VaccineDeliveryDetails>? currentVaccineDoseData,
    List<String>? nextVaccineDoseData,
  }) = _VaccineDeliveryState;
}
