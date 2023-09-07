import 'package:flutter/material.dart';

class KFieldValidator {
  UniqueKey uniqueKey;
  bool Function() validationFunc;

  KFieldValidator({
    required this.uniqueKey,
    required this.validationFunc,
  });
}

class KFormValidator {
  List<KFieldValidator> fieldValidations = [];

  bool validate() {
    bool isValid = true;
    for (var fieldValidation in fieldValidations) {
      if (!fieldValidation.validationFunc()) {
        isValid = false;
      }
    }
    return isValid;
  }

  addFieldValidator(KFieldValidator kFieldValidator) {
    fieldValidations.add(kFieldValidator);
  }

  removeFieldValidator(UniqueKey uniqueKey) {
    fieldValidations.removeWhere((element) => element.uniqueKey == uniqueKey);
  }
}
