import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:digit_components/widgets/atoms/digit_reactive_search_dropdown.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';

import 'package:digit_components/widgets/digit_elevated_button.dart';
import 'package:digit_components/widgets/scrollable_content.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/utils/component_utils.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/atoms/labelled_fields.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/atoms/reactive_fields.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
// import 'package:digit_ui_components/widgets/scrollable_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/models/entities/deliver_strategy_type.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/models/entities/task_resource.dart';
import 'package:registration_delivery/utils/utils.dart';

import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/vaccine/vaccine_delivery.dart';
import '../../blocs/vaccine/vaccine_product_variants.dart';
import '../../blocs/vaccine/vaccine_search.dart';
import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/assessment_checklist/status.dart';
import '../../models/entities/identifier_types.dart';
import '../../models/entities/vaccine/vaccine_delivery_details.dart';
import '../../router/app_router.dart';
import '../../utils/app_enums.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_back_navigation.dart';
import '../../widgets/localized.dart';
import '../../widgets/showcase/showcase_wrappers.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;
import 'check_eligibility/view_vaccination_status.dart';

@RoutePage()
class VaccineDeliveryPage extends LocalizedStatefulWidget {
  final bool isHPVEligible;
  final Set<String> notApplicableVaccines;
  final TaskModel? doseStatusTask;
  final String? projectBeneficiaryClientReferenceId;
  final IndividualModel? individual;

  const VaccineDeliveryPage({
    super.key,
    required this.isHPVEligible,
    required this.notApplicableVaccines,
    required this.doseStatusTask,
    required this.projectBeneficiaryClientReferenceId,
    required this.individual,
  });

  @override
  State<VaccineDeliveryPage> createState() => _VaccineDeliveryPageState();
}

class _VaccineDeliveryPageState extends LocalizedState<VaccineDeliveryPage> {
  static const _currentMonthKey = 'currentMonth';
  static const _dateOfVaccinationKey = 'dateOfVaccination';
  static const _doseAdministeredByKey = 'doseAdministeredBy';
  static const _deliveryCommentKey = 'deliveryComment';

  // Map<String, VaccineDeliveryDetails> vaccineDeliveryDetails = {};

  List<String> allEligibleVaccineDoseCodes = [];
  Set<String> availedVaccineDoseCodes = {};

  List<VaccineDeliveryDetails> currentVaccineDoseData = [];
  Set<VaccineDeliveryDetails> currentVaccineDoseDataSelected = {};

  List<String> nextVaccineDoseCodes = [];

  FormGroup _form(BuildContext context) {
    DateTime now = DateTime.now();

    return fb.group({
      _currentMonthKey: FormControl<String>(
        value: DateFormat("MMMM").format(now),
      ),
      _dateOfVaccinationKey: FormControl<String>(
        value: DateFormat("dd MMMM yyyy").format(now),
      ),
      _doseAdministeredByKey: FormControl<String>(
        value: context.loggedInUser.name ?? "",
      ),
      _deliveryCommentKey: FormControl<String>(
        validators: [Validators.required],
      ),
    });
  }

  TaskModel _getTaskModel(
    BuildContext context, {
    required FormGroup form,
    required TaskModel? oldTask,
    required int? cycle,
    required int? dose,
    required String? projectBeneficiaryClientReferenceId,
    required AddressModel? address,
    required double? latitude,
    required double? longitude,
    required IndividualModel? selectedIndividual,
    required List<String> updatedAvailedVaccineDoseCodes,
    required List<String> notDeliveredVaccineDoseCodes,
  }) {
    // Assumption here productVariantDelivered will always have one item

    // Initialize task with oldTask if available, or create a new one
    var task = oldTask;
    var clientReferenceId = task?.clientReferenceId ?? IdGen.i.identifier;
    task ??= TaskModel(
      projectBeneficiaryClientReferenceId: projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      address: oldTask?.address?.copyWith(
        relatedClientReferenceId: clientReferenceId,
      ),
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    final currentMonth = form.control(_currentMonthKey).value as String?;
    final dateOfVaccination =
        form.control(_dateOfVaccinationKey).value as String?;
    final doseAdministeredBy =
        form.control(_doseAdministeredByKey).value as String?;
    final deliveryComment = form.control(_deliveryCommentKey).value as String?;

    Set<String> filterAdditionalFieldsKeys = {
      AdditionalFieldsType.doseStatus.toValue(),
      AdditionalFieldsType.selectedVaccines.toValue(),
      AdditionalFieldsType.noSelectedVaccines.toValue(),
      AdditionalFieldsType.cycleIndex.toValue(),
      AdditionalFieldsType.doseIndex.toValue(),
      AdditionalFieldsType.deliveryStrategy.toValue(),
      AdditionalFieldsType.latitude.toValue(),
      AdditionalFieldsType.longitude.toValue(),
      AdditionalFieldsType.currentMonth.toValue(),
      AdditionalFieldsType.dateOfVaccination.toValue(),
      AdditionalFieldsType.doseAdministeredBy.toValue(),
      AdditionalFieldsType.deliveryComment.toValue(),
    };

    final oldAdditionalFields = task.additionalFields;
    List<AdditionalField> filteredAdditionalFields = oldAdditionalFields?.fields
            .whereNot((e) => (filterAdditionalFieldsKeys.contains(e.key)))
            .toList() ??
        [];

    // Update the task with information from the form and other context
    task = task.copyWith(
      projectId: RegistrationDeliverySingleton().projectId,
      address: address?.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
      status: Status.administeredSuccess.toValue(),
      additionalFields: TaskAdditionalFields(
        version: task.additionalFields?.version ?? 1,
        fields: [
          ...filteredAdditionalFields,
          AdditionalField(
            AdditionalFieldsType.doseStatus.toValue(),
            DoseStatus.fullyVaccinated.name,
          ),
          if (updatedAvailedVaccineDoseCodes.isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.selectedVaccines.toValue(),
              updatedAvailedVaccineDoseCodes.join("."),
            ),
          if (notDeliveredVaccineDoseCodes.isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.noSelectedVaccines.toValue(),
              notDeliveredVaccineDoseCodes.join("."),
            ),
          AdditionalField(
            AdditionalFieldsType.cycleIndex.toValue(),
            "0${cycle ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.doseIndex.toValue(),
            "0${dose ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.deliveryStrategy.toValue(),
            DeliverStrategyType.direct.toValue(),
          ),
          if (latitude != null)
            AdditionalField(
              AdditionalFieldsType.latitude.toValue(),
              latitude,
            ),
          if (longitude != null)
            AdditionalField(
              AdditionalFieldsType.longitude.toValue(),
              longitude,
            ),
          if (currentMonth != null)
            AdditionalField(
              AdditionalFieldsType.currentMonth.toValue(),
              currentMonth,
            ),
          if (dateOfVaccination != null)
            AdditionalField(
              AdditionalFieldsType.dateOfVaccination.toValue(),
              dateOfVaccination,
            ),
          if (doseAdministeredBy != null)
            AdditionalField(
              AdditionalFieldsType.doseAdministeredBy.toValue(),
              doseAdministeredBy,
            ),
          if (deliveryComment != null &&
              deliveryComment.trim().toString().isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.deliveryComment.toValue(),
              deliveryComment,
            ),
        ],
      ),
    );

    return task;
  }

  TaskModel _getCurrentDoseTaskModel(
    BuildContext context, {
    required FormGroup form,
    required int? cycle,
    required int? dose,
    required String? projectBeneficiaryClientReferenceId,
    required AddressModel? address,
    required double? latitude,
    required double? longitude,
    required IndividualModel? selectedIndividual,
    required List<String> notDeliveredVaccineDoseCodes,
  }) {
    var clientReferenceId = IdGen.i.identifier;
    final currentMonth = form.control(_currentMonthKey).value as String?;
    final dateOfVaccination =
        form.control(_dateOfVaccinationKey).value as String?;
    final doseAdministeredBy =
        form.control(_doseAdministeredByKey).value as String?;
    final deliveryComment = form.control(_deliveryCommentKey).value as String?;

    DateTime? nextDateOfDelivery = notDeliveredVaccineDoseCodes.isEmpty
        ? null
        : DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 5);
    TaskModel task = TaskModel(
      projectBeneficiaryClientReferenceId: projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      address: address?.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
      ),
      projectId: RegistrationDeliverySingleton().projectId,
      resources: currentVaccineDoseDataSelected
          .map((e) => TaskResourceModel(
                taskclientReferenceId: clientReferenceId,
                clientReferenceId: IdGen.i.identifier,
                productVariantId: e.productVariationId,
                isDelivered: true,
                tenantId: RegistrationDeliverySingleton().tenantId,
                rowVersion: 1,
                quantity: e.numberOfDose.toString(),
                clientAuditDetails: ClientAuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                auditDetails: AuditDetails(
                  createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
              ))
          .toList(),
      status: Status.delivered.toValue(),
      additionalFields: TaskAdditionalFields(
        version: 1,
        fields: [
          AdditionalField(
            AdditionalFieldsType.dateOfDelivery.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          if (nextDateOfDelivery != null)
            AdditionalField(
              AdditionalFieldsType.nextDateOfDelivery.toValue(),
              nextDateOfDelivery.millisecondsSinceEpoch.toString(),
            ),
          AdditionalField(
            AdditionalFieldsType.doseStatus.toValue(),
            DoseStatus.fullyVaccinated.name,
          ),
          AdditionalField(
            AdditionalFieldsType.cycleIndex.toValue(),
            "0${cycle ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.doseIndex.toValue(),
            "0${dose ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.deliveryStrategy.toValue(),
            DeliverStrategyType.direct.toValue(),
          ),
          if (latitude != null)
            AdditionalField(
              AdditionalFieldsType.latitude.toValue(),
              latitude,
            ),
          if (longitude != null)
            AdditionalField(
              AdditionalFieldsType.longitude.toValue(),
              longitude,
            ),
          if (currentMonth != null)
            AdditionalField(
              AdditionalFieldsType.currentMonth.toValue(),
              currentMonth,
            ),
          if (dateOfVaccination != null)
            AdditionalField(
              AdditionalFieldsType.dateOfVaccination.toValue(),
              dateOfVaccination,
            ),
          if (doseAdministeredBy != null)
            AdditionalField(
              AdditionalFieldsType.doseAdministeredBy.toValue(),
              doseAdministeredBy,
            ),
          if (deliveryComment != null &&
              deliveryComment.trim().toString().isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.deliveryComment.toValue(),
              deliveryComment,
            ),
          if (selectedIndividual != null)
            AdditionalField(
              AdditionalFieldsType.age.toValue(),
              getIndividualAge(selectedIndividual),
            ),
          if (selectedIndividual?.gender != null)
            AdditionalField(
              AdditionalFieldsType.gender.toValue(),
              selectedIndividual?.gender,
            ),
          if (selectedIndividual?.clientReferenceId != null)
            AdditionalField(
              AdditionalFieldsType.individualClientReferenceId.toValue(),
              selectedIndividual?.clientReferenceId,
            ),
          if (selectedIndividual != null &&
              getBeneficiaryId(selectedIndividual) != null)
            AdditionalField(
              AdditionalFieldsType.uniqueBeneficiaryId.toValue(),
              getBeneficiaryId(selectedIndividual),
            ),
        ],
      ),
    );

    return task;
  }

  @override
  initState() {
    int ageInDays = 0;
    try {
      String? dateOfBirth = widget.individual?.dateOfBirth;
      ageInDays = calculateAgeInDaysFromDob(dateOfBirth ?? '');
    } catch (_) {}
    if (ageInDays > 180) {
      widget.notApplicableVaccines.add(Constants.rota1Vaccine);
      widget.notApplicableVaccines.add(Constants.rota2Vaccine);
    } else if (ageInDays > 360) {
      widget.notApplicableVaccines.add(Constants.bcgVaccine);
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        return BlocBuilder<VaccineProductVariantBloc,
            VaccineProductVariantState>(
          builder: (context, vaccineVariantState) {
            return BlocBuilder<VaccineSearchBloc, VaccineSearchState>(
              builder: (context, vaccineSearchState) {
                context
                    .read<VaccineDeliveryBloc>()
                    .add(VaccineDeliveryEvent.vaccineSelection(
                      productVariants:
                          vaccineVariantState.productVariants ?? [],
                      availedVaccineDoseCodes:
                          vaccineSearchState.availedVaccineDoseCodes ?? [],
                      filterVaccineDoseCodes: widget.notApplicableVaccines,
                      eligibleVaccinesCodeByAgeIndex: vaccineSearchState
                              .eligibleVaccinesDoseCodeByAgeIndex ??
                          {},
                      allVaccineDoseCodes:
                          vaccineSearchState.allEligibleVaccineDoseCodes ?? [],
                    ));
                allEligibleVaccineDoseCodes =
                    vaccineSearchState.allEligibleVaccineDoseCodes ?? [];
                return BlocBuilder<VaccineDeliveryBloc, VaccineDeliveryState>(
                  builder: (context, deliveryState) {
                    availedVaccineDoseCodes =
                        (deliveryState.availedVaccineDoseCodes ?? []).toSet();
                    currentVaccineDoseData =
                        deliveryState.currentVaccineDoseData ?? [];
                    nextVaccineDoseCodes =
                        deliveryState.nextVaccineDoseData ?? [];
                    return ReactiveFormBuilder(
                        form: () => _form(context),
                        builder: (context, form, child) {
                          return ScrollableContent(
                              header: const Column(children: [
                                CustomBackNavigationHelpHeaderWidget(
                                  showHelp: false,
                                ),
                              ]),
                              enableFixedButton: true,
                              footer: DigitCard(
                                margin: const EdgeInsets.fromLTRB(
                                    0, kPadding, 0, 0),
                                padding: const EdgeInsets.fromLTRB(
                                    kPadding, 0, kPadding, 0),
                                children: [
                                  DigitElevatedButton(
                                    onPressed: () async {
                                      if (form.invalid) {
                                        form.markAllAsTouched();
                                        await DigitToast.show(
                                          context,
                                          options: DigitToastOptions(
                                            localizations.translate(i18_local
                                                .deliverIntervention
                                                .selectDeliveryComment),
                                            true,
                                            theme,
                                          ),
                                        );
                                        return;
                                      }
                                      List<String>
                                          notDeliveredVaccineDoseCodes =
                                          allEligibleVaccineDoseCodes
                                              .whereNot((code) =>
                                                  availedVaccineDoseCodes
                                                      .contains(code))
                                              .toList();
                                      int currentDose =
                                          vaccineSearchState.currentDose ?? 0;
                                      final submit = await showCustomPopup(
                                        context: context,
                                        builder: (popupContext) => Popup(
                                          title: localizations.translate(
                                            i18_local
                                                .common.coreCommonDialogTitle,
                                          ),
                                          onOutsideTap: () {
                                            Navigator.of(popupContext)
                                                .pop(false);
                                          },
                                          description: localizations.translate(
                                            i18_local
                                                .common.coreCommonDialogContent,
                                          ),
                                          type: PopUpType.simple,
                                          actions: [
                                            DigitButton(
                                              label: localizations.translate(
                                                i18_local
                                                    .common.coreCommonSubmit,
                                              ),
                                              onPressed: () {
                                                Navigator.of(
                                                  popupContext,
                                                  rootNavigator: true,
                                                ).pop(true);
                                              },
                                              type: DigitButtonType.primary,
                                              size: DigitButtonSize.large,
                                            ),
                                            DigitButton(
                                              label: localizations.translate(
                                                i18_local
                                                    .common.coreCommonCancel,
                                              ),
                                              onPressed: () {
                                                Navigator.of(
                                                  popupContext,
                                                  rootNavigator: true,
                                                ).pop(false);
                                              },
                                              type: DigitButtonType.secondary,
                                              size: DigitButtonSize.large,
                                            ),
                                          ],
                                        ),
                                      ) as bool;

                                      if (submit == true) {
                                        handleLocationState(
                                          locationState,
                                          context,
                                          form,
                                          widget.individual,
                                          currentDose,
                                          availedVaccineDoseCodes.toList(),
                                          notDeliveredVaccineDoseCodes,
                                        );
                                      }
                                    },
                                    child: Text(localizations.translate(
                                        i18_local.common.coreCommonSubmit)),
                                  )
                                ],
                              ),
                              children: [
                                DigitCard(
                                  margin: const EdgeInsets.all(kPadding),
                                  padding: const EdgeInsets.all(kPadding),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        localizations.translate(
                                          i18_local.deliverIntervention
                                              .recordVaccinationDetails,
                                        ),
                                        style: theme.textTheme.displayMedium,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ReactiveWrapperField(
                                            formControlName: _currentMonthKey,
                                            builder: (field) {
                                              return InputField(
                                                type: InputType.text,
                                                readOnly: true,
                                                label: localizations.translate(
                                                  i18_local.deliverIntervention
                                                      .currentMonth,
                                                ),
                                                errorMessage: field.errorText,
                                                initialValue:
                                                    field.control.value,
                                                onChange: (val) {
                                                  field.control.value = val;
                                                },
                                              );
                                            }),
                                        ReactiveWrapperField(
                                            formControlName:
                                                _dateOfVaccinationKey,
                                            builder: (field) {
                                              return LabeledField(
                                                label: localizations.translate(
                                                  i18_local.deliverIntervention
                                                      .dateOfVaccination,
                                                ),
                                                child: DigitDateFormInput(
                                                  readOnly: true,
                                                  initialValue:
                                                      field.control.value,
                                                  onChange: (val) =>
                                                      field.control.value = val,
                                                  firstDate: DateTime.now(),
                                                  errorMessage: field.errorText,
                                                ),
                                              );
                                            }),
                                        ReactiveWrapperField(
                                            formControlName:
                                                _doseAdministeredByKey,
                                            builder: (field) {
                                              return InputField(
                                                type: InputType.text,
                                                readOnly: true,
                                                label: localizations.translate(
                                                  i18_local.deliverIntervention
                                                      .doseAdministeredBy,
                                                ),
                                                errorMessage: field.errorText,
                                                initialValue:
                                                    field.control.value,
                                                onChange: (val) {
                                                  field.control.value = val;
                                                },
                                              );
                                            }),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                                DigitCard(
                                  margin: const EdgeInsets.all(kPadding),
                                  padding: const EdgeInsets.all(kPadding),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        localizations.translate(
                                          i18_local.deliverIntervention
                                              .vaccineDetails,
                                        ),
                                        style: theme.textTheme.displayMedium,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        for (int i = 0;
                                            i < currentVaccineDoseData.length;
                                            i++)
                                          VaccineDetailsCard(
                                            vaccineDeliveryDetails:
                                                currentVaccineDoseData[i],
                                            onVaccineDetailsChanged:
                                                (vaccineDetails) {
                                              if (vaccineDetails.numberOfDose >
                                                  0) {
                                                currentVaccineDoseDataSelected
                                                    .add(vaccineDetails);
                                                availedVaccineDoseCodes.add(
                                                    vaccineDetails.vaccineCode);
                                              } else {
                                                currentVaccineDoseDataSelected
                                                    .remove(vaccineDetails);
                                                availedVaccineDoseCodes.remove(
                                                    vaccineDetails.vaccineCode);
                                              }
                                            },
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                DigitCard(
                                  margin: const EdgeInsets.all(kPadding),
                                  padding: const EdgeInsets.all(kPadding),
                                  children: [
                                    BlocBuilder<AppInitializationBloc,
                                        AppInitializationState>(
                                      builder: (context, state) {
                                        if (state is! AppInitialized) {
                                          return const Offstage();
                                        }
                                        final deliveryCommentOptions = state
                                                .appConfiguration
                                                .deliveryCommentOptions ??
                                            <DeliveryCommentOptions>[];
                                        return ReactiveWrapperField(
                                          formControlName: _deliveryCommentKey,
                                          builder: (field) {
                                            return LabeledField(
                                              label: localizations.translate(
                                                i18_local.deliverIntervention
                                                    .deliveryComment,
                                              ),
                                              isRequired: true,
                                              child:
                                                  DigitReactiveSearchDropdown<
                                                      String>(
                                                label: localizations.translate(
                                                  i18_local.common.noMatchFound,
                                                ),
                                                form: form,
                                                enabled: true,
                                                isRequired: false,
                                                menuItems:
                                                    deliveryCommentOptions
                                                        .map((e) {
                                                  return e.code;
                                                }).toList(),
                                                formControlName:
                                                    _deliveryCommentKey,
                                                valueMapper: (value) =>
                                                    localizations.translate(
                                                  value,
                                                ),
                                                emptyText: localizations
                                                    .translate(i18_local
                                                        .common.noMatchFound),
                                                validationMessage:
                                                    localizations.translate(
                                                  i18_local.common
                                                      .corecommonRequired,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ]);
                        });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  int getIndividualAge(IndividualModel individualModel) {
    DateTime dateOfBirth =
        DateFormat("dd/MM/yyyy").parse(individualModel.dateOfBirth ?? '');
    DigitDOBAge age = DigitDateUtils.calculateAge(dateOfBirth);
    return getAgeMonths(age);
  }

  String? getBeneficiaryId(IndividualModel individualModel) {
    IdentifierTypes.uniqueBeneficiaryID.toValue();
    return individualModel.identifiers
            ?.firstWhereOrNull((e) =>
                e.identifierType ==
                IdentifierTypes.uniqueBeneficiaryID.toValue())
            ?.identifierId ??
        '';
  }

  void handleLocationState(
    LocationState locationState,
    BuildContext context,
    FormGroup form,
    IndividualModel? selectedIndividual,
    int currentDose,
    List<String> updatedAvailedVaccineDoseCodes,
    List<String> notDeliveredVaccineDoseCodes,
  ) {
    if (context.mounted) {
      DigitComponentsUtils.showDialog(
        context,
        localizations.translate(i18_local.common.locationCapturing),
        DialogType.inProgress,
      );

      Future.delayed(const Duration(seconds: 0), () {
        // After delay, hide the initial dialog
        DigitComponentsUtils.hideDialog(context);
        handleCapturedLocationState(
          locationState,
          context,
          form,
          selectedIndividual,
          currentDose,
          updatedAvailedVaccineDoseCodes,
          notDeliveredVaccineDoseCodes,
        );
      });
    }
  }

  Future<void> handleCapturedLocationState(
    LocationState locationState,
    BuildContext context,
    FormGroup form,
    IndividualModel? selectedIndividual,
    int currentDose,
    List<String> updatedAvailedVaccineDoseCodes,
    List<String> notDeliveredVaccineDoseCodes,
  ) async {
    final lat = locationState.latitude;
    final long = locationState.longitude;

    TaskModel updatedTask = _getTaskModel(
      context,
      form: form,
      cycle: context.selectedCycle?.id,
      dose: currentDose + 1,
      address: widget.doseStatusTask?.address,
      oldTask: widget.doseStatusTask,
      projectBeneficiaryClientReferenceId:
          widget.projectBeneficiaryClientReferenceId,
      latitude: lat,
      longitude: long,
      selectedIndividual: selectedIndividual,
      updatedAvailedVaccineDoseCodes: updatedAvailedVaccineDoseCodes,
      notDeliveredVaccineDoseCodes: notDeliveredVaccineDoseCodes,
    );

    TaskModel currentDoseTask = _getCurrentDoseTaskModel(context,
        form: form,
        cycle: context.selectedCycle?.id,
        dose: currentDose + 1,
        address: updatedTask.address,
        projectBeneficiaryClientReferenceId:
            widget.projectBeneficiaryClientReferenceId,
        latitude: lat,
        longitude: long,
        selectedIndividual: selectedIndividual,
        notDeliveredVaccineDoseCodes: notDeliveredVaccineDoseCodes);

    context.read<VaccineDeliveryBloc>().add(
          VaccineDeliverySubmitEvent(
            task: updatedTask,
            currentDoseTask: currentDoseTask,
          ),
        );

    await handleSubmit(context, selectedIndividual);
  }

  Future<void> handleSubmit(
    BuildContext context,
    IndividualModel? individual,
  ) async {
    final reloadState = context.read<HouseholdOverviewBloc>();

    reloadState.add(
      HouseholdOverviewReloadEvent(
        projectId: RegistrationDeliverySingleton().projectId!,
        projectBeneficiaryType:
            RegistrationDeliverySingleton().beneficiaryType!,
      ),
    );
    context.router.popAndPush(
      CustomHouseholdAcknowledgementRoute(
        enableViewHousehold: true,
        eligibilityAssessmentType: EligibilityAssessmentType.vaccine,
      ),
    );
  }
}

class VaccineDetailsCard extends LocalizedStatefulWidget {
  final VaccineDeliveryDetails vaccineDeliveryDetails;
  final Function(VaccineDeliveryDetails) onVaccineDetailsChanged;
  const VaccineDetailsCard({
    super.key,
    required this.vaccineDeliveryDetails,
    required this.onVaccineDetailsChanged,
  });

  @override
  State<VaccineDetailsCard> createState() => _VaccineDetailsCardState();
}

class _VaccineDetailsCardState extends LocalizedState<VaccineDetailsCard> {
  static const _selectVaccineKey = 'selectVaccine';
  static const _enterBatchNumberKey = 'enterBatchNumber';
  static const _numberOfDoseKey = 'numberOfDose';

  late VaccineDeliveryDetails vaccineDeliveryDetails;

  FormGroup _form() {
    return fb.group({
      _selectVaccineKey: FormControl<String>(
        value:
            localizations.translate(widget.vaccineDeliveryDetails.vaccineCode),
        validators: [
          Validators.required,
        ],
      ),
      _enterBatchNumberKey: FormControl<String>(),
      _numberOfDoseKey: FormControl<int>(
        value: 0,
        validators: [Validators.required],
      ),
    });
  }

  @override
  void initState() {
    vaccineDeliveryDetails = widget.vaccineDeliveryDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DigitCard(
      margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
      children: [
        ReactiveFormBuilder(
            form: () => _form(),
            builder: (context, form, child) {
              return Column(
                children: [
                  ReactiveWrapperField(
                      formControlName: _selectVaccineKey,
                      builder: (field) {
                        return InputField(
                          type: InputType.text,
                          isDisabled: true,
                          isRequired: true,
                          label: localizations.translate(
                            i18_local.deliverIntervention.selectVaccine,
                          ),
                          errorMessage: field.errorText,
                          initialValue: field.control.value,
                          onChange: (val) {
                            field.control.value = val;
                          },
                        );
                      }),
                  ReactiveWrapperField(
                      formControlName: _enterBatchNumberKey,
                      builder: (field) {
                        return InputField(
                          type: InputType.text,
                          label: localizations.translate(
                            i18_local.deliverIntervention.enterBatchNumber,
                          ),
                          errorMessage: field.errorText,
                          onChange: (val) {
                            field.control.value = val;
                            vaccineDeliveryDetails.batchNumber = val;
                            widget.onVaccineDetailsChanged(
                                vaccineDeliveryDetails);
                          },
                        );
                      }),
                  ReactiveWrapperField(
                    formControlName: _numberOfDoseKey,
                    builder: (field) => LabeledField(
                      isRequired: true,
                      label: localizations.translate(
                        i18_local.deliverIntervention.numberOfDose,
                      ),
                      child: DigitNumericFormInput(
                        step: 1,
                        initialValue: "0",
                        onChange: (value) {
                          field.control.value = int.parse(value);
                          vaccineDeliveryDetails.numberOfDose =
                              int.parse(value);
                          widget
                              .onVaccineDetailsChanged(vaccineDeliveryDetails);
                        },
                      ),
                    ),
                  ),
                ],
              );
            })
      ],
    );
  }
}
