import 'package:flutter/material.dart';
import 'package:hotel/common/valitors/k_form_validator.dart';
import 'package:hotel/common/valitors/validators.dart';
import 'package:hotel/common/widgets/k_textfield.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final KFormValidator kFormValidator;
  final DateTime? lastDate;

  const DatePickerField({
    super.key,
    required this.textEditingController,
    required this.kFormValidator,
    this.label,
    this.lastDate,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  var dateMask = MaskTextInputFormatter(mask: '##.##.####');

  DateTime firstDate = DateTime(1900);

  buildDatePicker() async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: widget.lastDate ?? now,
    );
    if (date != null) {
      widget.textEditingController.text = DateFormat('dd.MM.yyyy').format(date);
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return KTextField(
      textEditingController: widget.textEditingController,
      label: widget.label,
      inputFormatters: [dateMask],
      hintText: '31.12.1977',
      textInputType: TextInputType.datetime,
      validator: fieldIsRequired,
      kFormValidator: widget.kFormValidator,
      onTap: buildDatePicker,
    );
  }
}
