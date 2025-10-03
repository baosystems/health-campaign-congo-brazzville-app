import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/utils/date_utils.dart';
// import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/services/location_bloc.dart' as location;
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/spacers.dart';
// import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/atoms/reactive_fields.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:group_radio_button/group_radio_button.dart';
// import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:survey_form/survey_form.dart';

import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../blocs/vaccine/vaccine_product_variants.dart';
import '../../../blocs/vaccine/vaccine_search.dart';
import '../../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import '../../../models/entities/additional_fields_type.dart';
import '../../../models/entities/assessment_checklist/status.dart'
    as status_local;
// import '../../../blocs/service/service.dart' as service;
import '../../../models/entities/roles_type.dart';
import '../../../models/entities/status.dart';
import '../../../router/app_router.dart';
import '../../../utils/app_enums.dart';
import '../../../utils/environment_config.dart';
import '../../../utils/i18_key_constants.dart' as i18_local;
import '../../../utils/upper_case.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_back_navigation.dart';
import '../../../utils/date_utils.dart' as date_utils_local;
// import '../../../widgets/showcase/showcase_wrappers.dart';

@RoutePage()
class ZeroDoseCheckPage extends LocalizedStatefulWidget {
  final EligibilityAssessmentType eligibilityAssessmentType;
  final bool isEditing;
  final bool isAdministration;
  final bool isChecklistAssessmentDone;
  final String? projectBeneficiaryClientReferenceId;
  final IndividualModel? individual;
  final TaskModel task;
  final bool? hasSideEffects;
  final SideEffectModel sideEffect;
  final bool isRefused;

  ZeroDoseCheckPage({
    super.key,
    super.appLocalizations,
    required this.eligibilityAssessmentType,
    required this.isAdministration,
    this.isEditing = false,
    this.isChecklistAssessmentDone = true,
    this.projectBeneficiaryClientReferenceId,
    this.individual,
    this.hasSideEffects = false,
    this.isRefused = false,
    SideEffectModel? sideEffect,
    TaskModel? task,
  })  : task = task ?? TaskModel(clientReferenceId: ''),
        sideEffect = sideEffect ?? SideEffectModel(clientReferenceId: '');

  @override
  State<ZeroDoseCheckPage> createState() => ZeroDoseCheckPageState();
}

class ZeroDoseCheckPageState extends LocalizedState<ZeroDoseCheckPage> {
  // Constants for form control keys
  static const _doseAdministrationKey = 'doseAdministered';
  static const _dateOfAdministrationKey = 'dateOfAdministration';
  final clickedStatus = ValueNotifier<bool>(false);
  bool? shouldSubmit = false;

  var submitTriggered = false;
  List<TextEditingController> controller = [];
  List<AttributesModel>? initialAttributes;
  ServiceDefinitionModel? selectedServiceDefinition;
  bool isControllersInitialized = false;
  List<int> visibleChecklistIndexes = [];
  GlobalKey<FormState> checklistFormKey = GlobalKey<FormState>();
  Map<String?, String> responses = {};
  final String yes = "YES";
  final String no = "NO";
  List<String> allVaccineCodes = [];
  List<String?> ineligibilityReasons = [];

  // List of controllers for form elements
  final List _controllers = [];

  @override
  void initState() {
    context
        .read<location.LocationBloc>()
        .add(const location.LocationEvent.load());
    context.read<ServiceBloc>().add(ServiceSurveyFormEvent(
          value: Random().nextInt(100).toString(),
          submitTriggered: true,
        ));
    super.initState();
    // context.read<LocationBloc>().add(const LoadLocationEvent());
    // super.initState();
  }

  bool _shouldShowVaccinePage(
    Map<String?, String> responses,
  ) {
    var showVaccinePage = false;
    var q1Key = "ZDAQ1";

    if (responses.isNotEmpty) {
      if (!showVaccinePage &&
          (responses.containsKey(q1Key) && responses[q1Key]!.isNotEmpty)) {
        showVaccinePage = responses[q1Key] == yes ? true : false;
      }
    }

    return showVaccinePage;
  }

  TaskModel _getTaskModel(double? latitude, double? longitude) {
    final clientReferenceId = IdGen.i.identifier;
    List<String> availedVaccines = [];
    return TaskModel(
      projectBeneficiaryClientReferenceId:
          widget.projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      tenantId: envConfig.variables.tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      projectId: context.projectId,
      status: status_local.Status.beneficiaryInEligible.toValue(),
      clientAuditDetails: ClientAuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: context.loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
      additionalFields: TaskAdditionalFields(
        version: 1,
        fields: [
          AdditionalField(
            AdditionalFieldsType.cycleIndex.toValue(),
            "0${context.selectedCycle?.id}",
          ),
          if (availedVaccines.isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.selectedVaccines.toValue(),
              json.encode(availedVaccines),
            ),
          if (ineligibilityReasons.isNotEmpty)
            AdditionalField(
              AdditionalFieldsType.ineligibleReasons.toValue(),
              ineligibilityReasons.join(","),
            ),
          AdditionalField(
            additional_fields_local.AdditionalFieldsType.deliveryType.toValue(),
            EligibilityAssessmentStatus.smcDone.name,
          ),
          AdditionalField(
              additional_fields_local.AdditionalFieldsType.doseStatus.toValue(),
              DoseStatus.zeroDose.name),
          ...getIndividualAdditionalFields(widget.individual)
        ],
      ),
      address: widget.individual?.address?.first.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final relatedClientRefId = context
        .read<HouseholdOverviewBloc>()
        .state
        .selectedIndividual
        ?.clientReferenceId;

    final dobStr = context
        .read<HouseholdOverviewBloc>()
        .state
        .selectedIndividual
        ?.dateOfBirth;
    final ageInDays =
        date_utils_local.DigitDateUtils.calculateAgeInDaysFromDob(dobStr ?? '');

    if (ageInDays < 180) {
      ineligibilityReasons.add(Constants.ineligibleForRota);
    }
    if (ageInDays < 360) {
      ineligibilityReasons.add(Constants.ineligibleForRota);
    }

    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await _onBackPressed(context);
        if (shouldPop && widget.isRefused) {
          context.router
              .popUntilRouteWithName(CustomHouseholdOverviewRoute.name);
        }
        return shouldPop;
      },
      child: Scaffold(
        body: BlocBuilder<location.LocationBloc, location.LocationState>(
          builder: (context, locationState) {
            return BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
              builder: (context, householdOverviewState) {
                double? latitude = locationState.latitude;
                double? longitude = locationState.longitude;
                return BlocBuilder<ServiceDefinitionBloc,
                    ServiceDefinitionState>(
                  builder: (context, state) {
                    state.mapOrNull(
                      serviceDefinitionFetch: (value) {
                        selectedServiceDefinition = value.serviceDefinitionList
                            .where(
                                (element) => element.code.toString().contains(
                                      '${context.selectedProject.name}.${Constants.zeroDoseAssessment}.${RolesType.communityDistributor.toValue()}',
                                    ))
                            .toList()
                            .firstOrNull;
                        initialAttributes =
                            selectedServiceDefinition?.attributes;
                        if (!isControllersInitialized) {
                          initialAttributes?.forEach((e) {
                            controller.add(TextEditingController());
                          });

                          isControllersInitialized = true;
                        }
                      },
                    );

                    return state.maybeMap(
                      orElse: () => Text(state.runtimeType.toString()),
                      serviceDefinitionFetch: (value) {
                        return ScrollableContent(
                          header: Column(
                            children: [
                              if (!(context.isHealthFacilitySupervisor))
                                const CustomBackNavigationHelpHeaderWidget(
                                  showHelp: false,
                                ),
                            ],
                          ),
                          enableFixedButton: true,
                          footer: DigitCard(
                            margin:
                                const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
                            padding: const EdgeInsets.fromLTRB(
                                kPadding, 0, kPadding, 0),
                            child: DigitElevatedButton(
                              onPressed: () async {
                                submitTriggered = true;
                                final isValid =
                                    checklistFormKey.currentState?.validate();
                                if (!isValid!) {
                                  return;
                                }

                                for (int i = 0; i < controller.length; i++) {
                                  var attributeCode =
                                      '${initialAttributes?[i].code}';
                                  var value = initialAttributes?[i].dataType !=
                                          'SingleValueList'
                                      ? controller[i]
                                              .text
                                              .toString()
                                              .trim()
                                              .isNotEmpty
                                          ? controller[i].text.toString()
                                          : (initialAttributes?[i].dataType !=
                                                  'Number'
                                              ? ''
                                              : '0')
                                      : visibleChecklistIndexes.contains(i)
                                          ? controller[i].text.toString()
                                          : i18_local.checklist.notSelectedKey;
                                  responses[attributeCode] = value;
                                }

                                bool showVaccineSelectionPage =
                                    _shouldShowVaccinePage(responses);

                                final projectBeneficiaryClientReferenceId =
                                    widget.projectBeneficiaryClientReferenceId ??
                                        relatedClientRefId ??
                                        '';

                                final shouldSubmit = await DigitDialog.show(
                                  context,
                                  options: DigitDialogOptions(
                                    titleText: localizations.translate(
                                      i18.deliverIntervention.dialogTitle,
                                    ),
                                    content: Text(localizations
                                        .translate(
                                          i18.deliverIntervention.dialogContent,
                                        )
                                        .replaceFirst('{}', '')),
                                    primaryAction: DigitDialogActions(
                                      label: localizations.translate(
                                        i18_local.checklist
                                            .checklistDialogPrimaryAction,
                                      ),
                                      action: (ctx) {
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(true);
                                      },
                                    ),
                                    secondaryAction: DigitDialogActions(
                                      label: localizations.translate(
                                        i18_local.checklist
                                            .checklistDialogSecondaryAction,
                                      ),
                                      action: (context) {
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(false);
                                      },
                                    ),
                                  ),
                                );
                                if (shouldSubmit ?? false) {
                                  if (context.mounted) {
                                    if (showVaccineSelectionPage) {
                                      context.router.push(VaccineSelectionRoute(
                                        isAdministration:
                                            widget.isAdministration,
                                        eligibilityAssessmentType:
                                            widget.eligibilityAssessmentType,
                                        isChecklistAssessmentDone:
                                            widget.isChecklistAssessmentDone,
                                        projectBeneficiaryClientReferenceId:
                                            projectBeneficiaryClientReferenceId,
                                        individual: widget.individual,
                                        task: widget.task,
                                        hasSideEffects: widget.hasSideEffects!,
                                        sideEffect: widget.sideEffect!,
                                      ));
                                    } else {
                                      context
                                          .read<DeliverInterventionBloc>()
                                          .add(
                                            DeliverInterventionSubmitEvent(
                                              task: _getTaskModel(
                                                  latitude, longitude),
                                              isEditing: false,
                                              boundaryModel: context.boundary,
                                              navigateToSummary: false,
                                              householdMemberWrapper: context
                                                  .read<HouseholdOverviewBloc>()
                                                  .state
                                                  .householdMemberWrapper,
                                            ),
                                          );
                                      final searchBloc =
                                          context.read<SearchHouseholdsBloc>();
                                      searchBloc.add(
                                        const SearchHouseholdsClearEvent(),
                                      );
                                      final router = context.router;
                                      router.popUntilRouteWithName(
                                          BeneficiaryWrapperRoute.name);

                                      router.push(
                                        CustomHouseholdAcknowledgementRoute(
                                            enableViewHousehold: true,
                                            eligibilityAssessmentType: widget
                                                .eligibilityAssessmentType),
                                      );
                                    }
                                  }
                                  submitTriggered = true;
                                  context.read<ServiceBloc>().add(
                                        const ServiceSurveyFormEvent(
                                          value: '',
                                          submitTriggered: true,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                localizations.translate(
                                    i18_local.common.coreCommonSubmit),
                              ),
                            ),
                          ),
                          children: [
                            DigitCard(
                              margin: const EdgeInsets.all(spacer2),
                              child: Column(
                                children: [
                                  ReactiveFormBuilder(
                                    form: () => buildForm(context),
                                    builder: (context, form, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              localizations.translate(
                                                i18_local.deliverIntervention
                                                    .zeroDoseCheckLabel,
                                              ),
                                              style: theme
                                                  .textTheme.displayMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                ReactiveWrapperField(
                                                  formControlName:
                                                      _dateOfAdministrationKey,
                                                  builder: (field) =>
                                                      LabeledField(
                                                    label: localizations
                                                        .translate(i18_local
                                                            .householdDetails
                                                            .dateOfAdministrationLabel),
                                                    child: DigitDateFormInput(
                                                      readOnly: true,
                                                      initialValue: DateFormat(
                                                              'dd MMM yyyy')
                                                          .format(form
                                                              .control(
                                                                  _dateOfAdministrationKey)
                                                              .value)
                                                          .toString(),
                                                      confirmText: localizations
                                                          .translate(i18.common
                                                              .coreCommonOk),
                                                      cancelText: localizations
                                                          .translate(i18.common
                                                              .coreCommonCancel),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Form(
                                    key: checklistFormKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...initialAttributes!.map((e) {
                                          int index = (initialAttributes ?? [])
                                              .indexOf(e);

                                          return Column(children: [
                                            if (e.dataType == 'String' &&
                                                !(e.code ?? '')
                                                    .contains('.')) ...[
                                              DigitTextField(
                                                autoValidation: AutovalidateMode
                                                    .onUserInteraction,
                                                isRequired: true,
                                                controller: controller[index],
                                                validator: (value) {
                                                  if (((value == null ||
                                                          value == '') &&
                                                      e.required == true)) {
                                                    return localizations
                                                        .translate(
                                                      i18_local.common
                                                          .corecommonRequired,
                                                    );
                                                  }
                                                  if (e.regex != null) {
                                                    return (RegExp(e.regex!)
                                                            .hasMatch(value!))
                                                        ? null
                                                        : localizations.translate(
                                                            "${e.code}_REGEX");
                                                  }

                                                  return null;
                                                },
                                                label: localizations.translate(
                                                  '${selectedServiceDefinition?.code}.${e.code}',
                                                ),
                                              ),
                                            ] else if (e.dataType == 'Number' &&
                                                !(e.code ?? '')
                                                    .contains('.')) ...[
                                              DigitTextField(
                                                autoValidation: AutovalidateMode
                                                    .onUserInteraction,
                                                textStyle: theme
                                                    .textTheme.headlineMedium,
                                                textInputType:
                                                    TextInputType.number,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      "[0-9]",
                                                    ),
                                                  ),
                                                ],
                                                validator: (value) {
                                                  if (((value == null ||
                                                          value == '') &&
                                                      e.required == true)) {
                                                    return localizations
                                                        .translate(
                                                      i18_local.common
                                                          .corecommonRequired,
                                                    );
                                                  }
                                                  if (e.regex != null) {
                                                    return (RegExp(e.regex!)
                                                            .hasMatch(value!))
                                                        ? null
                                                        : localizations.translate(
                                                            "${e.code}_REGEX");
                                                  }

                                                  return null;
                                                },
                                                controller: controller[index],
                                                label: '${localizations.translate(
                                                      '${selectedServiceDefinition?.code}.${e.code}',
                                                    ).trim()} ${e.required == true ? '*' : ''}',
                                              ),
                                            ] else if (e.dataType ==
                                                    'MultiValueList' &&
                                                !(e.code ?? '')
                                                    .contains('.')) ...[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${localizations.translate(
                                                          '${selectedServiceDefinition?.code}.${e.code}',
                                                        )} ${e.required == true ? '*' : ''}',
                                                        style: theme.textTheme
                                                            .headlineSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<ServiceBloc,
                                                  ServiceState>(
                                                builder: (context, state) {
                                                  return Column(
                                                    children: e.values!
                                                        .map((e) =>
                                                            DigitCheckboxTile(
                                                              label: e,
                                                              value: controller[
                                                                      index]
                                                                  .text
                                                                  .split('.')
                                                                  .contains(e),
                                                              onChanged:
                                                                  (value) {
                                                                final String
                                                                    ele;
                                                                var val =
                                                                    controller[
                                                                            index]
                                                                        .text
                                                                        .split(
                                                                            '.');
                                                                if (val
                                                                    .contains(
                                                                        e)) {
                                                                  val.remove(e);
                                                                  ele =
                                                                      val.join(
                                                                          ".");
                                                                } else {
                                                                  ele =
                                                                      "${controller[index].text}.$e";
                                                                }
                                                                controller[index]
                                                                        .value =
                                                                    TextEditingController
                                                                        .fromValue(
                                                                  TextEditingValue(
                                                                    text: ele,
                                                                  ),
                                                                ).value;
                                                              },
                                                            ))
                                                        .toList(),
                                                  );
                                                },
                                              ),
                                            ] else if (e.dataType ==
                                                'SingleValueList') ...[
                                              if (!(e.code ?? '').contains('.'))
                                                DigitCard(
                                                  // Replace with your desired widget
                                                  child: _buildChecklist(
                                                    e,
                                                    index,
                                                    selectedServiceDefinition,
                                                    context,
                                                  ),
                                                ),
                                            ],
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ignore: long-parameter-list

  // This method builds a form used for delivering interventions.
  FormGroup buildForm(BuildContext context) {
    final bloc = context.read<DeliverInterventionBloc>().state;
    final overViewbloc = context.read<HouseholdOverviewBloc>().state;
    _controllers.forEachIndexed((index, element) {
      _controllers.removeAt(index);
    });

    // if (_controllers.isEmpty) {
    //   _controllers.addAll(List.generate(r, (index) => index)
    //       .mapIndexed((index, element) => index));
    // }

    return fb.group(<String, Object>{
      _doseAdministrationKey: FormControl<String>(
        value:
            '${localizations.translate(i18.deliverIntervention.cycle)} ${bloc.cycle == 0 ? (bloc.cycle + 1) : bloc.cycle}'
                .toString(),
        validators: [],
      ),
      _dateOfAdministrationKey:
          FormControl<DateTime>(value: DateTime.now(), validators: []),
    });
  }

  String trKey(String key, {String? fallback}) {
    final v = localizations.translate(key);
    return (v.isEmpty || v == key) ? (fallback ?? key) : v;
  }

  Widget _buildChecklist(
    AttributesModel item,
    int index,
    ServiceDefinitionModel? selectedServiceDefinition,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    /* Check the data type of the attribute*/
    if (item.dataType == 'SingleValueList') {
      final childItems = getNextQuestions(
        item.code.toString(),
        initialAttributes ?? [],
      );
      List<int> excludedIndexes = [];

      // Ensure the current index is added to visible indexes and not excluded
      if (!visibleChecklistIndexes.contains(index) &&
          !excludedIndexes.contains(index)) {
        visibleChecklistIndexes.add(index);
      }

      // Determine excluded indexes
      for (int i = 0; i < (initialAttributes ?? []).length; i++) {
        if (!visibleChecklistIndexes.contains(i)) {
          excludedIndexes.add(i);
        }
      }

      final mdmsKey = '${selectedServiceDefinition?.code}.${item.code}';

      final displayLabel = trKey(
        mdmsKey,
        fallback:
            trKey(i18_local.checklist.zeroDoseBookOrEverVaccinatedQuestion),
      );

      return Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(4.0), // Add padding here
              child: Text(
                '${localizations.translate(
                  '$displayLabel ${item.required == true ? '' : ''}',
                )} ${item.required == true ? '*' : ''}',
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
          Column(
            children: [
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  return RadioGroup<String>.builder(
                    groupValue: controller[index].text.trim(),
                    onChanged: (value) {
                      setState(() {
                        for (final matchingChildItem in childItems) {
                          final childIndex =
                              initialAttributes?.indexOf(matchingChildItem);
                          if (childIndex != null) {
                            visibleChecklistIndexes
                                .removeWhere((v) => v == childIndex);
                          }
                        }

                        // Update the current controller's value
                        controller[index].value =
                            TextEditingController.fromValue(
                          TextEditingValue(
                            text: value!,
                          ),
                        ).value;

                        // Remove corresponding controllers based on the removed attributes
                      });
                    },
                    items: item.values != null
                        ? item.values!
                            .where(
                                (e) => e != i18_local.checklist.notSelectedKey)
                            .toList()
                        : [],
                    itemBuilder: (item) => RadioButtonBuilder(
                      localizations.translate(
                        'CORE_COMMON_${item.trim().toUpperCase()}',
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  final hasError = (item.required == true &&
                      controller[index].text.isEmpty &&
                      submitTriggered);

                  return Offstage(
                    offstage: !hasError,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localizations.translate(
                          i18_local.common.corecommonRequired,
                        ),
                        style: TextStyle(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          if (childItems.isNotEmpty &&
              controller[index].text.trim().isNotEmpty) ...[
            _buildNestedChecklists(
              item.code.toString(),
              index,
              controller[index].text.trim(),
              context,
            ),
          ],
        ],
      );
    } else if (item.dataType == 'String') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DigitTextField(
          onChange: (value) {
            checklistFormKey.currentState?.validate();
          },
          isRequired: item.required ?? true,
          controller: controller[index],
          validator: (value) {
            if (((value == null || value == '') && item.required == true)) {
              return localizations.translate("${item.code}_REQUIRED");
            }
            if (item.regex != null) {
              return (RegExp(item.regex!).hasMatch(value!))
                  ? null
                  : localizations.translate("${item.code}_REGEX");
            }

            return null;
          },
          label: localizations.translate(
            '${selectedServiceDefinition?.code}.${item.code}',
          ),
        ),
      );
    } else if (item.dataType == 'Number') {
      return DigitTextField(
        autoValidation: AutovalidateMode.onUserInteraction,
        textStyle: theme.textTheme.headlineMedium,
        textInputType: TextInputType.number,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(
            "[0-9]",
          )),
        ],
        validator: (value) {
          if (((value == null || value == '') && item.required == true)) {
            return localizations.translate(
              i18_local.common.corecommonRequired,
            );
          }
          if (item.regex != null) {
            return (RegExp(item.regex!).hasMatch(value!))
                ? null
                : localizations.translate("${item.code}_REGEX");
          }

          return null;
        },
        controller: controller[index],
        label: '${localizations.translate(
              '${selectedServiceDefinition?.code}.${item.code}',
            ).trim()} ${item.required == true ? '*' : ''}',
      );
    } else if (item.dataType == 'MultiValueList') {
      return Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    '${localizations.translate(
                      '${selectedServiceDefinition?.code}.${item.code}',
                    )} ${item.required == true ? '*' : ''}',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ServiceBloc, ServiceState>(
            builder: (context, state) {
              return Column(
                children: item.values!
                    .map((e) => DigitCheckboxTile(
                          label: e,
                          value: controller[index].text.split('.').contains(e),
                          onChanged: (value) {
                            final String ele;
                            var val = controller[index].text.split('.');
                            if (val.contains(e)) {
                              val.remove(e);
                              ele = val.join(".");
                            } else {
                              ele = "${controller[index].text}.$e";
                            }
                            controller[index].value =
                                TextEditingController.fromValue(
                              TextEditingValue(
                                text: ele,
                              ),
                            ).value;
                          },
                        ))
                    .toList(),
              );
            },
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // Function to build nested checklists for child attributes
  Widget _buildNestedChecklists(
    String parentCode,
    int parentIndex,
    String parentControllerValue,
    BuildContext context,
  ) {
    // Retrieve child items for the given parent code
    final childItems = getNextQuestions(
      parentCode,
      initialAttributes ?? [],
    );

    return Column(
      children: [
        // Build cards for each matching child attribute
        for (final matchingChildItem in childItems.where((childItem) =>
            childItem.code!.startsWith('$parentCode.$parentControllerValue.')))
          Card(
            margin: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
            color:
                // countDots(matchingChildItem.code ?? '') % 4 == 2
                //     ? const Color.fromRGBO(238, 238, 238, 1)
                //     :
                const DigitColors().white,
            child: _buildChecklist(
              matchingChildItem,
              initialAttributes?.indexOf(matchingChildItem) ??
                  parentIndex, // Pass parentIndex here as we're building at the same level
              selectedServiceDefinition,
              context,
            ),
          ),
      ],
    );
  }

  // Function to get the next questions (child attributes) based on a parent code
  List<AttributesModel> getNextQuestions(
    String parentCode,
    List<AttributesModel> checklistItems,
  ) {
    final childCodePrefix = '$parentCode.';
    final nextCheckLists = checklistItems.where((item) {
      return item.code!.startsWith(childCodePrefix) &&
          item.code?.split('.').length == parentCode.split('.').length + 2;
    }).toList();

    return nextCheckLists;
  }

  // int countDots(String inputString) {
  //   int dotCount = 0;
  //   for (int i = 0; i < inputString.length; i++) {
  //     if (inputString[i] == '.') {
  //       dotCount++;
  //     }
  //   }

  //   return dotCount;
  // }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? shouldNavigateBack = await showDialog<bool>(
      context: context,
      builder: (context) => DigitDialog(
        options: DigitDialogOptions(
          titleText: localizations.translate(
            i18_local.checklist.checklistBackDialogLabel,
          ),
          content: Text(localizations.translate(
            i18_local.checklist.checklistBackDialogDescription,
          )),
          primaryAction: DigitDialogActions(
            label: localizations.translate(
                i18_local.checklist.checklistBackDialogPrimaryAction),
            action: (context) {
              final router = context.router;
              router.pop();
              router.pop();
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(true);
            },
          ),
          secondaryAction: DigitDialogActions(
            label: localizations.translate(
                i18_local.checklist.checklistBackDialogSecondaryAction),
            action: (context) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(false);
            },
          ),
        ),
      ),
    );

    return shouldNavigateBack ?? false;
  }
}
