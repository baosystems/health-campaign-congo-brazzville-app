import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
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

    final availedVaccineCodesMap = vaccineIdentificationTasks
            .first.additionalFields?.fields
            .firstWhereOrNull(
                (e) => e.key == AdditionalFieldsType.selectedVaccines.toValue())
            ?.value ??
        "";

    List<String> availedVaccineDoseCodes = json.decode(availedVaccineCodesMap);

    emit(state.copyWith(
      loading: false,
      vaccineDeliveryDoseTasks: vaccineDeliveryDoseTasks,
      availedVaccineDoseCodes: availedVaccineDoseCodes,
    ));
  }

  FutureOr<void> _handleVaccineEligibilitySearch(
    VaccineSearchEligibleVaccinesEvent event,
    VaccineSearchEmitter emit,
  ) {
    List<VaccineDoseData> vaccineData = event.vaccineDataList ?? [];

    final List<int> ageIndex =
        (vaccineData.map((e) => e.ageInDays).toSet().toList()..sort());
    final Map<int, List<String>> ageToVaccineCodes = {};
    for (final v in vaccineData) {
      ageToVaccineCodes.putIfAbsent(v.ageInDays, () => []);
      ageToVaccineCodes[v.ageInDays]!.add(v.doseCode);
    }
    Map<int, Set<String>> allVaccinesCodeByAgeIndex = {};
    Map<int, Set<String>> eligibleVaccinesCodeByAgeIndex = {};
    for (var age in ageIndex) {
      allVaccinesCodeByAgeIndex[age] = ageToVaccineCodes[age]?.toSet() ?? {};
      if (age < event.ageInMonths * 30) {
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

  Map<int, Set<String>> _getVaccineDoseListByIndex(
      Map<int, Set<String>> eligibleVaccinesByAgeIndex,
      List<VaccineDoseData> vaccineData) {
    Map<int, Set<String>> vaccineDoseList = {};
    final allEligibleVaccineDoseCodes = eligibleVaccinesByAgeIndex.values
        .fold<Set<String>>({}, (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    }).toList();
    Map<String, List<String>> allEligibleVaccineCodes = {};
    for (var doseCode in allEligibleVaccineDoseCodes) {
      String code = vaccineData
              .firstWhereOrNull((element) => element.doseCode == doseCode)
              ?.code ??
          '';
      allEligibleVaccineCodes.putIfAbsent(code, () => []);
      allEligibleVaccineCodes[code]!.add(doseCode);
    }
    int maxLength = 0;
    for (var codes in allEligibleVaccineCodes.values) {
      if (codes.length > maxLength) {
        maxLength = codes.length;
      }
    }
    for (var i = 0; i < maxLength; i++) {
      Set<String> currentDoseList = {};
      for (List<String> element in allEligibleVaccineCodes.values) {
        if (i < element.length) currentDoseList.add(element[i]);
      }
      vaccineDoseList[i + 1] = currentDoseList;
    }
    return vaccineDoseList;
  }
}

@freezed
class VaccineSearchEvent with _$VaccineSearchEvent {
  const factory VaccineSearchEvent.handleTaskSearch({
    required String projectBeneficiaryClientReferenceId,
  }) = VaccineTaskSearchEvent;
  const factory VaccineSearchEvent.eligibleVaccinesSearch(
          {required int ageInMonths,
          required List<VaccineDoseData> vaccineDataList,
          required Map<String, dynamic> vaccineDoseDataVariation}) =
      VaccineSearchEligibleVaccinesEvent;
}

@freezed
class VaccineSearchState with _$VaccineSearchState {
  const factory VaccineSearchState({
    @Default(false) bool loading,
    List<TaskModel>? vaccineDeliveryDoseTasks,
    List<String>? availedVaccineDoseCodes,
    List<String>? allEligibleVaccineDoseCodes,
    Map<int, Set<String>>? allVaccinesDoseCodeByAgeIndex,
    Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex,
  }) = _VaccineSearchState;
}
