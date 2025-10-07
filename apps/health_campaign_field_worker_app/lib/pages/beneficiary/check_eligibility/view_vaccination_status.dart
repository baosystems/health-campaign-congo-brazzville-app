// import 'dart:math';

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_checkbox_tile.dart';
import 'package:digit_components/widgets/digit_dialog.dart';
import 'package:digit_components/widgets/digit_elevated_button.dart';
import 'package:digit_data_model/data/local_store/sql_store/tables/service.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
// import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_campaign_field_worker_app/blocs/app_initialization/app_initialization.dart';
import 'package:health_campaign_field_worker_app/data/local_store/no_sql/schema/app_configuration.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import '../../../blocs/localization/app_localization.dart';
import '../../../blocs/vaccine/vaccine_product_variants.dart';
import '../../../blocs/vaccine/vaccine_search.dart';
import '../../../data/repositories/custom_task.dart';
import '../../../models/entities/additional_fields_type.dart';
import '../../../models/entities/roles_type.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:survey_form/survey_form.dart';
import '../../../models/entities/status.dart';
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
import 'package:digit_components/widgets/atoms/checkbox_icon.dart';
import 'package:survey_form/utils/i18_key_constants.dart' as i18_survey_form;

//  Add this import for the radio button component.
import 'package:group_radio_button/group_radio_button.dart';

@RoutePage()
class ViewVaccinationStatusPage extends LocalizedStatefulWidget {
  final String? projectBeneficiaryClientReferenceId;

  const ViewVaccinationStatusPage({
    super.key,
    super.appLocalizations,
    this.projectBeneficiaryClientReferenceId,
  });

  @override
  State<ViewVaccinationStatusPage> createState() =>
      _ViewVaccinationStatusPageState();
}

class _ViewVaccinationStatusPageState
    extends LocalizedState<ViewVaccinationStatusPage> {
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
    // if (!false) {
    //   context.read<ServiceBloc>().add(ServiceSurveyFormEvent(
    //         value: Random().nextInt(100).toString(),
    //         submitTriggered: true,
    //       ));
    // } else {
    //   context.read<ServiceBloc>().add(ServiceSearchEvent(
    //         serviceSearchModel: ServiceSearchModel(
    //           relatedClientReferenceId:
    //               widget.projectBeneficiaryClientReferenceId,
    //         ),
    //       ));
    // }
    // fetchTasksData();
    super.initState();
  }

  // Future<void> fetchTasksData() async {
  //   List<String> yesSelectedVaccines = [];
  //   List<String> noSelectedVaccines = [];
  //   // ignore: avoid_dynamic_calls
  //   yesSelectedVaccines = ((widget.task.additionalFields!.fields
  //               .firstWhereOrNull((e) =>
  //                   e.key == AdditionalFieldsType.selectedVaccines.toValue())
  //               ?.value as String?) ??
  //           '')
  //       .split('.')
  //       // ignore: avoid_dynamic_calls
  //       .where((e) => e.isNotEmpty)
  //       .toList();

  //   // ignore: avoid_dynamic_calls
  //   noSelectedVaccines = ((widget.task.additionalFields!.fields
  //               .firstWhereOrNull((e) =>
  //                   e.key == AdditionalFieldsType.noSelectedVaccines.toValue())
  //               ?.value as String?) ??
  //           '')
  //       .split('.')
  //       // ignore: avoid_dynamic_calls
  //       .where((e) => e.isNotEmpty)
  //       .toList();

  //   setState(() {
  //     selectedCodes = yesSelectedVaccines;
  //     noSelectedCodes = noSelectedVaccines;
  //   });
  // }

  bool isVaccineAllowedToShow({
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

  void saveResponses(Map<String, String?> responses) {
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

  bool isValid({
    required Map<String, String?> responses,
    required List<String> allVaccineCodes,
    required List<String> vaccineCodes,
  }) {
    for (int i = 0; i < vaccineCodes.length; i++) {
      String vaccineCode = vaccineCodes[i];
      if (isVaccineAllowedToShow(
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
                    return IgnorePointer(
                      child: Opacity(
                        opacity: 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: spacer3,
                            ),
                            Expanded(
                              child: Text(localizations.translate(vaccineCode),
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
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
                                          vaccineResponses[vaccineCode] =
                                              value!;
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
                                            .householdDetails
                                            .capitalYesLabelText),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                          vaccineResponses[vaccineCode] =
                                              value!;
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
                                            .householdDetails
                                            .capitalNoLabelText),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
    }, child: BlocBuilder<VaccineSearchBloc, VaccineSearchState>(
      builder: (context, vaccineSearchState) {
        selectedCodes = vaccineSearchState.availedVaccineDoseCodes ?? [];
        noSelectedCodes = (vaccineSearchState.allEligibleVaccineDoseCodes ?? [])
            .whereNot((e) => selectedCodes.contains(e))
            .toList();
        Map<int, Set<String>> eligibleVaccinesDoseCodeByAgeIndex =
            vaccineSearchState.eligibleVaccinesDoseCodeByAgeIndex ?? {};
        return BlocBuilder<VaccineProductVariantBloc,
            VaccineProductVariantState>(
          builder: (context, vaccineVariantState) {
            List<VaccineDoseData> vaccineDataList =
                vaccineVariantState.vaccineDataList ?? [];

            final allVaccineCodes = [
              for (final v in vaccineDataList) v.doseCode
            ];

            final List<int> ageList =
                (vaccineDataList.map((e) => e.ageInDays).toSet().toList()
                  ..sort());

            if (ageList.isEmpty) {
              return const SizedBox.shrink();
            }

            final Map<int, List<String>> ageToVaccineCodes = {};
            for (final v in vaccineDataList) {
              ageToVaccineCodes.putIfAbsent(v.ageInDays, () => []);
              ageToVaccineCodes[v.ageInDays]!.add(v.doseCode);
            }

            // Find last bucket allowed for the child age
            int lastIndex = eligibleVaccinesDoseCodeByAgeIndex.keys.length - 1;
            // Clamp lastIndex to valid range
            if (lastIndex < 0) lastIndex = 0;

            // Always clamp currentIndex before indexing
            final int safeIndex = currentIndex.clamp(0, lastIndex);
            final int bucketAge = ageList[safeIndex];

            // Build current bucket codes (filtering dose dependencies)
            final List<String> rawCodes = List<String>.from(
              ageToVaccineCodes[bucketAge] ?? const <String>[],
            );
            final List<String> currentVaccineCodes = [
              for (final code in rawCodes)
                if (isVaccineAllowedToShow(
                  vaccineCode: code,
                  allVaccineCodes: allVaccineCodes,
                ))
                  code
            ];

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
                                        final wrapper = context
                                            .read<HouseholdOverviewBloc>()
                                            .state
                                            .householdMemberWrapper;

                                        context.router.popAndPush(
                                          BeneficiaryWrapperRoute(
                                              wrapper: wrapper),
                                        );
                                      },
                                      child: Text(
                                        localizations.translate(
                                            i18.common.corecommonclose),
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
