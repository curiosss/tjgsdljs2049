import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/common/valitors/k_form_validator.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

class KTextField extends StatefulWidget {
  final KFormValidator? kFormValidator;
  final String? label;
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? prefixText;
  final Function()? onTap;
  const KTextField({
    super.key,
    this.kFormValidator,
    required this.textEditingController,
    this.label,
    this.textInputType,
    this.validator,
    this.inputFormatters,
    this.hintText,
    this.prefixText,
    this.onTap,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  String? errorText;

  bool onValidate(String? val) {
    if (widget.validator == null) {
      return true;
    }
    setState(() {
      errorText = widget.validator!(val);
    });
    return errorText == null;
  }

  bool validate() {
    return onValidate(widget.textEditingController.text);
  }

  UniqueKey key = UniqueKey();
  @override
  void initState() {
    widget.kFormValidator?.addFieldValidator(KFieldValidator(
      uniqueKey: key,
      validationFunc: validate,
    ));
    super.initState();
  }

  @override
  void dispose() {
    widget.kFormValidator?.removeFieldValidator(key);
    super.dispose();
  }

  onTap() async {
    await widget.onTap!();
    validate();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: widget.textEditingController,
      keyboardType: widget.textInputType,
      style: TextStyles.regular,
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: onValidate,
      onTap: widget.onTap != null ? onTap : null,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.only(
          top: 24,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        filled: true,
        fillColor:
            errorText != null ? AppColors.errorColor : AppColors.scaffoldBack,
        labelText: widget.label,
        labelStyle: const TextStyle(
          height: 5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorText: errorText,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
