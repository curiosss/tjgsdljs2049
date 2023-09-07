import 'package:flutter/material.dart';
import 'package:hotel/common/valitors/k_form_validator.dart';
import 'package:hotel/common/valitors/validators.dart';
import 'package:hotel/common/widgets/k_textfield.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';
import 'package:hotel/features/hotel/presentation/ui_models/tourist_form_model.dart';
import 'package:hotel/features/hotel/presentation/widgets/date_picker_field.dart';

class TouristWidget extends StatefulWidget {
  final TouristFormModel touristFormModel;
  const TouristWidget({
    super.key,
    required this.touristFormModel,
  });

  @override
  State<TouristWidget> createState() => _TouristWidgetState();
}

class _TouristWidgetState extends State<TouristWidget> {
  KFormValidator kFormValidator = KFormValidator();
  ExpansionTileController expansionTileController = ExpansionTileController();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController surnameCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController residenceCtrl = TextEditingController();
  TextEditingController passportCtrl = TextEditingController();
  TextEditingController passportExpiretrl = TextEditingController();

  @override
  void initState() {
    widget.touristFormModel.validate = validate;
    super.initState();
  }

  bool validate() {
    if (kFormValidator.validate()) {
      widget.touristFormModel.name = nameCtrl.text;
      widget.touristFormModel.surname = surnameCtrl.text;
      // widget.touristFormModel.dob = dobCtrl.text;
      widget.touristFormModel.residence = residenceCtrl.text;
      widget.touristFormModel.passport = passportCtrl.text;
      // widget.touristFormModel.passportExpire = passportExpiretrl.text;
      return true;
    } else if (!isExpanded) {
      expansionTileController.expand();
    }
    return false;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    surnameCtrl.dispose();
    dobCtrl.dispose();
    residenceCtrl.dispose();
    passportCtrl.dispose();
    passportExpiretrl.dispose();
    super.dispose();
  }

  bool isExpanded = true;
  onExpansionChanged(value) {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.midMargin),
        color: Colors.white,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          controller: expansionTileController,
          initiallyExpanded: isExpanded,
          maintainState: true,
          textColor: Colors.black,
          collapsedTextColor: Colors.black,
          onExpansionChanged: onExpansionChanged,
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 1,
            duration: const Duration(
              milliseconds: 300,
            ),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColors.blueOpacity10,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.blue,
              ),
            ),
          ),
          title: Text(
            widget.touristFormModel.title,
            style: TextStyles.big,
          ),
          childrenPadding: const EdgeInsets.all(Dimens.midMargin),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: KTextField(
                textEditingController: nameCtrl,
                label: 'Имя',
                validator: fieldIsRequired,
                kFormValidator: kFormValidator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: KTextField(
                textEditingController: surnameCtrl,
                label: 'Фамилия',
                validator: fieldIsRequired,
                kFormValidator: kFormValidator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: DatePickerField(
                label: 'Дата рождения',
                kFormValidator: kFormValidator,
                textEditingController: dobCtrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: KTextField(
                textEditingController: residenceCtrl,
                label: 'Гражданство',
                validator: fieldIsRequired,
                kFormValidator: kFormValidator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: KTextField(
                textEditingController: passportCtrl,
                label: 'Номер загранпаспорта',
                validator: fieldIsRequired,
                kFormValidator: kFormValidator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: DatePickerField(
                label: 'Срок действия загранпаспорта',
                kFormValidator: kFormValidator,
                textEditingController: passportExpiretrl,
                lastDate: DateTime.now().add(const Duration(days: 10000)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
