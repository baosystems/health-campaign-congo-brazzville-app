import 'package:collection/collection.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_dialog.dart';
import 'package:digit_components/widgets/digit_elevated_button.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
// import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/data/local_store/no_sql/schema/app_configuration.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import '../../../blocs/localization/app_localization.dart';
import '../../../blocs/vaccine/vaccine_product_variants.dart';
import '../../../blocs/vaccine/vaccine_search.dart';
import '../../../models/entities/additional_fields_type.dart';
import '../../../models/entities/roles_type.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:survey_form/survey_form.dart';
import '../../../router/app_router.dart';
import '../../../utils/app_enums.dart';
import '../../../utils/constants.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/utils.dart' show getIndividualAdditionalFields;
import '../../../utils/environment_config.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../widgets/localized.dart';
import 'package:digit_data_model/data_model.dart';

// import '../../../models/entities/additional_fields_type.dart'
//     as additional_fields_local;
import '../../../models/entities/assessment_checklist/status.dart'
    as status_local;
import '../../../widgets/custom_back_navigation.dart';
import '../../../widgets/showcase/showcase_wrappers.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/i18_key_constants.dart' as i18_local;
import 'package:survey_form/utils/i18_key_constants.dart' as i18_survey_form;

//  Add this import for the radio button component.
import 'package:group_radio_button/group_radio_button.dart';

@RoutePage()
class VaccineSelectionPage extends LocalizedStatefulWidget {
  final bool isAdministration;
  final EligibilityAssessmentType eligibilityAssessmentType;
  final bool isChecklistAssessmentDone;
  final String? projectBeneficiaryClientReferenceId;
  final IndividualModel? individual;
  final TaskModel task;
  final bool? hasSideEffects;
  final SideEffectModel sideEffect;

  const VaccineSelectionPage({
    super.key,
    super.appLocalizations,
    required this.isAdministration,
    required this.eligibilityAssessmentType,
    required this.isChecklistAssessmentDone,
    this.projectBeneficiaryClientReferenceId,
    this.individual,
    required this.task,
    this.hasSideEffects = false,
    required this.sideEffect,
  });

  @override
  State<VaccineSelectionPage> createState() => _VaccineSelectionPageState();
}

class _VaccineSelectionPageState extends LocalizedState<VaccineSelectionPage> {
  String isStateChanged = '';
  var submitTriggered = false;
  List<TextEditingController> controller = [];
  List<TextEditingController> additionalController = [];
  List<AttributesModel>? initialAttributes;
  ServiceAttributesModel? selectedAttribute;
  ServiceDefinitionModel? selectedServiceDefinition;
  bool isControllersInitialized = false;
  List<int> visibleChecklistIndexes = [];
  GlobalKey<FormState> checklistFormKey = GlobalKey<FormState>();
  Map<String?, String> responses = {};
  bool triggerLocalization = false;
  Set<String> selectedVaccines = {};
  List<String> selectedCodes = [];
  List<String> noSelectedCodes = [];
  int currentIndex = 0;
  String _baseCode(String code) {
    var c = code.toUpperCase().replaceFirst(RegExp(r'^HCM_VACCINE_'), '');
    c = c.replaceFirst(RegExp(r'[_-]\d+$'), '');
    switch (c) {
      case 'PCV13':
      case 'PCV':
      case 'PNEUMO':
        return 'PCV';
      case 'IPV':
      case 'VPI':
        return 'VPI';
      case 'OPV':
      case 'VPO':
        return 'VPO';
      default:
        return c;
    }
  }

  String? _tOrNull(BuildContext context, String key) {
    final s = AppLocalizations.of(context).translate(key);
    if (s.isEmpty || s == key) return null;
    return s;
  }

  static final Map<String, String> _vaccineGuidanceKey = {
    'BCG': i18_local.deliverIntervention.guidanceBcg,
    'VPO': i18_local.deliverIntervention.guidanceVpo,
    'PENTA': i18_local.deliverIntervention.guidancePenta,
    'ROTA': i18_local.deliverIntervention.guidanceRota,
    'PCV': i18_local.deliverIntervention.guidancePneumo,
    'VPI': i18_local.deliverIntervention.guidanceVpi,
    'RR': i18_local.deliverIntervention.guidanceRr,
    'VAA': i18_local.deliverIntervention.guidanceVaa,
    'MEN': i18_local.deliverIntervention.guidanceMen,
    'VIT': i18_local.deliverIntervention.guidanceVit,
  };

  final String _yes = "YES";
  final String _no = "NO";

  TaskModel _getTaskModel() {
    final clientReferenceId = IdGen.i.identifier;
    List<String?> ineligibilityReasons = [];
    ineligibilityReasons.add(Constants.ineligibleForBCG);
    ineligibilityReasons.add(Constants.ineligibleForRota);
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
          if (widget.hasSideEffects == false) ...[
            AdditionalField(
              AdditionalFieldsType.ineligibleReasons.toValue(),
              ineligibilityReasons.join(","),
            ),
          ] else ...[
            AdditionalField(AdditionalFieldsType.ineligibleReasons.toValue(),
                ["SIDE_EFFECTS"].join(",")),
            AdditionalField(
                AdditionalFieldsType.hasSideEffects.toValue(), true.toString()),
          ],
          AdditionalField(
            AdditionalFieldsType.deliveryType.toValue(),
            EligibilityAssessmentStatus.smcDone.name,
          ),
          AdditionalField(
            AdditionalFieldsType.doseStatus.toValue(),
            _getDoseStatus(selectedCodes, noSelectedCodes).name,
          ),
          AdditionalField(
            AdditionalFieldsType.selectedVaccines.toValue(),
            selectedCodes.join('.'),
          ),
          AdditionalField(
            AdditionalFieldsType.noSelectedVaccines.toValue(),
            noSelectedCodes.join('.'),
          ),
          ...getIndividualAdditionalFields(widget.individual)
        ],
      ),
      address: widget.individual?.address?.first.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
    );
  }

  Widget _buildGuidancePanel({
    required BuildContext context,
    required List<String> vaccineCodesInBucket,
  }) {
    const preferredOrder = [
      'BCG',
      'VPO',
      'PENTA',
      'ROTA',
      'PCV',
      'VPI',
      'RR',
      'VAA',
      'MEN',
      'VIT'
    ];

    final basesInBucket = vaccineCodesInBucket.map(_baseCode).toSet();
    final orderedBases = preferredOrder.where(basesInBucket.contains).toList();

    final title =
        _tOrNull(context, i18_local.deliverIntervention.guidanceTitle);
    if (title == null) return const SizedBox.shrink();

    final lines = orderedBases
        .map((b) => _vaccineGuidanceKey[b])
        .whereType<String>()
        .map((key) => _tOrNull(context, key))
        .whereType<String>()
        .toList();

    if (lines.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return DigitCard(
      margin: const EdgeInsets.fromLTRB(spacer3, spacer2, spacer3, spacer4),
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: const EdgeInsets.all(spacer4),
          color: const Color(0xFFE7F1FA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.info, color: Color(0xFF2196F3), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: spacer3),
              ...lines.map((line) => Padding(
                    padding: const EdgeInsets.only(bottom: spacer2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.chevron_right,
                              size: 18, color: Colors.black),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            line,
                            softWrap: true,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.35,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    context.read<LocationBloc>().add(const LocationEvent.load());
    context.read<ServiceBloc>().add(ServiceSearchEvent(
          serviceSearchModel: ServiceSearchModel(
            relatedClientReferenceId:
                widget.projectBeneficiaryClientReferenceId,
          ),
        ));
    super.initState();
  }

  bool _isVaccineAllowedToShow({
    required String vaccineCode,
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
    return selectedCodes.contains(prevCode);
  }

  void _saveResponses(Map<String, String?> responses) {
    final newlyNoSelected = <String>[];
    for (var entry in responses.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value == _yes) {
        // Remove from "no" if present
        noSelectedCodes.remove(key);
        // Add to "yes" if not present
        if (!selectedCodes.contains(key)) {
          selectedCodes.add(key);
        }
      } else if (value == _no) {
        // Remove from "yes" if present
        if (selectedCodes.remove(key)) {
          // Moved from yes to no then add to newlyNoSeleced ones
          newlyNoSelected.add(key);
        }
        // Add to "no" if not present
        if (!noSelectedCodes.contains(key)) {
          noSelectedCodes.add(key);
        }
      }
    }

    // Now remove dependent vaccines of the changed ones from selectedCodes to noSelectedCodes
    for (final removedCode in newlyNoSelected) {
      final match = RegExp(r'^(.*?)([_-])(\d+)$').firstMatch(removedCode);
      if (match != null) {
        final base = match.group(1)!;
        final sep = match.group(2)!;
        final num = int.tryParse(match.group(3)!);
        if (num != null) {
          // Remove all higher versioned vaccines (e.g., VPO-1, VPO-2)
          final dependentCodesToRemove = selectedCodes.where((code) {
            final m = RegExp(r'^(.*?)([_-])(\d+)$').firstMatch(code);
            if (m == null) return false;
            final b = m.group(1);
            final s = m.group(2);
            final n = int.tryParse(m.group(3)!);
            return b == base && s == sep && n != null && n > num;
          }).toList();

          for (final dependent in dependentCodesToRemove) {
            selectedCodes.remove(dependent);
            if (!noSelectedCodes.contains(dependent)) {
              noSelectedCodes.add(dependent);
            }
          }
        }
      }
    }
  }

  bool _isValid({
    required Map<String, String?> responses,
    required List<String> allVaccineCodes,
    required List<String> vaccineCodes,
  }) {
    for (int i = 0; i < vaccineCodes.length; i++) {
      String vaccineCode = vaccineCodes[i];
      if (_isVaccineAllowedToShow(
          vaccineCode: vaccineCode, allVaccineCodes: allVaccineCodes)) {
        if (responses[vaccineCode] == null) {
          return false;
        }
      }
    }

    return true;
  }

  String _numberToWords(int number) {
    // Simple mapping for numbers 0-6, extend as needed
    const words = [
      'Zero',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
    ];
    if (number >= 0 && number < words.length) {
      return words[number];
    }
    return number.toString();
  }

  Widget _buildVaccineRadioChecklist({
    required int index,
    required BuildContext context,
    required Map<String, String?> vaccineResponses,
    required List<String> vaccineCodes,
  }) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return DigitCard(
      padding: const EdgeInsets.fromLTRB(spacer4, spacer4, spacer4, spacer8),
      margin: const EdgeInsets.fromLTRB(spacer3, spacer4, spacer3, spacer4),
      children: [
        Text(
            localizations.translate(
              '${i18_local.deliverIntervention.vaccinsSelectionLabelForGroup}_${_numberToWords(index).toUpperCase()}',
            ),
            style: theme.textTheme.headlineLarge),
        Text(
          AppLocalizations.of(context).translate(
            i18_local.deliverIntervention.vaccinsSelectionInstruction,
          ),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF4B5563),
                height: 1.25,
              ),
        ),
        const SizedBox(height: spacer4),
        Column(
          children: [
            for (int i = 0; i < vaccineCodes.length; i++) ...{
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    String vaccineCode = vaccineCodes[i];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: spacer3,
                        ),
                        Expanded(
                          child: Text(localizations.translate(vaccineCode),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                              )),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                vaccineResponses[vaccineCode] = _yes;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  value: _yes,
                                  groupValue: vaccineResponses[vaccineCode],
                                  onChanged: (value) {
                                    setState(() {
                                      vaccineResponses[vaccineCode] = value!;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                const SizedBox(
                                  width: spacer1,
                                ),
                                Flexible(
                                  child: Text(
                                    localizations.translate(i18_local
                                        .householdDetails.capitalYesLabelText),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                vaccineResponses[vaccineCode] = _no;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  value: _no,
                                  groupValue: vaccineResponses[vaccineCode],
                                  onChanged: (value) {
                                    setState(() {
                                      vaccineResponses[vaccineCode] = value!;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                const SizedBox(
                                  width: spacer1,
                                ),
                                Flexible(
                                  child: Text(
                                    localizations.translate(i18_local
                                        .householdDetails.capitalNoLabelText),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: spacer4,
              ),
            }
          ],
        ),
      ],
    );
  }

  DoseStatus _getDoseStatus(
      List<String> selectedCodes, List<String> noSelectedCodes) {
    if (selectedCodes.isEmpty && noSelectedCodes.isEmpty) {
      return DoseStatus.none;
    } else if ((selectedCodes.isEmpty && noSelectedCodes.isNotEmpty) ||
        (selectedCodes.isNotEmpty &&
            noSelectedCodes.isNotEmpty &&
            noSelectedCodes.contains(Constants.penta1))) {
      return DoseStatus.zeroDose;
    } else if (selectedCodes.isNotEmpty &&
        noSelectedCodes.isNotEmpty &&
        selectedCodes.contains(Constants.penta1)) {
      return DoseStatus.underVaccinated;
    } else if (selectedCodes.isNotEmpty && noSelectedCodes.isEmpty) {
      return DoseStatus.fullyVaccinated;
    }
    return DoseStatus.zeroDose;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocListener<ServiceBloc, ServiceState>(listener: (context, state) {
      state.maybeWhen(
        orElse: () {},
        serviceSearch: (serviceList, selectedService, loading) {
          if (serviceList.isNotEmpty) {
            final service = serviceList.last;
            if (service.attributes != null && service.attributes!.isNotEmpty) {
              selectedAttribute = service.attributes!
                  .where((e) => e.dataType == 'MultiValueList')
                  .toList()
                  .firstOrNull;
              final selectedCodesString = selectedAttribute?.value as String;
              // setState(() {
              //   selectedCodes = selectedCodesString.split('.').toList();
              // });
            }
          }
        },
      );
    }, child:
        BlocBuilder<VaccineProductVariantBloc, VaccineProductVariantState>(
      builder: (context, vaccineVariantsBloc) {
        List<VaccineDoseData> vaccineDataList =
            vaccineVariantsBloc.vaccineDataList ?? [];
        return BlocBuilder<VaccineSearchBloc, VaccineSearchState>(
          builder: (context, vaccineSearchBloc) {
            Map<int, Set<String>>? eligibleVaccinesDoseCodeByAgeIndex =
                vaccineSearchBloc.eligibleVaccinesDoseCodeByAgeIndex;

            final dobStr = context
                .read<HouseholdOverviewBloc>()
                .state
                .selectedIndividual
                ?.dateOfBirth;
            final ageInDays = calculateAgeInDaysFromDob(dobStr ?? '');

            final allVaccineCodes = [
              for (final v in vaccineDataList) v.doseCode
            ];
            // final Map<String, String> vaccineCodeToName = {
            //   for (final v in vaccineDataList) v.doseCode: v.name
            // };

            final List<int> ageList =
                (vaccineDataList.map((e) => e.ageInDays).toSet().toList()
                  ..sort());

            if (ageList.isEmpty) {
              final pbId = widget.projectBeneficiaryClientReferenceId ??
                  context
                      .read<HouseholdOverviewBloc>()
                      .state
                      .selectedIndividual
                      ?.clientReferenceId ??
                  '';
              return const SizedBox.shrink();
            }

            final Map<int, List<String>> ageToVaccineCodes = {};
            for (final v in vaccineDataList) {
              ageToVaccineCodes.putIfAbsent(v.ageInDays, () => []);
              ageToVaccineCodes[v.ageInDays]!.add(v.doseCode);
            }

            // Find last bucket allowed for the child age
            int lastIndex = ageList.length - 1;
            for (final age in ageList) {
              if (age > ageInDays) {
                lastIndex = ageList.indexOf(age) - 1;
                break;
              }
            }
            // Clamp lastIndex to valid range
            if (lastIndex < 0) lastIndex = 0;

            // Always clamp currentIndex before indexing
            final int safeIndex = currentIndex.clamp(0, lastIndex);
            final int nextSafeIndex = (currentIndex + 1).clamp(0, lastIndex);
            final int bucketAge = ageList[safeIndex];
            final int nextBucketAge = ageList[nextSafeIndex];

            // Build current bucket codes (filtering dose dependencies)
            final List<String> rowCodes = List<String>.from(
              ageToVaccineCodes[bucketAge] ?? const <String>[],
            );
            final List<String> nextRowCodes = List<String>.from(
              ageToVaccineCodes[nextBucketAge] ?? const <String>[],
            );
            final List<String> currentVaccineCodes = [
              for (final code in rowCodes)
                if (_isVaccineAllowedToShow(
                  vaccineCode: code,
                  allVaccineCodes: allVaccineCodes,
                ))
                  code
            ];

            final List<String> nexRowVaccineDoseCodes = [
              for (final code in nextRowCodes)
                if (_isVaccineAllowedToShow(
                  vaccineCode: code,
                  allVaccineCodes: allVaccineCodes,
                ))
                  code
            ];

            // If current bucket ends up empty, move forward (or finish if we’re at the end)
            if (currentVaccineCodes.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (currentIndex < lastIndex) {
                  setState(() => currentIndex += 1);
                } else {
                  // No more buckets to show: go final step (Reasons if any "NO", else submit)
                  final pbId = widget.projectBeneficiaryClientReferenceId ??
                      context
                          .read<HouseholdOverviewBloc>()
                          .state
                          .selectedIndividual
                          ?.clientReferenceId ??
                      '';
                }
              });
              return const SizedBox.shrink();
            }

            // If next bucket ends up empty, treat current as last
            // if (nexRowVaccineDoseCodes.isEmpty) {
            //   lastIndex = currentIndex;
            // }

            // Pre-fill responses (so validators don’t trip)
            final Map<String, String?> currentResponses = {};
            for (final code in currentVaccineCodes) {
              if (selectedCodes.contains(code)) {
                currentResponses[code] = _yes;
              } else if (noSelectedCodes.contains(code)) {
                currentResponses[code] = _no;
              }
            }

            if (currentIndex < lastIndex) {
              return ScrollableContent(
                header: const Column(children: [
                  CustomBackNavigationHelpHeaderWidget(
                    showHelp: false,
                  )
                ]),
                enableFixedDigitButton: true,
                footer: DigitCard(
                  margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
                  padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
                  children: [
                    DigitElevatedButton(
                      onPressed: () async {
                        if (!_isValid(
                            responses: currentResponses,
                            allVaccineCodes: allVaccineCodes,
                            vaccineCodes: currentVaccineCodes)) {
                          await DigitToast.show(
                            context,
                            options: DigitToastOptions(
                              localizations.translate(
                                i18.common.corecommonRequired,
                              ),
                              true,
                              theme,
                            ),
                          );
                          return;
                        }
                        _saveResponses(currentResponses);
                        setState(() {
                          currentIndex++;
                        });
                      },
                      child: Text(
                        localizations.translate(i18.common.coreCommonNext),
                      ),
                    )
                  ],
                ),
                children: [
                  _buildVaccineRadioChecklist(
                    context: context,
                    index: currentIndex,
                    vaccineResponses: currentResponses,
                    vaccineCodes: currentVaccineCodes,
                  ),
                  _buildGuidancePanel(
                    context: context,
                    vaccineCodesInBucket: currentVaccineCodes,
                  ),
                ],
              );
            }

            return PopScope(
                canPop: true,
                child: Scaffold(body: BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, locationState) {
                  return BlocBuilder<HouseholdOverviewBloc,
                      HouseholdOverviewState>(
                    builder: (context, householdOverviewState) {
                      double? latitude = locationState.latitude;
                      double? longitude = locationState.longitude;
                      String vaccineSelection = "ZERODOSE_ASSESSMENT";
                      return BlocBuilder<ServiceDefinitionBloc,
                          ServiceDefinitionState>(
                        builder: (context, state) {
                          state.maybeMap(
                            orElse: () {},
                            serviceDefinitionFetch: (value) {
                              selectedServiceDefinition = value
                                  .serviceDefinitionList
                                  .where((element) =>
                                      element.code.toString().contains(
                                            '${context.selectedProject.name}.$vaccineSelection.${RolesType.communityDistributor.toValue()}',
                                          ))
                                  .toList()
                                  .firstOrNull;
                              initialAttributes =
                                  selectedServiceDefinition?.attributes!;
                              if (!isControllersInitialized) {
                                initialAttributes?.forEach((e) {
                                  if (e.dataType == 'MultiValueList') {
                                    controller.add(TextEditingController(
                                        text: selectedCodes.join('.')));
                                    selectedVaccines = selectedCodes.toSet();
                                  } else {
                                    controller.add(TextEditingController());
                                  }
                                });
                                isControllersInitialized = true;
                              }
                            },
                          );

                          return state.maybeMap(
                            orElse: () => Text(state.runtimeType.toString()),
                            serviceDefinitionFetch: (value) {
                              return ScrollableContent(
                                header: const Column(children: [
                                  CustomBackNavigationHelpHeaderWidget(
                                    showHelp: false,
                                  )
                                ]),
                                enableFixedDigitButton: true,
                                footer: DigitCard(
                                  margin: const EdgeInsets.fromLTRB(
                                      0, kPadding, 0, 0),
                                  padding: const EdgeInsets.fromLTRB(
                                      kPadding, 0, kPadding, 0),
                                  children: [
                                    DigitElevatedButton(
                                      onPressed: () async {
                                        if (!_isValid(
                                            responses: currentResponses,
                                            allVaccineCodes: allVaccineCodes,
                                            vaccineCodes:
                                                currentVaccineCodes)) {
                                          await DigitToast.show(
                                            context,
                                            options: DigitToastOptions(
                                              localizations.translate(
                                                i18.common.corecommonRequired,
                                              ),
                                              true,
                                              theme,
                                            ),
                                          );
                                          return;
                                        }
                                        _saveResponses(currentResponses);

                                        final pbId = widget
                                                .projectBeneficiaryClientReferenceId ??
                                            context
                                                .read<HouseholdOverviewBloc>()
                                                .state
                                                .selectedIndividual
                                                ?.clientReferenceId;

                                        if (pbId == null || pbId.isEmpty) {
                                          await DigitToast.show(
                                            context,
                                            options: DigitToastOptions(
                                                'Missing beneficiary ID',
                                                true,
                                                Theme.of(context)),
                                          );
                                          return;
                                        }

                                        submitTriggered = true;
                                        final itemsAttributes =
                                            initialAttributes;

                                        final nonEmptySelectedCodes =
                                            selectedCodes
                                                .where(
                                                    (e) => e.trim().isNotEmpty)
                                                .toList();

                                        for (int i = 0;
                                            i < initialAttributes!.length;
                                            i++) {
                                          if (itemsAttributes?[i].dataType ==
                                              'SingleValueList') {
                                            controller[i].text = 'NOT_SELECTED';
                                          }
                                          if (itemsAttributes?[i].dataType ==
                                                  'MultiValueList' &&
                                              controller[i].text == '') {
                                            controller[i].text =
                                                (nonEmptySelectedCodes
                                                        .isNotEmpty
                                                    ? nonEmptySelectedCodes
                                                        .join('.')
                                                    : 'NOT_SELECTED');
                                          }
                                          if (itemsAttributes?[i].required ==
                                                  true &&
                                              ((itemsAttributes?[i].dataType ==
                                                          'SingleValueList' &&
                                                      (controller[i].text ==
                                                          '')) ||
                                                  (itemsAttributes?[i]
                                                              .dataType !=
                                                          'SingleValueList' &&
                                                      (controller[i].text ==
                                                              '' ||
                                                          !(widget.projectBeneficiaryClientReferenceId !=
                                                              null))))) {
                                            return;
                                          }
                                        }
                                        for (final code in selectedCodes) {
                                          final match =
                                              RegExp(r'^(.*?)([_-])(\d+)$')
                                                  .firstMatch(code);
                                          if (match != null) {
                                            final base = match.group(1);
                                            final sep =
                                                match.group(2); // '_' or '-'
                                            final num = int.tryParse(
                                                match.group(3) ?? '');
                                            if (num != null && num > 1) {
                                              final prevCode =
                                                  '$base$sep${num - 1}';
                                              if (!selectedCodes
                                                  .contains(prevCode)) {
                                                DigitToast.show(
                                                  context,
                                                  options: DigitToastOptions(
                                                    'You have not selected ${localizations.translate(prevCode)}.',
                                                    true,
                                                    theme,
                                                  ),
                                                );
                                                return;
                                              }
                                            }
                                          }
                                        }
                                        triggerLocalization = true;

                                        final shouldSubmit =
                                            await DigitDialog.show(
                                          context,
                                          options: DigitDialogOptions(
                                            titleText: localizations.translate(
                                              i18.deliverIntervention
                                                  .dialogTitle,
                                            ),
                                            contentText:
                                                localizations.translate(
                                              i18.deliverIntervention
                                                  .dialogContent,
                                            ),
                                            primaryAction: DigitDialogActions(
                                              label: localizations.translate(
                                                i18.common.coreCommonSubmit,
                                              ),
                                              action: (ctx) {
                                                final referenceId =
                                                    IdGen.i.identifier;
                                                List<ServiceAttributesModel>
                                                    attributes = [];
                                                for (int i = 0;
                                                    i < controller.length;
                                                    i++) {
                                                  final attribute =
                                                      initialAttributes;

                                                  attributes.add(
                                                      ServiceAttributesModel(
                                                    auditDetails: AuditDetails(
                                                      createdBy: context
                                                          .loggedInUserUuid,
                                                      createdTime: context
                                                          .millisecondsSinceEpoch(),
                                                    ),
                                                    attributeCode:
                                                        '${attribute?[i].code}',
                                                    dataType:
                                                        attribute?[i].dataType,
                                                    clientReferenceId:
                                                        IdGen.i.identifier,
                                                    referenceId: referenceId,
                                                    value: attribute?[i]
                                                                .dataType ==
                                                            'MultiValueList'
                                                        ? controller[i]
                                                                .text
                                                                .toString()
                                                                .isNotEmpty
                                                            ? controller[i]
                                                                .text
                                                                .toString()
                                                            : i18_survey_form
                                                                .surveyForm
                                                                .notSelectedKey
                                                        : attribute?[i]
                                                                    .dataType !=
                                                                'SingleValueList'
                                                            ? controller[i]
                                                                    .text
                                                                    .toString()
                                                                    .trim()
                                                                    .isNotEmpty
                                                                ? controller[i]
                                                                    .text
                                                                    .toString()
                                                                : (attribute?[i]
                                                                            .dataType !=
                                                                        'Number'
                                                                    ? i18_survey_form
                                                                        .surveyForm
                                                                        .notSelectedKey
                                                                    : '0')
                                                            : visibleChecklistIndexes
                                                                    .contains(i)
                                                                ? controller[i]
                                                                    .text
                                                                    .toString()
                                                                : i18_survey_form
                                                                    .surveyForm
                                                                    .notSelectedKey,
                                                    rowVersion: 1,
                                                    tenantId:
                                                        attribute?[i].tenantId,
                                                    additionalFields:
                                                        ServiceAttributesAdditionalFields(
                                                      version: 1,
                                                      // TODO: This needs to be done after adding locationbloc
                                                      fields: [
                                                        AdditionalField(
                                                          'latitude',
                                                          latitude,
                                                        ),
                                                        AdditionalField(
                                                          'longitude',
                                                          longitude,
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                                }

                                                context.read<ServiceBloc>().add(
                                                      ServiceCreateEvent(
                                                        serviceModel:
                                                            ServiceModel(
                                                                createdAt: DigitDateUtils
                                                                    .getDateFromTimestamp(
                                                                  DateTime.now()
                                                                      .toLocal()
                                                                      .millisecondsSinceEpoch,
                                                                  dateFormat:
                                                                      Constants
                                                                          .checklistViewDateFormat,
                                                                ),
                                                                tenantId:
                                                                    selectedServiceDefinition!
                                                                        .tenantId,
                                                                clientId:
                                                                    referenceId,
                                                                serviceDefId:
                                                                    selectedServiceDefinition
                                                                        ?.id,
                                                                relatedClientReferenceId: widget
                                                                    .projectBeneficiaryClientReferenceId,
                                                                attributes:
                                                                    attributes,
                                                                rowVersion: 1,
                                                                accountId: context
                                                                    .projectId,
                                                                auditDetails:
                                                                    AuditDetails(
                                                                  createdBy: context
                                                                      .loggedInUserUuid,
                                                                  createdTime: DateTime
                                                                          .now()
                                                                      .millisecondsSinceEpoch,
                                                                ),
                                                                clientAuditDetails:
                                                                    ClientAuditDetails(
                                                                  createdBy: context
                                                                      .loggedInUserUuid,
                                                                  createdTime:
                                                                      context
                                                                          .millisecondsSinceEpoch(),
                                                                  lastModifiedBy:
                                                                      context
                                                                          .loggedInUserUuid,
                                                                  lastModifiedTime:
                                                                      context
                                                                          .millisecondsSinceEpoch(),
                                                                ),
                                                                additionalFields:
                                                                    ServiceAdditionalFields(
                                                                  version: 1,
                                                                  fields: [
                                                                    AdditionalField(
                                                                        'boundaryCode',
                                                                        context
                                                                            .boundary
                                                                            .code),
                                                                    // AdditionalField(
                                                                    //   'vaccinationsuccessful',
                                                                    //   isVaccinationSuccessful,
                                                                    // ),
                                                                  ],
                                                                )),
                                                      ),
                                                    );

                                                Navigator.of(
                                                  context,
                                                  rootNavigator: true,
                                                ).pop(true);
                                              },
                                            ),
                                            secondaryAction: DigitDialogActions(
                                              label: localizations.translate(
                                                i18.common.coreCommonGoback,
                                              ),
                                              action: (ctx) {
                                                Navigator.of(ctx,
                                                        rootNavigator: true)
                                                    .pop(false);
                                              },
                                            ),
                                          ),
                                        );
                                        if (shouldSubmit ?? false) {
                                          final router = context.router;
                                          submitTriggered = true;

                                          context.read<ServiceBloc>().add(
                                                const ServiceSurveyFormEvent(
                                                  value: '',
                                                  submitTriggered: true,
                                                ),
                                              );

                                          if (widget
                                                  .isChecklistAssessmentDone ==
                                              true) {
                                            final deliverState = context
                                                .read<DeliverInterventionBloc>()
                                                .state;

                                            final oldTask =
                                                deliverState.oldTask ??
                                                    widget.task;
                                            final oldFields = oldTask
                                                    .additionalFields?.fields ??
                                                [];

                                            final updatedFields = [
                                              ...oldFields,
                                              AdditionalField(
                                                AdditionalFieldsType.doseStatus
                                                    .toValue(),
                                                _getDoseStatus(selectedCodes,
                                                        noSelectedCodes)
                                                    .name,
                                              ),
                                              if (selectedCodes.isNotEmpty)
                                                AdditionalField(
                                                  AdditionalFieldsType
                                                      .selectedVaccines
                                                      .toValue(),
                                                  selectedCodes.join('.'),
                                                ),
                                              if (noSelectedCodes.isNotEmpty)
                                                AdditionalField(
                                                  AdditionalFieldsType
                                                      .noSelectedVaccines
                                                      .toValue(),
                                                  noSelectedCodes.join('.'),
                                                ),
                                            ];

                                            final updatedTask =
                                                oldTask.copyWith(
                                              additionalFields:
                                                  TaskAdditionalFields(
                                                version: 1,
                                                fields: updatedFields,
                                              ),
                                            );

                                            context
                                                .read<DeliverInterventionBloc>()
                                                .add(
                                                  DeliverInterventionSubmitEvent(
                                                    task: updatedTask,
                                                    isEditing: (deliverState
                                                                    .tasks ??
                                                                [])
                                                            .isNotEmpty &&
                                                        RegistrationDeliverySingleton()
                                                                .beneficiaryType ==
                                                            BeneficiaryType
                                                                .household,
                                                    boundaryModel:
                                                        RegistrationDeliverySingleton()
                                                            .boundary!,
                                                  ),
                                                );

                                            ProjectTypeModel? projectTypeModel =
                                                widget.eligibilityAssessmentType ==
                                                        EligibilityAssessmentType
                                                            .smc
                                                    ? RegistrationDeliverySingleton()
                                                        .selectedProject
                                                        ?.additionalDetails
                                                        ?.projectType
                                                    : RegistrationDeliverySingleton()
                                                        .selectedProject
                                                        ?.additionalDetails
                                                        ?.additionalProjectType;

                                            if (widget.isAdministration ==
                                                true) {
                                              router.popUntilRouteWithName(
                                                  BeneficiaryWrapperRoute.name);
                                              if (deliverState
                                                          .futureDeliveries !=
                                                      null &&
                                                  deliverState.futureDeliveries!
                                                      .isNotEmpty &&
                                                  projectTypeModel?.cycles
                                                          ?.isNotEmpty ==
                                                      true) {
                                                router.push(
                                                  CustomSplashAcknowledgementRoute(
                                                      enableBackToSearch: false,
                                                      eligibilityAssessmentType:
                                                          widget
                                                              .eligibilityAssessmentType),
                                                );
                                              } else {
                                                final reloadState = context.read<
                                                    HouseholdOverviewBloc>();

                                                reloadState.add(
                                                  HouseholdOverviewReloadEvent(
                                                    projectId:
                                                        RegistrationDeliverySingleton()
                                                            .projectId!,
                                                    projectBeneficiaryType:
                                                        RegistrationDeliverySingleton()
                                                            .beneficiaryType!,
                                                  ),
                                                );
                                                router.popAndPush(
                                                  CustomHouseholdAcknowledgementRoute(
                                                    enableViewHousehold: true,
                                                    eligibilityAssessmentType:
                                                        widget
                                                            .eligibilityAssessmentType,
                                                  ),
                                                );
                                              }
                                            } else {
                                              final searchBloc = context
                                                  .read<SearchHouseholdsBloc>();
                                              searchBloc.add(
                                                const SearchHouseholdsClearEvent(),
                                              );
                                              router.popUntilRouteWithName(
                                                  BeneficiaryWrapperRoute.name);
                                              router.push(
                                                CustomHouseholdAcknowledgementRoute(
                                                    enableViewHousehold: true,
                                                    eligibilityAssessmentType:
                                                        widget
                                                            .eligibilityAssessmentType),
                                              );
                                            }
                                          } else {
                                            if (widget.hasSideEffects == true) {
                                              context
                                                  .read<SideEffectsBloc>()
                                                  .add(
                                                    SideEffectsSubmitEvent(
                                                      widget.sideEffect!,
                                                      false,
                                                    ),
                                                  );
                                            }
                                            TaskModel task = _getTaskModel();
                                            context
                                                .read<DeliverInterventionBloc>()
                                                .add(
                                                  DeliverInterventionSubmitEvent(
                                                    task: task,
                                                    isEditing: false,
                                                    boundaryModel:
                                                        context.boundary,
                                                    navigateToSummary: false,
                                                    householdMemberWrapper: context
                                                        .read<
                                                            HouseholdOverviewBloc>()
                                                        .state
                                                        .householdMemberWrapper,
                                                  ),
                                                );

                                            final reloadState = context
                                                .read<HouseholdOverviewBloc>();

                                            reloadState.add(
                                              HouseholdOverviewReloadEvent(
                                                projectId:
                                                    RegistrationDeliverySingleton()
                                                        .projectId!,
                                                projectBeneficiaryType:
                                                    RegistrationDeliverySingleton()
                                                        .beneficiaryType!,
                                              ),
                                            );
                                            final searchBloc = context
                                                .read<SearchHouseholdsBloc>();
                                            searchBloc.add(
                                              const SearchHouseholdsClearEvent(),
                                            );
                                            final pbId = widget
                                                    .projectBeneficiaryClientReferenceId ??
                                                context
                                                    .read<
                                                        HouseholdOverviewBloc>()
                                                    .state
                                                    .selectedIndividual
                                                    ?.clientReferenceId ??
                                                '';
                                            if (noSelectedCodes.isNotEmpty) {
                                              final taskToPass = context
                                                      .read<
                                                          DeliverInterventionBloc>()
                                                      .state
                                                      .oldTask ??
                                                  widget.task;

                                              router.push(
                                                ReasonsForNonVaccinationRoute(
                                                  projectBeneficiaryClientReferenceId:
                                                      pbId,
                                                  individual: widget.individual,
                                                  selectedYesCodes:
                                                      selectedCodes,
                                                  selectedNoCodes:
                                                      noSelectedCodes,
                                                  task: taskToPass,
                                                ),
                                              );
                                            } else {
                                              if (widget.isAdministration ==
                                                  true) {
                                                router.push(
                                                  CustomSplashAcknowledgementRoute(
                                                      enableBackToSearch: false,
                                                      eligibilityAssessmentType:
                                                          widget
                                                              .eligibilityAssessmentType),
                                                );
                                              } else {
                                                router.push(
                                                  CustomHouseholdAcknowledgementRoute(
                                                      enableViewHousehold: true,
                                                      eligibilityAssessmentType:
                                                          widget
                                                              .eligibilityAssessmentType),
                                                );
                                              }
                                            }
                                          }
                                        }
                                      },
                                      child: Text(
                                        localizations.translate(
                                            i18.common.coreCommonSubmit),
                                      ),
                                    )
                                  ],
                                ),
                                children: [
                                  _buildVaccineRadioChecklist(
                                    context: context,
                                    index: currentIndex,
                                    vaccineResponses: currentResponses,
                                    vaccineCodes: currentVaccineCodes,
                                  ),
                                  _buildGuidancePanel(
                                    context: context,
                                    vaccineCodesInBucket: currentVaccineCodes,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                })));
          },
        );
      },
    ));
  }
}

int calculateAgeInDaysFromDob(String dobString) {
  final dob = DigitDateUtils.getFormattedDateToDateTime(dobString);
  if (dob == null) return 0;
  final now = DateTime.now();
  return now.difference(dob).inDays;
}
