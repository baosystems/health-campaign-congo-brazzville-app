import 'dart:async';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/constants.dart';

import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/entities/additional_fields_type.dart';

part 'vaccine_search.freezed.dart';

typedef VaccineSearchEmitter = Emitter<VaccineSearchState>;

class VaccineSearchBloc extends Bloc<VaccineSearchEvent, VaccineSearchState> {
  final DataRepository<TaskModel, TaskSearchModel> taskRepository;

  VaccineSearchBloc(
    super.initialState, {
    required this.taskRepository,
  }) {
    on(_handleVaccineEligibility);
    on(_handleSearch);
  }

  FutureOr<void> _handleVaccineEligibility(
    VaccineSearchEligibleVaccinesEvent event,
    VaccineSearchEmitter emit,
  ) {
    List<VaccineData> vaccineData = event.vaccineDataList ?? [];
    // Logic to determine vaccine eligibility based on selected and no-selected codes
    final allVaccineCodes = [for (final v in vaccineData) v.code];
    final Map<String, String> vaccineCodeToName = {
      for (final v in vaccineData) v.code: v.name
    };
    final List<int> ageIndex =
        (vaccineData.map((e) => e.ageInDays).toSet().toList()..sort());
    final Map<int, List<String>> ageToVaccineCodes = {};
    for (final v in vaccineData) {
      ageToVaccineCodes.putIfAbsent(v.ageInDays, () => []);
      ageToVaccineCodes[v.ageInDays]!.add(v.code);
    }
    Map<int, Set<String>> vaccinesByAgeIndex = {};
    Map<int, Set<String>> eligibleVaccinesByAgeIndex = {};
    for (var age in ageIndex) {
      vaccinesByAgeIndex[age] = ageToVaccineCodes[age]?.toSet() ?? {};
      if (age < event.ageInDays) {
        eligibleVaccinesByAgeIndex[age] = ageToVaccineCodes[age]?.toSet() ?? {};
      }
    }
    emit(state.copyWith(
      loading: false,
      ageIndex: ageIndex,
      vaccinesByAgeIndex: vaccinesByAgeIndex,
      eligibleVaccinesByAgeIndex: eligibleVaccinesByAgeIndex,
      allVaccineCodes: allVaccineCodes,
    ));
  }

  // Event handler for submitting a task
  FutureOr<void> _handleSearch(
    VaccineSearchTaskEvent event,
    VaccineSearchEmitter emit,
  ) async {
    List<String> selectedCodes = [];
    List<String> noSelectedCodes = [];

    List<TaskModel> tasksData = await taskRepository.search(
      TaskSearchModel(
        projectBeneficiaryClientReferenceId:
            event.projectBeneficiaryClientReferenceId != null
                ? [event.projectBeneficiaryClientReferenceId!]
                : null,
      ),
    );

    List<TaskModel> lastVaccinationTask = tasksData.where(
      (task) {
        final fields = task.additionalFields?.fields;
        if (fields == null) return false;

        final hasZeroDoseStatus = fields.any(
          (e) => e.key == AdditionalFieldsType.doseStatus.toValue(),
        );
        final hasSelectedVaccines = fields.any(
          (e) => e.key == AdditionalFieldsType.selectedVaccines.toValue(),
        );
        final hasNoSelectedVaccines = fields.any(
          (e) => e.key == AdditionalFieldsType.noSelectedVaccines.toValue(),
        );
        return hasZeroDoseStatus &&
            (hasSelectedVaccines || hasNoSelectedVaccines);
      },
    ).toList();

    if (lastVaccinationTask.isNotEmpty) {
      lastVaccinationTask.sort((a, b) {
        final aCycle = a.additionalFields?.fields
            .firstWhereOrNull(
              (e) => e.key == AdditionalFieldsType.cycleIndex.toValue(),
            )
            ?.value;
        final bCycle = b.additionalFields?.fields
            .firstWhereOrNull(
              (e) => e.key == AdditionalFieldsType.cycleIndex.toValue(),
            )
            ?.value;

        if (aCycle == bCycle) {
          final aCreatedTime = a.auditDetails?.createdTime;
          final bCreatedTime = b.auditDetails?.createdTime;
          return (aCreatedTime != null && bCreatedTime != null)
              ? aCreatedTime.compareTo(bCreatedTime)
              : 0;
        }
        return (int.tryParse(aCycle ?? '0') ?? 0) -
            (int.tryParse(bCycle ?? '0') ?? 0);
      });

      List<String> yesSelectedVaccines = [];
      List<String> noSelectedVaccines = [];
      // ignore: avoid_dynamic_calls
      yesSelectedVaccines = ((lastVaccinationTask.last.additionalFields!.fields
                  .firstWhereOrNull((e) =>
                      e.key == AdditionalFieldsType.selectedVaccines.toValue())
                  ?.value as String?) ??
              '')
          .split('.')
          // ignore: avoid_dynamic_calls
          .where((e) => e.isNotEmpty)
          .toList();

      // ignore: avoid_dynamic_calls
      noSelectedVaccines = ((lastVaccinationTask.last.additionalFields!.fields
                  .firstWhereOrNull((e) =>
                      e.key ==
                      AdditionalFieldsType.noSelectedVaccines.toValue())
                  ?.value as String?) ??
              '')
          .split('.')
          // ignore: avoid_dynamic_calls
          .where((e) => e.isNotEmpty)
          .toList();

      selectedCodes = yesSelectedVaccines;
      noSelectedCodes = noSelectedVaccines;

      emit(state.copyWith(
          loading: false,
          task: lastVaccinationTask.last,
          selectedCodes: selectedCodes,
          noSelectedCodes: noSelectedCodes));
    }
  }

  // Search for tasks and process the results
}

@freezed
class VaccineSearchEvent with _$VaccineSearchEvent {
  const factory VaccineSearchEvent.eligibleVaccines({
    required int ageInDays,
    required List<VaccineData>? vaccineDataList,
  }) = VaccineSearchEligibleVaccinesEvent;
  const factory VaccineSearchEvent.handleSearch({
    required String projectBeneficiaryClientReferenceId,
  }) = VaccineSearchTaskEvent;
}

@freezed
class VaccineSearchState with _$VaccineSearchState {
  const factory VaccineSearchState({
    @Default(false) bool loading,
    TaskModel? task,
    List<int>? ageIndex,
    Map<int, Set<String>>? vaccinesByAgeIndex,
    Map<int, Set<String>>? eligibleVaccinesByAgeIndex,
    List<String>? allVaccineCodes,
    List<String>? selectedCodes,
    List<String>? noSelectedCodes,
  }) = _VaccineSearchState;
}
