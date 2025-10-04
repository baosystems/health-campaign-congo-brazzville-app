import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:digit_data_model/data/local_store/sql_store/tables/package_tables/task.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/constants.dart';

import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/assessment_checklist/status.dart';

part 'vaccine_search.freezed.dart';

typedef VaccineSearchEmitter = Emitter<VaccineSearchState>;

class VaccineSearchBloc extends Bloc<VaccineSearchEvent, VaccineSearchState> {
  final DataRepository<TaskModel, TaskSearchModel> taskRepository;

  VaccineSearchBloc(
    super.initialState, {
    required this.taskRepository,
  }) {
    on(_handleTaskSearch);
    on(_handleVaccineEligibilitySearch);
  }

  FutureOr<void> _handleTaskSearch(
    VaccineTaskSearchEvent event,
    VaccineSearchEmitter emit,
  ) async {
    List<TaskModel> tasksData = await taskRepository.search(
      TaskSearchModel(projectBeneficiaryClientReferenceId: [
        event.projectBeneficiaryClientReferenceId
      ]),
    );

    List<TaskModel> vaccineIdentificationTasks = tasksData.where(
      (task) {
        String? status = task.status;
        final fields = task.additionalFields?.fields;
        if (fields == null) return false;

        final hasDoseStatus = fields.any(
          (e) => e.key == AdditionalFieldsType.doseStatus.toValue(),
        );
        return (status == Status.beneficiaryInEligible.toValue()) &&
            hasDoseStatus;
      },
    ).toList();

    List<TaskModel> vaccineDeliveryDoseTasks = tasksData.where(
      (task) {
        String? status = task.status;
        final fields = task.additionalFields?.fields;
        if (fields == null) return false;

        final hasDoseStatus = fields.any(
          (e) => e.key == AdditionalFieldsType.doseStatus.toValue(),
        );
        return (status == Status.administeredSuccess.toValue()) &&
            hasDoseStatus;
      },
    ).toList();

    List<TaskModel> vaccineFutureDeliveryDoseTasks = tasksData
        .where((task) => task.status == Status.delivered.toValue())
        .toList();

    int currentDose = 0;

    for (var task in vaccineFutureDeliveryDoseTasks) {
      int tempCurrentDose = int.parse(task.additionalFields?.fields
              .firstWhereOrNull(
                  (e) => e.key == AdditionalFieldsType.doseIndex.toValue())
              ?.value ??
          "0");
      if (tempCurrentDose > currentDose) {
        currentDose = tempCurrentDose;
      }
    }

    bool isNextDeliveryAvailable = await _checkIfFutureTaskPresent(
        currentDose, vaccineFutureDeliveryDoseTasks);

    String availedVaccineCodesMap = vaccineIdentificationTasks
            .first.additionalFields?.fields
            .firstWhereOrNull(
                (e) => e.key == AdditionalFieldsType.selectedVaccines.toValue())
            ?.value ??
        "";

    List<String> availedVaccineDoseCodes = availedVaccineCodesMap.split(".");

    emit(state.copyWith(
      loading: false,
      vaccineDeliveryDoseTasks: vaccineDeliveryDoseTasks,
      availedVaccineDoseCodes: availedVaccineDoseCodes,
      vaccineFutureDeliveryDoseTasks: vaccineFutureDeliveryDoseTasks,
      isNextDeliveryAvailable: isNextDeliveryAvailable,
      currentDose: currentDose,
    ));
  }

  FutureOr<void> _handleVaccineEligibilitySearch(
    VaccineSearchEligibleVaccinesEvent event,
    VaccineSearchEmitter emit,
  ) {
    List<VaccineDoseData> vaccineDataList = event.vaccineDataList ?? [];

    final List<int> ageIndex =
        (vaccineDataList.map((e) => e.ageInDays).toSet().toList()..sort());
    final Map<int, List<String>> ageToVaccineCodes = {};
    for (final v in vaccineDataList) {
      ageToVaccineCodes.putIfAbsent(v.ageInDays, () => []);
      ageToVaccineCodes[v.ageInDays]!.add(v.doseCode);
    }
    Map<int, Set<String>> allVaccinesCodeByAgeIndex = {};
    Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex = {};
    for (var age in ageIndex) {
      allVaccinesCodeByAgeIndex[age] = ageToVaccineCodes[age]?.toSet() ?? {};
      if (age < event.ageInDays) {
        eligibleVaccinesCodeByAgeIndex[age] =
            ageToVaccineCodes[age]?.toSet() ?? {};
      }
    }

    List<String> allEligibleVaccineDoseCodes = eligibleVaccinesCodeByAgeIndex
        .values
        .fold<Set<String>>({}, (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    }).toList();

    emit(state.copyWith(
      loading: false,
      allEligibleVaccineDoseCodes: allEligibleVaccineDoseCodes,
      allVaccinesDoseCodeByAgeIndex: allVaccinesCodeByAgeIndex,
      eligibleVaccinesDoseCodeByAgeIndex: eligibleVaccinesCodeByAgeIndex,
    ));
  }

  Future<bool> _checkIfFutureTaskPresent(
      int currentDose, List<TaskModel> futureTasks) async {
    if (futureTasks.isEmpty) {
      return false;
    }

    List<TaskModel> filteredFutureTasks = futureTasks.where((task) {
      int taskDoseIndex = int.parse(task.additionalFields?.fields
              .firstWhereOrNull(
                  (e) => e.key == AdditionalFieldsType.doseIndex.toValue())
              ?.value ??
          "0");
      return taskDoseIndex == currentDose;
    }).toList();

    String? timeStamp = filteredFutureTasks.first.additionalFields?.fields
        .firstWhereOrNull(
            (e) => e.key == AdditionalFieldsType.nextDateOfDelivery.toValue())
        ?.value;
    if (timeStamp == null) {
      return false;
    }

    DateTime nextDeliveryDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));

    if (nextDeliveryDate.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }
}

@freezed
class VaccineSearchEvent with _$VaccineSearchEvent {
  const factory VaccineSearchEvent.handleTaskSearch({
    required String projectBeneficiaryClientReferenceId,
  }) = VaccineTaskSearchEvent;
  const factory VaccineSearchEvent.eligibleVaccinesSearch(
          {required int ageInDays,
          required List<VaccineDoseData> vaccineDataList,
          required Map<String, dynamic> vaccineDoseDataVariation}) =
      VaccineSearchEligibleVaccinesEvent;
}

@freezed
class VaccineSearchState with _$VaccineSearchState {
  const factory VaccineSearchState({
    @Default(false) bool loading,
    List<TaskModel>? vaccineDeliveryDoseTasks,
    List<TaskModel>? vaccineFutureDeliveryDoseTasks,
    @Default(false) bool isNextDeliveryAvailable,
    @Default(0) int currentDose,
    List<String>? availedVaccineDoseCodes,
    List<String>? allEligibleVaccineDoseCodes,
    Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
    Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex,
  }) = _VaccineSearchState;
}
