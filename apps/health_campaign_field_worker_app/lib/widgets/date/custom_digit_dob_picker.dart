import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
import '../../../utils/date_utils.dart' as date_utils_local;
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../localized.dart';
import '../../utils/i18_key_constants.dart' as i18_local;

class CustomDigitDobPicker extends LocalizedStatefulWidget {
  final String datePickerFormControl;
  final bool readOnly;
  final bool isHeadOfHousehold; // <-- Add this
  final ControlValueAccessor? valueAccessor;
  final String datePickerLabel;
  final String ageFieldLabel;
  final String yearsHintLabel;
  final String monthsHintLabel;
  final String separatorLabel;
  final String? initialValue;
  final String yearsAndMonthsErrMsg;
  final String cancelText;
  final String confirmText;
  final String? errorMessage;
  final String? ageErrorMessage;
  final String? monthErrorMessage;
  final DateTime? initialDate;
  final String? requiredErrMsg;
  final void Function(DateTime?)? onChangeOfFormControl;

  const CustomDigitDobPicker({
    super.key,
    super.appLocalizations,
    required this.datePickerFormControl,
    this.readOnly = false,
    this.isHeadOfHousehold = false, // <-- Add this
    this.valueAccessor,
    required this.datePickerLabel,
    required this.ageFieldLabel,
    required this.yearsHintLabel,
    required this.monthsHintLabel,
    required this.separatorLabel,
    this.initialDate,
    required this.yearsAndMonthsErrMsg,
    this.initialValue,
    this.ageErrorMessage,
    this.errorMessage,
    this.monthErrorMessage,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.requiredErrMsg,
    this.onChangeOfFormControl,
  });

  @override
  State<CustomDigitDobPicker> createState() => _DigitDobPickerState();
}

class _DigitDobPickerState extends LocalizedState<CustomDigitDobPicker> {
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  DateTime? selectedDate;
  // late RegistrationDeliveryLocalization _localizations;
  // RegistrationDeliveryLocalization get localizations => _localizations;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedDate = DigitDateUtils.getFormattedDateToDateTime(
          widget.initialValue.toString());
      _setAgeFromDate(selectedDate);
    }
    // Initialize controllers from form if possible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final form = ReactiveForm.of(context) as FormGroup?;
      final dob =
          form?.control(widget.datePickerFormControl).value as DateTime?;
      if (dob != null) _setAgeFromDate(dob);
    });
  }

  void _setAgeFromDate(DateTime? date) {
    if (date == null) return;
    final now = DateTime.now();
    int years = now.year - date.year;
    int months = now.month - date.month;
    int days = now.day - date.day;

    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, now.day).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    setState(() {
      yearController.text = years.toString();
      monthController.text = months.toString();
    });
  }

  DateTime _getDateFromAge() {
    int years =
        widget.isHeadOfHousehold ? int.tryParse(yearController.text) ?? 0 : 0;
    int months = int.tryParse(monthController.text) ?? 0;
    DateTime now = DateTime.now();
    // If months > 11, convert to years+months
    if (!widget.isHeadOfHousehold && months > 11) {
      years += months ~/ 12;
      months = months % 12;
    }
    if (widget.isHeadOfHousehold && months > 11) {
      Toast.showToast(context,
          type: ToastType.error,
          message: localizations
              .translate(i18_local.householdDetails.monthsValidationErrorMsg));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        monthController.text = '';
        // Clear selectedDate here
        setState(() {
          selectedDate = null;
        });
        _updateFormControl(null); // Also clear the form control
      });
    }

    return date_utils_local.DigitDateUtils.subtractYearMonths(
        now, years, months);
  }

  void _updateFormControl(DateTime? dob) {
    final form = ReactiveForm.of(context) as FormGroup?;
    if (form != null) {
      form.control(widget.datePickerFormControl).value = dob;
    }
    if (widget.onChangeOfFormControl != null) {
      widget.onChangeOfFormControl!(dob);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DigitCard(
          borderColor:
              widget.errorMessage != null ? theme.colorTheme.alert.error : null,
          cardType: CardType.secondary,
          children: [
            Column(
              children: [
                LabeledField(
                  label: widget.datePickerLabel,
                  child: DigitDateFormInput(
                    readOnly: widget.readOnly,
                    editable: false,
                    initialValue: selectedDate != null
                        ? DateFormat('dd MMM yyyy').format(selectedDate!)
                        : '',
                    firstDate: widget.initialDate,
                    cancelText: widget.cancelText,
                    confirmText: widget.confirmText,
                    lastDate: DateTime.now(),
                    onChange: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          selectedDate = DateFormat('dd/MM/yyyy').parse(value);
                          _setAgeFromDate(selectedDate);
                        });
                        _updateFormControl(selectedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.separatorLabel,
                  style: theme.textTheme.bodyLarge,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: LabeledField(
                        labelInline: false,
                        label: widget.ageFieldLabel,
                        child: DigitTextFormInput(
                          errorMessage: widget.ageErrorMessage,
                          prefixTextStyle: textTheme.bodyS.copyWith(
                            color: theme.colorTheme.text.secondary,
                          ),
                          prefixText: widget.yearsHintLabel,
                          maxLength: 3,
                          controller: yearController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            setState(() {
                              selectedDate = _getDateFromAge();
                            });
                            _updateFormControl(selectedDate);
                          },
                          keyboardType: TextInputType.number,
                          readOnly:
                              widget.readOnly || !widget.isHeadOfHousehold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LabeledField(
                        labelInline: false,
                        label: '',
                        child: DigitTextFormInput(
                          errorMessage: widget.monthErrorMessage,
                          prefixTextStyle: textTheme.bodyS.copyWith(
                            color: theme.colorTheme.text.secondary,
                          ),
                          // prefixText: widget.monthsHintLabel,
                          prefixText: localizations.translate(
                              i18_local.individualDetails.monthsHintText),
                          maxLength: 3,
                          controller: monthController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            setState(() {
                              selectedDate = _getDateFromAge();
                            });
                            _updateFormControl(selectedDate);
                          },
                          keyboardType: TextInputType.number,
                          readOnly: widget.readOnly,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spacer3),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    final control = form.control('dob');
                    if (control.hasError('required') && control.touched) {
                      return Text(
                        widget.requiredErrMsg ??
                            'Required field cannot be empty',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorTheme.alert.error,
                        ),
                      );
                    }
                    if (control.hasError('ageLimit')) {
                      return Text(
                        localizations.translate(
                            i18_local.householdDetails.ageValidationErrorMsg),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorTheme.alert.error,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
