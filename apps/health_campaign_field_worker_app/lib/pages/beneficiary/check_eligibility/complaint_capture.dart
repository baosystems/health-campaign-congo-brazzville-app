import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_components/widgets/digit_elevated_button.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_dialog.dart';

import '../../../widgets/custom_back_navigation.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart'
    as i18_local;
import 'package:health_campaign_field_worker_app/blocs/localization/app_localization.dart';
import 'package:digit_data_model/data_model.dart';

import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/utils.dart';
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import '../../../utils/app_enums.dart'
    show EligibilityAssessmentType, EligibilityAssessmentStatus, ZeroDoseStatus;
import 'package:health_campaign_field_worker_app/router/app_router.dart'
    show CustomHouseholdAcknowledgementRoute;
import 'package:registration_delivery/router/registration_delivery_router.gm.dart'
    show BeneficiaryWrapperRoute;
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';

@RoutePage()
class ComplaintCapturePage extends StatefulWidget {
  final TaskModel task;
  final String projectBeneficiaryClientReferenceId;
  final IndividualModel? individual;
  final List<String> selectedYesCodes;
  final List<String> selectedNoCodes;
  final String reasonCode;
  final String? reasonOther;

  const ComplaintCapturePage({
    super.key,
    required this.projectBeneficiaryClientReferenceId,
    required this.individual,
    required this.selectedYesCodes,
    required this.selectedNoCodes,
    required this.reasonCode,
    this.reasonOther,
    required this.task,
  });

  @override
  State<ComplaintCapturePage> createState() => _ComplaintCapturePageState();
}

class _ComplaintCapturePageState extends State<ComplaintCapturePage> {
  final _complaintCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _complaintCtrl.dispose();
    super.dispose();
  }

  Future<bool> _confirmSubmit(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => DigitDialog(
        options: DigitDialogOptions(
          titleText: l.translate(i18_local.deliverIntervention.dialogTitle),
          content: Text(
            l
                .translate(i18_local.deliverIntervention.dialogContent)
                .replaceFirst('{}', ''),
          ),
          primaryAction: DigitDialogActions(
            label:
                l.translate(i18_local.checklist.checklistDialogPrimaryAction),
            action: (c) => Navigator.of(c, rootNavigator: true).pop(true),
          ),
          secondaryAction: DigitDialogActions(
            label:
                l.translate(i18_local.checklist.checklistDialogSecondaryAction),
            action: (c) => Navigator.of(c, rootNavigator: true).pop(false),
          ),
        ),
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocListener<DeliverInterventionBloc, DeliverInterventionState>(
        listenWhen: (p, n) => p != n,
        listener: (context, state) {
          if (!_submitting) return;
          if (mounted) setState(() => _submitting = false);

          context.read<HouseholdOverviewBloc>().add(
                HouseholdOverviewReloadEvent(
                  projectId: RegistrationDeliverySingleton().projectId!,
                  projectBeneficiaryType:
                      RegistrationDeliverySingleton().beneficiaryType!,
                ),
              );

          final router = context.router;
          router.popUntilRouteWithName(BeneficiaryWrapperRoute.name);
          router.push(
            CustomHouseholdAcknowledgementRoute(
              enableViewHousehold: true,
              eligibilityAssessmentType: EligibilityAssessmentType.smc,
            ),
          );
        },
        child: Scaffold(
          body: ScrollableContent(
            header: const CustomBackNavigationHelpHeaderWidget(showHelp: false),
            enableFixedDigitButton: true,
            footer: DigitCard(
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              children: [
                DigitElevatedButton(
                  onPressed: _submitting
                      ? null
                      : () async {
                          final l = AppLocalizations.of(context);
                          final theme = Theme.of(context);

                          if (_complaintCtrl.text.trim().isEmpty) {
                            DigitToast.show(
                              context,
                              options: DigitToastOptions(
                                l.translate(i18_local.zeroDose.enterReason),
                                true,
                                theme,
                              ),
                            );
                            return;
                          }

                          final boundary =
                              RegistrationDeliverySingleton().boundary;
                          if (boundary == null) {
                            DigitToast.show(
                              context,
                              options: DigitToastOptions(
                                l.translate(
                                    'Boundary missing — cannot submit.'),
                                true,
                                theme,
                              ),
                            );
                            return;
                          }

                          final deliverBloc =
                              context.read<DeliverInterventionBloc>();
                          final baseTask0 =
                              deliverBloc.state.oldTask ?? widget.task;

                          final hasId =
                              baseTask0.clientReferenceId.trim().isNotEmpty;
                          final ensuredClientId = hasId
                              ? baseTask0.clientReferenceId.trim()
                              : IdGen.i.identifier;

                          final baseTask = baseTask0.copyWith(
                              clientReferenceId: ensuredClientId);

                          if (baseTask.clientReferenceId.trim().isEmpty) {
                            DigitToast.show(
                              context,
                              options: DigitToastOptions(
                                  l.translate('Failed to prepare task id.'),
                                  true,
                                  theme),
                            );
                            return;
                          }

                          final ok = await _confirmSubmit(context);
                          if (!ok || !mounted) return;

                          final currentCycleId = context.selectedCycle?.id;

                          final merged = (baseTask.additionalFields?.fields ??
                                  const <AdditionalField>[])
                              .toList();
                          for (final f in merged) {
                            debugPrint('AF ${f.key}=${f.value}');
                          }
                          void upsert(String key, String value) {
                            final i = merged.indexWhere((f) => f.key == key);
                            if (i >= 0) {
                              merged[i] = AdditionalField(key, value);
                            } else {
                              merged.add(AdditionalField(key, value));
                            }
                          }

                          if (currentCycleId != null) {
                            upsert(
                              additional_fields_local
                                  .AdditionalFieldsType.cycleIndex
                                  .toValue(),
                              currentCycleId.toString(),
                            );
                          }

                          if (widget.selectedYesCodes.isNotEmpty) {
                            upsert(
                              additional_fields_local
                                  .AdditionalFieldsType.selectedVaccines
                                  .toValue(),
                              widget.selectedYesCodes.join('.'),
                            );
                          }
                          if (widget.selectedNoCodes.isNotEmpty) {
                            upsert(
                              additional_fields_local
                                  .AdditionalFieldsType.noSelectedVaccines
                                  .toValue(),
                              widget.selectedNoCodes.join('.'),
                            );
                          }
                          upsert('nonVaccinationReason', widget.reasonCode);
                          if ((widget.reasonOther ?? '').trim().isNotEmpty) {
                            upsert('nonVaccinationReasonOther',
                                widget.reasonOther!.trim());
                          }
                          upsert('nonVaccinationComplaint',
                              _complaintCtrl.text.trim());

                          upsert(
                            additional_fields_local
                                .AdditionalFieldsType.deliveryType
                                .toValue(),
                            EligibilityAssessmentStatus.smcDone.name,
                          );
                          upsert(
                            additional_fields_local
                                .AdditionalFieldsType.zeroDoseStatus
                                .toValue(),
                            ZeroDoseStatus.done.name,
                          );

                          final ensuredPBId = (baseTask
                                      .projectBeneficiaryClientReferenceId
                                      ?.trim()
                                      .isNotEmpty ??
                                  false)
                              ? baseTask.projectBeneficiaryClientReferenceId
                              : widget.projectBeneficiaryClientReferenceId;

                          final updated = baseTask.copyWith(
                            projectBeneficiaryClientReferenceId: ensuredPBId,
                            additionalFields: TaskAdditionalFields(
                              version: 1,
                              fields: merged,
                            ),
                          );
                          for (final f in updated.additionalFields!.fields) {
                            debugPrint('SUBMITTED ${f.key}=${f.value}');
                          }
                          setState(() => _submitting = true);
                          deliverBloc.add(
                            DeliverInterventionSubmitEvent(
                              task: updated,
                              isEditing: false,
                              boundaryModel: boundary,
                              navigateToSummary: true,
                            ),
                          );

                          context.read<HouseholdOverviewBloc>().add(
                                HouseholdOverviewReloadEvent(
                                  projectId: RegistrationDeliverySingleton()
                                      .projectId!,
                                  projectBeneficiaryType:
                                      RegistrationDeliverySingleton()
                                          .beneficiaryType!,
                                ),
                              );

                          final router = context.router;
                          router.popUntilRouteWithName(
                              BeneficiaryWrapperRoute.name);
                          router.push(
                            CustomHouseholdAcknowledgementRoute(
                              enableViewHousehold: true,
                              eligibilityAssessmentType:
                                  EligibilityAssessmentType.smc,
                            ),
                          );
                        },
                  child: Text(l.translate(i18_local.common.coreCommonSubmit)),
                ),
              ],
            ),
            children: [
              DigitCard(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                children: [
                  Text(
                    l.translate(i18_local.zeroDose.complaintTitle),
                    style: theme.textTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      text: l.translate(i18_local.zeroDose.complaintLabel),
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
                    controller: _complaintCtrl,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: l.translate(
                          i18_local.zeroDose.complaintBoxPlaceholder),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.colorScheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.translate(i18_local.zeroDose.complaintHelp),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.65),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
