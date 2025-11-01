import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_action_card.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:registration_delivery/blocs/app_localization.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../blocs/localization/app_localization.dart';
import '../../blocs/vaccine/vaccine_delivery.dart';
import '../../blocs/vaccine/vaccine_product_variants.dart';
import '../../blocs/vaccine/vaccine_search.dart';
import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/identifier_types.dart';
import 'package:registration_delivery/utils/utils.dart';
import '../../models/entities/vaccine/vaccine_dose_variant.dart';
import '../../pages/beneficiary/check_eligibility/check_eligibility_assessment.dart';
import '../../router/app_router.dart';
import '../../utils/app_enums.dart';
import '../../utils/environment_config.dart';
import '../../utils/registration_delivery/utils_smc.dart';
import '../../utils/utils.dart';
import '../action_card/action_card.dart';

import '../../utils/i18_key_constants.dart' as i18_local;
import '../../../models/entities/assessment_checklist/status.dart'
    as status_local;
import '../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import '../../utils/date_utils.dart' as digits;

class CustomMemberCard extends StatelessWidget {
  final List<ProductVariantModel> variant;
  final String name;
  final String? gender;
  final int? years;
  final int? months;
  final bool isHead;
  final IndividualModel individual;
  final List<ProjectBeneficiaryModel>? projectBeneficiaries;
  final bool isSMCDelivered;
  final bool isVASDelivered;

  final VoidCallback setAsHeadAction;
  final VoidCallback editMemberAction;
  final VoidCallback deleteMemberAction;
  final RegistrationDeliveryLocalization localizations;
  final List<TaskModel>? tasks;
  final List<SideEffectModel>? sideEffects;
  final bool isNotEligibleSMC;
  final bool isNotEligibleVAS;
  final bool isBeneficiaryRefused;
  final bool isBeneficiaryIneligible;
  final bool isBeneficiaryReferred;
  final String? projectBeneficiaryClientReferenceId;

  const CustomMemberCard({
    super.key,
    required this.individual,
    required this.projectBeneficiaries,
    required this.name,
    this.gender,
    required this.years,
    this.isHead = false,
    this.months = 0,
    required this.localizations,
    required this.isSMCDelivered,
    required this.isVASDelivered,
    required this.setAsHeadAction,
    required this.editMemberAction,
    required this.deleteMemberAction,
    this.tasks,
    this.isNotEligibleSMC = false,
    this.isNotEligibleVAS = false,
    this.projectBeneficiaryClientReferenceId,
    this.isBeneficiaryRefused = false,
    this.isBeneficiaryIneligible = false,
    this.isBeneficiaryReferred = false,
    this.sideEffects,
    required this.variant,
  });

  bool _checkIfFutureTaskPresent(BuildContext context) {
    List<TaskModel>? tasks = this.tasks;
    if (tasks == null || tasks.isEmpty) {
      return false;
    }

    List<TaskModel> futureTasks = tasks
        .where((task) => task.status == Status.delivered.toValue())
        .toList();

    if (futureTasks.isEmpty) {
      return false;
    }

    int currentDose = 0;
    String? timeStamp;

    for (var task in futureTasks) {
      int tempCurrentDose = int.parse(task.additionalFields?.fields
              .firstWhereOrNull(
                  (e) => e.key == AdditionalFieldsType.doseIndex.toValue())
              ?.value ??
          "0");
      String? tempTimeStamp = task.additionalFields?.fields
          .firstWhereOrNull(
              (e) => e.key == AdditionalFieldsType.nextDateOfDelivery.toValue())
          ?.value;
      if (tempCurrentDose > currentDose) {
        currentDose = tempCurrentDose;
        timeStamp = tempTimeStamp;
      }
    }

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

  List<TaskModel>? _getCurrentCycleData(BuildContext context) {
    List<TaskModel>? tasks = this
        .tasks
        ?.where((e) =>
            e.additionalFields?.fields
                .where((field) =>
                    field.key == AdditionalFieldsType.cycleIndex.toValue() &&
                    int.tryParse(field.value) == context.selectedCycle?.id)
                .isNotEmpty ??
            false)
        .toList();
    return tasks;
  }

  List<TaskModel>? _getSMCStatusData(BuildContext context) {
    List<TaskModel>? tasks = _getCurrentCycleData(context);
    return tasks
        ?.where((e) =>
            e.additionalFields?.fields.firstWhereOrNull(
              (element) =>
                  element.key ==
                      additional_fields_local.AdditionalFieldsType.deliveryType
                          .toValue() &&
                  element.value == EligibilityAssessmentStatus.smcDone.name,
            ) !=
            null)
        .toList();
  }

  List<TaskModel>? _getDoseStatusData(BuildContext context) {
    List<TaskModel>? tasks = _getCurrentCycleData(context);
    return tasks
        ?.where((e) =>
            e.additionalFields?.fields.firstWhereOrNull(
              (element) =>
                  element.key ==
                      additional_fields_local.AdditionalFieldsType.doseStatus
                          .toValue() &&
                  (element.value == DoseStatus.zeroDose.name ||
                      element.value == DoseStatus.underVaccinated.name ||
                      element.value == DoseStatus.fullyVaccinated.name ||
                      element.value == DoseStatus.vaccinated.name),
            ) !=
            null)
        .toList();
  }

  List<TaskModel>? _getVACStatusData() {
    return tasks
        ?.where((e) =>
            e.additionalFields?.fields.firstWhereOrNull(
              (element) =>
                  element.key ==
                      additional_fields_local.AdditionalFieldsType.deliveryType
                          .toValue() &&
                  element.value == EligibilityAssessmentStatus.vasDone.name,
            ) !=
            null)
        .toList();
  }

  Widget statusWidget(BuildContext context) {
    List<TaskModel>? smcTasks = _getSMCStatusData(context);

    bool isBeneficiaryReferred = checkBeneficiaryReferred(smcTasks);
    bool isBeneficiaryInEligible =
        checkBeneficiaryInEligibleSMC(smcTasks, context.selectedCycle);
    List<TaskModel>? currentTasks = _getCurrentCycleData(context);
    bool isBeneficiaryAbsent = checkBeneficiaryAbsentSMC(currentTasks);
    bool isBeneficiaryRefuse = checkBeneficiaryRefusedSMC(currentTasks);
    bool isSideEffect = sideEffects != null && sideEffects!.isNotEmpty;

    List<TaskModel>? doseTasks = _getDoseStatusData(context);
    bool isZeroDose = checkBeneficiaryZeroDose(doseTasks);
    bool isUnderVaccinated = checkBeneficiaryUnderVaccinated(doseTasks);
    bool isFullyVaccinated = checkBeneficiaryFullyVaccinated(doseTasks);
    bool isVaccinated = checkBeneficiaryVaccineDoseDelivered(doseTasks);

    final dobStr = individual.dateOfBirth;
    final ageInDays =
        digits.DigitDateUtils.calculateAgeInDaysFromDob(dobStr ?? '');
    Gender? gender = individual.gender;

    bool isHPVEligible =
        gender == Gender.female && ageInDays >= 3240 && ageInDays < 3600;

    bool isAgeInEligible = ageInDays > (18 * Constants.yearsInDays);

    final theme = Theme.of(context);
    if (isHead) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.info_rounded,
          iconSize: 20,
          iconText: localizations.translate(i18_local
              .householdOverView.householdOverViewHouseholderHeadLabel),
          iconTextColor: theme.colorScheme.error,
          iconColor: theme.colorScheme.error,
        ),
      );
    }
    if (isAgeInEligible) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.check_circle,
          iconSize: 20,
          iconText: localizations.translate(
              i18.householdOverView.householdOverViewNotEligibleIconLabel),
          iconTextColor: theme.colorScheme.error,
          iconColor: theme.colorScheme.error,
        ),
      );
    }
    if (isBeneficiaryRefuse ||
        isBeneficiaryAbsent ||
        isSideEffect ||
        isBeneficiaryReferred) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.check_circle,
          iconText: localizations.translate(
            isBeneficiaryReferred
                ? i18.householdOverView.householdOverViewNotEligibleIconLabel
                : isBeneficiaryRefuse
                    ? i18_local.householdOverView
                        .householdOverViewBeneficiaryRefusedLabel
                    : isSideEffect
                        ? i18_local.householdOverView
                            .householdOverViewBeneficiarySideEffectLabel
                        : isBeneficiaryAbsent
                            ? i18_local.householdOverView
                                .householdOverViewBeneficiaryAbsentLabel
                            : i18_local.householdOverView
                                .householdOverViewBeneficiaryInEligibleSMCLabel,
          ),
          iconSize: 20,
          iconTextColor: theme.colorScheme.error,
          iconColor: theme.colorScheme.error,
        ),
      );
    }
    if (isZeroDose || isUnderVaccinated || isFullyVaccinated || isVaccinated) {
      return Align(
        alignment: Alignment.centerLeft,
        child: DigitIconButton(
          icon: Icons.check_circle,
          iconText: localizations.translate(
            isZeroDose
                ? i18_local.householdOverView.householdOverViewZeroDoseIconLabel
                : isUnderVaccinated
                    ? i18_local
                        .householdOverView.householdOverViewUnderVaccinatedLabel
                    : isFullyVaccinated
                        ? i18_local.householdOverView
                            .householdOverViewFullyVaccinatedLabel
                        : i18_local
                            .householdOverView.householdOverViewVaccinatedLabel,
          ),
          iconSize: 20,
          iconTextColor: theme.colorScheme.onSurfaceVariant,
          iconColor: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

    return const Offstage();
  }

  Widget actionButton(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final dobStr = individual.dateOfBirth;
    final ageInDays =
        digits.DigitDateUtils.calculateAgeInDaysFromDob(dobStr ?? '');
    Gender? gender = individual.gender;

    List<TaskModel>? smcTasks = _getSMCStatusData(context);

    bool isBeneficiaryReferred = checkBeneficiaryReferred(smcTasks);
    bool isBeneficiaryInEligibleSMC =
        checkBeneficiaryInEligibleSMC(smcTasks, context.selectedCycle);

    List<TaskModel>? currentTasks = _getCurrentCycleData(context);
    bool isBeneficiaryRefuse = checkBeneficiaryRefusedSMC(currentTasks);
    bool isBeneficiaryAbsent = checkBeneficiaryAbsentSMC(currentTasks);
    bool isSideEffect = sideEffects != null && sideEffects!.isNotEmpty;

    List<TaskModel>? doseTasks = _getDoseStatusData(context);
    bool isZeroDose = checkBeneficiaryZeroDose(doseTasks);
    bool isUnderVaccinated = checkBeneficiaryUnderVaccinated(doseTasks);
    bool isFullyVaccinated = checkBeneficiaryFullyVaccinated(doseTasks);
    bool isVaccinated = checkBeneficiaryVaccineDoseDelivered(doseTasks);

    bool isNextDeliveryAvailable = _checkIfFutureTaskPresent(context);

    bool isHPVEligible = gender == Gender.female &&
        ageInDays >= (9 * Constants.yearsInDays) &&
        ageInDays < (10 * Constants.yearsInDays);

    bool isAgeInEligible = ageInDays > (18 * Constants.yearsInDays);

    initializeVaccineSearch(
        BuildContext context, List<VaccineDoseData>? vaccineDataList) {
      context.read<VaccineSearchBloc>().add(
            VaccineSearchEvent.handleTaskSearch(
              projectBeneficiaryClientReferenceId:
                  projectBeneficiaryClientReferenceId!,
            ),
          );
      context
          .read<VaccineSearchBloc>()
          .add(VaccineSearchEvent.eligibleVaccinesSearch(
            ageInDays: ageInDays,
            vaccineDataList: vaccineDataList ?? [],
          ));
      context
          .read<VaccineDeliveryBloc>()
          .add(const VaccineDeliveryEvent.clearAdditionalVaccineDose());
      if (isHPVEligible) {
        context
            .read<VaccineDeliveryBloc>()
            .add(const VaccineDeliveryEvent.additionalVaccineDose(
              filterVaccineDoseCodes: null,
              additionalVaccineDoseCodes: {Constants.hpvVaccine},
            ));
      }
    }

    return isAgeInEligible || isBeneficiaryReferred
        ? const Offstage()
        : BlocBuilder<VaccineProductVariantBloc, VaccineProductVariantState>(
            builder: (context, vaccineVariantState) {
              return Column(
                children: [
                  if (doseTasks == null || doseTasks.isEmpty)
                    DigitElevatedButton(
                      child: Center(
                        child: Text(
                          localizations.translate(
                            i18_local.householdOverView
                                .householdOverViewZeroDoseActionText,
                          ),
                          style:
                              textTheme.headingM.copyWith(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        initializeVaccineSearch(
                            context, vaccineVariantState.vaccineDataList);
                        final bloc = context.read<HouseholdOverviewBloc>();
                        bloc.add(
                          HouseholdOverviewEvent.selectedIndividual(
                            individualModel: individual,
                          ),
                        );

                        context.router.push(
                          ZeroDoseCheckRoute(
                            eligibilityAssessmentType:
                                EligibilityAssessmentType.smc,
                            isAdministration: false,
                            isChecklistAssessmentDone: false,
                            projectBeneficiaryClientReferenceId:
                                projectBeneficiaryClientReferenceId,
                            individual: individual,
                          ),
                        );
                        // }
                      },
                    ),
                  if (doseTasks != null && doseTasks.isNotEmpty)
                    Builder(builder: (context) {
                      if (!context.isHealthFacilitySupervisor) {
                        return DigitElevatedButton(
                          child: Center(
                            child: Text(
                              localizations.translate(
                                i18_local.householdOverView
                                    .householdOverViewVaccinationStatusActionText,
                              ),
                              style: textTheme.headingM
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () async {
                            initializeVaccineSearch(
                                context, vaccineVariantState.vaccineDataList);
                            context.router.push(ViewVaccinationStatusRoute());
                          },
                        );
                      } else if (isZeroDose ||
                          isUnderVaccinated ||
                          isFullyVaccinated ||
                          isVaccinated ||
                          isNextDeliveryAvailable) {
                        return Column(
                          children: [
                            DigitElevatedButton(
                              child: Center(
                                child: Text(
                                  localizations.translate(
                                    i18_local.householdOverView
                                        .householdOverViewVaccinationStatusActionText,
                                  ),
                                  style: textTheme.headingM
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                initializeVaccineSearch(context,
                                    vaccineVariantState.vaccineDataList);
                                context.router
                                    .push(ViewVaccinationStatusRoute());
                              },
                            ),
                            if (isZeroDose ||
                                isUnderVaccinated ||
                                isNextDeliveryAvailable)
                              DigitElevatedButton(
                                child: Center(
                                  child: Text(
                                    localizations.translate(
                                      i18_local.householdOverView
                                          .householdOverViewChildVaccineActionText,
                                    ),
                                    style: textTheme.headingM
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  initializeVaccineSearch(context,
                                      vaccineVariantState.vaccineDataList);
                                  context.router
                                      .push(EligibilityChecklistViewRoute(
                                    eligibilityAssessmentType:
                                        EligibilityAssessmentType.vaccine,
                                    projectBeneficiaryClientReferenceId:
                                        projectBeneficiaryClientReferenceId,
                                    individual: individual,
                                    doseStatusTask: doseTasks.firstOrNull,
                                  ));
                                },
                              ),
                          ],
                        );
                      } else {
                        return const Offstage();
                      }
                    }),
                  if (context.isHealthFacilitySupervisor &&
                      !isVaccinated &&
                      !isFullyVaccinated &&
                      !isBeneficiaryRefused &&
                      !isBeneficiaryAbsent &&
                      !isSideEffect)
                    DigitButton(
                      label: localizations.translate(
                        i18.memberCard.unableToDeliverLabel,
                      ),
                      isDisabled:
                          (projectBeneficiaries ?? []).isEmpty ? true : false,
                      type: DigitButtonType.secondary,
                      size: DigitButtonSize.large,
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () async {
                        unableToDeliverPopUp(context);
                      },
                    ),
                ],
              );
            },
          );
  }

  unableToDeliverPopUp(BuildContext context) async {
    final bloc = context.read<HouseholdOverviewBloc>();
    bloc.add(
      HouseholdOverviewEvent.selectedIndividual(
        individualModel: individual,
      ),
    );
    await showDialog(
      context: context,
      builder: (ctx) => DigitActionCard(
        onOutsideTap: () {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pop();
        },
        actions: [
          DigitButton(
            label: localizations.translate(
              i18.memberCard.beneficiaryRefusedLabel,
            ),
            type: DigitButtonType.secondary,
            size: DigitButtonSize.large,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();

              final clientReferenceId = IdGen.i.identifier;

              List<TaskModel>? currentTasks = _getCurrentCycleData(context);
              bool isBeneficiaryRefuse =
                  checkBeneficiaryRefusedSMC(currentTasks);

              final refuseTask = TaskModel(
                projectBeneficiaryClientReferenceId:
                    projectBeneficiaryClientReferenceId,
                clientReferenceId: clientReferenceId,
                tenantId: RegistrationDeliverySingleton().tenantId,
                rowVersion: 1,
                auditDetails: AuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                projectId: RegistrationDeliverySingleton().projectId,
                status: Status.beneficiaryRefused.toValue(),
                clientAuditDetails: ClientAuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                  lastModifiedBy:
                      RegistrationDeliverySingleton().loggedInUserUuid,
                  lastModifiedTime: context.millisecondsSinceEpoch(),
                ),
                additionalFields: TaskAdditionalFields(
                  version: 1,
                  fields: [
                    AdditionalField(
                      AdditionalFieldsType.cycleIndex.toValue(),
                      "0${context.selectedCycle?.id}",
                    ),
                    AdditionalField(
                      'taskStatus',
                      Status.beneficiaryRefused.toValue(),
                    ),
                    AdditionalField(
                      AdditionalFieldsType.doseStatus.toValue(),
                      DoseStatus.zeroDose.name,
                    ),
                    ...getIndividualAdditionalFields(individual),
                  ],
                ),
                address: individual.address?.first.copyWith(
                  relatedClientReferenceId: clientReferenceId,
                  id: null,
                ),
              );

              context
                  .read<DeliverInterventionBloc>()
                  .add(DeliverInterventionSubmitEvent(
                    task: refuseTask,
                    isEditing: false,
                    boundaryModel: context.boundary,
                    navigateToSummary: false,
                    householdMemberWrapper: context
                        .read<HouseholdOverviewBloc>()
                        .state
                        .householdMemberWrapper,
                  ));
              final searchBloc = context.read<SearchHouseholdsBloc>();
              final reloadState = context.read<HouseholdOverviewBloc>();
              Future.delayed(const Duration(milliseconds: 500), () {
                reloadState.add(
                  HouseholdOverviewReloadEvent(
                    projectId: RegistrationDeliverySingleton().projectId!,
                    projectBeneficiaryType:
                        RegistrationDeliverySingleton().beneficiaryType!,
                  ),
                );
              }).then((_) => context.router.push(
                    CustomSplashAcknowledgementRoute(
                      eligibilityAssessmentType: EligibilityAssessmentType.smc,
                      enableBackToSearch: true,
                      task: refuseTask,
                    ),
                  ));
            },
          ),
          DigitButton(
            label: localizations.translate(
              i18_local.memberCard.beneficiaryAbsentButtonLabel,
            ),
            type: DigitButtonType.secondary,
            size: DigitButtonSize.large,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();

              final clientReferenceId = IdGen.i.identifier;

              final absentTask = TaskModel(
                projectBeneficiaryClientReferenceId:
                    projectBeneficiaryClientReferenceId,
                clientReferenceId: clientReferenceId,
                tenantId: RegistrationDeliverySingleton().tenantId,
                rowVersion: 1,
                auditDetails: AuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                projectId: RegistrationDeliverySingleton().projectId,
                status: status_local.Status.beneficiaryAbsent.toValue(),
                clientAuditDetails: ClientAuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                  lastModifiedBy:
                      RegistrationDeliverySingleton().loggedInUserUuid,
                  lastModifiedTime: context.millisecondsSinceEpoch(),
                ),
                additionalFields: TaskAdditionalFields(
                  version: 1,
                  fields: [
                    AdditionalField(
                      AdditionalFieldsType.cycleIndex.toValue(),
                      "0${context.selectedCycle?.id}",
                    ),
                    AdditionalField(
                      AdditionalFieldsType.taskStatus.toValue(),
                      Constants.beneficiaryAbsent,
                    ),
                    AdditionalField(
                      AdditionalFieldsType.doseStatus.toValue(),
                      DoseStatus.zeroDose.name,
                    ),
                    ...getIndividualAdditionalFields(individual),
                  ],
                ),
                address: individual.address?.first.copyWith(
                  relatedClientReferenceId: clientReferenceId,
                  id: null,
                ),
              );

              context
                  .read<DeliverInterventionBloc>()
                  .add(DeliverInterventionSubmitEvent(
                    task: absentTask,
                    isEditing: false,
                    boundaryModel: context.boundary,
                    navigateToSummary: false,
                    householdMemberWrapper: context
                        .read<HouseholdOverviewBloc>()
                        .state
                        .householdMemberWrapper,
                  ));
              final searchBloc = context.read<SearchHouseholdsBloc>();
              final reloadState = context.read<HouseholdOverviewBloc>();
              Future.delayed(const Duration(milliseconds: 500), () {
                reloadState.add(
                  HouseholdOverviewReloadEvent(
                    projectId: RegistrationDeliverySingleton().projectId!,
                    projectBeneficiaryType:
                        RegistrationDeliverySingleton().beneficiaryType!,
                  ),
                );
              }).then((_) => context.router.push(
                    CustomSplashAcknowledgementRoute(
                      eligibilityAssessmentType: EligibilityAssessmentType.smc,
                      enableBackToSearch: true,
                      task: absentTask,
                    ),
                  ));
            },
          ),
          DigitButton(
            label: localizations.translate(
              i18.memberCard.recordAdverseEventsLabel,
            ),
            isDisabled:
                tasks != null && (tasks ?? []).isNotEmpty ? false : true,
            type: DigitButtonType.secondary,
            size: DigitButtonSize.large,
            mainAxisSize: MainAxisSize.max,
            onPressed: () async {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop();
              await context.router.push(
                CustomSideEffectsRoute(
                  tasks: tasks!,
                  projectBeneficiaryClientReferenceId:
                      projectBeneficiaryClientReferenceId ?? '',
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final beneficiaryType = context.beneficiaryType;

    return Container(
      decoration: BoxDecoration(
        color: DigitTheme.instance.colorScheme.background,
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: DigitTheme.instance.containerMargin,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  individual.identifiers != null
                      ? Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: DigitTheme.instance.colorScheme.primary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(kPadding),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                kPadding,
                              ),
                              child: Text(
                                (individual.identifiers != null &&
                                        individual.identifiers!.isNotEmpty)
                                    ? (individual.identifiers!
                                            .lastWhereOrNull(
                                              (e) =>
                                                  e.identifierType ==
                                                  IdentifierTypes
                                                      .uniqueBeneficiaryID
                                                      .toValue(),
                                            )
                                            ?.identifierId ??
                                        localizations.translate(
                                            i18.common.noResultsFound))
                                    : localizations
                                        .translate(i18.common.noResultsFound),
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: kPadding,
                            top: kPadding,
                          ),
                          child: Text(
                            name,
                            style: theme.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ((tasks == null || tasks!.isEmpty) &&
                      !isSMCDelivered &&
                      !isVASDelivered &&
                      // !isNotEligibleSMC &&
                      // !isNotEligibleVAS &&
                      !isBeneficiaryIneligible &&
                      !isBeneficiaryReferred)
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: DigitIconButton(
                          onPressed: () => DigitActionDialog.show(
                            context,
                            widget: ActionCard(
                              items: [
                                ActionCardModel(
                                  icon: Icons.edit,
                                  label: localizations.translate(
                                    i18.memberCard.editIndividualDetails,
                                  ),
                                  action: editMemberAction,
                                ),
                              ],
                            ),
                          ),
                          iconText: localizations.translate(
                            i18.memberCard.editDetails,
                          ),
                          icon: Icons.edit,
                        ),
                      ),
                    )
                  : const Offstage(),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: DigitTheme.instance.containerMargin,
                  child: Text(
                    gender != null
                        ? localizations
                            .translate('CORE_COMMON_${gender?.toUpperCase()}')
                        : ' - ',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    " | $years ${localizations.translate(i18.memberCard.deliverDetailsYearText)} $months ${localizations.translate(i18.memberCard.deliverDetailsMonthsText)}",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kPadding / 2,
            ),
            child: Offstage(
              offstage: beneficiaryType != BeneficiaryType.individual,
              child: statusWidget(context),
            ),
          ),
          Offstage(
            offstage: beneficiaryType != BeneficiaryType.individual,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: isHead
                  ? const Column(
                      children: [],
                    )
                  : Column(
                      children: [
                        actionButton(context),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDigitElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const CustomDigitElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kPadding,
        bottom: kPadding,
      ),
      constraints: const BoxConstraints(maxHeight: 60, minHeight: 50),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DigitTheme.instance.colors.woodsmokeBlack,
            width: 2,
          ),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: onPressed,
        child: Center(child: child),
      ),
    );
  }
}
