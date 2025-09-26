import '../../../router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_components/widgets/digit_elevated_button.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart'
    as i18_local;
import 'package:digit_data_model/data_model.dart';
import 'package:health_campaign_field_worker_app/blocs/localization/app_localization.dart';

import '../../../widgets/custom_back_navigation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:digit_components/widgets/digit_checkbox_tile.dart';

@RoutePage()
class ReasonsForNonVaccinationPage extends StatefulWidget {
  final String projectBeneficiaryClientReferenceId;
  final IndividualModel? individual;
  final List<String> selectedYesCodes;
  final List<String> selectedNoCodes;
  final TaskModel task;

  const ReasonsForNonVaccinationPage({
    super.key,
    required this.projectBeneficiaryClientReferenceId,
    required this.individual,
    required this.selectedYesCodes,
    required this.selectedNoCodes,
    required this.task,
  });

  @override
  State<ReasonsForNonVaccinationPage> createState() =>
      _ReasonsForNonVaccinationPageState();
}

enum NonVaccinationReason {
  stockOut,
  facilityFar,
  forgotAppointment,
  caregiverBusy,
  priorAefi,
  noTransportMoney,
  badStaffAttitude,
  facilityClosed,
  notImportantToCaregiver,
  rumorsMisinformation,
  hardToAccessArea,
  refugeeOrIdp,
  indigenousStigma,
  other,
}

const List<NonVaccinationReason> reasonsOrder = [
  NonVaccinationReason.stockOut,
  NonVaccinationReason.facilityFar,
  NonVaccinationReason.forgotAppointment,
  NonVaccinationReason.caregiverBusy,
  NonVaccinationReason.priorAefi,
  NonVaccinationReason.noTransportMoney,
  NonVaccinationReason.badStaffAttitude,
  NonVaccinationReason.facilityClosed,
  NonVaccinationReason.notImportantToCaregiver,
  NonVaccinationReason.rumorsMisinformation,
  NonVaccinationReason.hardToAccessArea,
  NonVaccinationReason.refugeeOrIdp,
  NonVaccinationReason.indigenousStigma,
  NonVaccinationReason.other,
];

class _ReasonsForNonVaccinationPageState
    extends State<ReasonsForNonVaccinationPage> {
  final Set<NonVaccinationReason> _selectedReasons = {};
  final _otherCtrl = TextEditingController();

  @override
  void dispose() {
    _otherCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: ScrollableContent(
        header: const CustomBackNavigationHelpHeaderWidget(showHelp: false),
        enableFixedDigitButton: true,
        footer: SafeArea(
          top: false,
          child: DigitCard(
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            children: [
              DigitElevatedButton(
                onPressed: () {
                  // 1) Page-level validations
                  if (_selectedReasons.isEmpty) {
                    DigitToast.show(
                      context,
                      options: DigitToastOptions(
                        l.translate(i18_local.zeroDose.enterReason),
                        true,
                        Theme.of(context),
                      ),
                    );
                    return;
                  }

                  if (_selectedReasons.contains(NonVaccinationReason.other) &&
                      _otherCtrl.text.trim().isEmpty) {
                    DigitToast.show(
                      context,
                      options: DigitToastOptions(
                        l.translate(i18_local.zeroDose.reasonEnterOther),
                        true,
                        Theme.of(context),
                      ),
                    );
                    return;
                  }

                  final deliverBloc = context.read<DeliverInterventionBloc>();
                  final baseTask0 = deliverBloc.state.oldTask ?? widget.task;

                  final String ensuredClientId =
                      (baseTask0.clientReferenceId?.trim().isNotEmpty ?? false)
                          ? baseTask0.clientReferenceId!.trim()
                          : IdGen.i.identifier;

                  final taskToPass =
                      baseTask0.copyWith(clientReferenceId: ensuredClientId);

                  if (taskToPass.clientReferenceId?.trim().isEmpty ?? true) {
                    DigitToast.show(
                      context,
                      options: DigitToastOptions(
                        AppLocalizations.of(context)
                            .translate('Missing task id — cannot continue.'),
                        true,
                        Theme.of(context),
                      ),
                    );
                    return;
                  }

                  if (widget.projectBeneficiaryClientReferenceId
                      .trim()
                      .isEmpty) {
                    DigitToast.show(
                      context,
                      options: DigitToastOptions(
                        AppLocalizations.of(context)
                            .translate('Missing beneficiary ID.'),
                        true,
                        Theme.of(context),
                      ),
                    );
                    return;
                  }

                  context.router.push(
                    ComplaintCaptureRoute(
                      projectBeneficiaryClientReferenceId:
                          widget.projectBeneficiaryClientReferenceId,
                      individual: widget.individual,
                      selectedYesCodes: widget.selectedYesCodes,
                      selectedNoCodes: widget.selectedNoCodes,
                      reasonCode: _selectedReasons.map((r) => r.name).join(','),
                      reasonOther:
                          _selectedReasons.contains(NonVaccinationReason.other)
                              ? _otherCtrl.text.trim()
                              : null,
                      task: taskToPass,
                    ),
                  );
                },
                child: Text(l.translate(i18_local.common.coreCommonNext)),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.translate(i18_local.zeroDose.reasonsTitle),
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  l.translate(i18_local.zeroDose.reasonsSubtitle),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // Reasons (with vertical spacing)
                ...reasonsOrder.map((r) {
                  final labelKey = {
                    NonVaccinationReason.stockOut:
                        i18_local.zeroDose.reasonStockOut,
                    NonVaccinationReason.facilityFar:
                        i18_local.zeroDose.reasonFacilityFar,
                    NonVaccinationReason.forgotAppointment:
                        i18_local.zeroDose.reasonForgotAppointment,
                    NonVaccinationReason.caregiverBusy:
                        i18_local.zeroDose.reasonCaregiverBusy,
                    NonVaccinationReason.priorAefi:
                        i18_local.zeroDose.reasonPriorAefi,
                    NonVaccinationReason.noTransportMoney:
                        i18_local.zeroDose.reasonNoTransportMoney,
                    NonVaccinationReason.badStaffAttitude:
                        i18_local.zeroDose.reasonBadStaffAttitude,
                    NonVaccinationReason.facilityClosed:
                        i18_local.zeroDose.reasonFacilityClosed,
                    NonVaccinationReason.notImportantToCaregiver:
                        i18_local.zeroDose.reasonNotImportantToCaregiver,
                    NonVaccinationReason.rumorsMisinformation:
                        i18_local.zeroDose.reasonRumorsMisinformation,
                    NonVaccinationReason.hardToAccessArea:
                        i18_local.zeroDose.reasonHardToAccessArea,
                    NonVaccinationReason.refugeeOrIdp:
                        i18_local.zeroDose.reasonRefugeeOrIdp,
                    NonVaccinationReason.indigenousStigma:
                        i18_local.zeroDose.reasonIndigenousStigma,
                    NonVaccinationReason.other: i18_local.zeroDose.reasonOther,
                  }[r]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DigitCheckboxTile(
                      value: _selectedReasons.contains(r),
                      label: l.translate(labelKey),
                      onChanged: (checked) {
                        setState(() {
                          if (checked == true) {
                            _selectedReasons.add(r);
                          } else {
                            _selectedReasons.remove(r);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),

                // "Other" details
                if (_selectedReasons.contains(NonVaccinationReason.other)) ...[
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: l.translate(i18_local.zeroDose.reasonsOtherLabel),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ],
                    ),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _otherCtrl,
                    minLines: 4,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: l.translate(
                          i18_local.zeroDose.reasonsOtherPlaceholder),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.colorScheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                    ),
                  ),
                ],

                // Extra bottom space so the fixed footer doesn't overlap
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
