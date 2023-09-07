String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String phoneNumberPattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

String? fieldIsRequired(String? val) {
  if (val == null || val.isEmpty) {
    return 'Необходимо заполнить';
  }
  return null;
}

String? fieldIsEmail(String? val) {
  if (val == null || val.isEmpty) {
    return 'Необходимо заполнить';
  }
  if (!RegExp(emailPattern).hasMatch(val)) {
    return 'Почта введена некорректно';
  }
  return null;
}

String? fieldIsPhone(String? val) {
  if (val == null || val.isEmpty) {
    return 'Необходимо заполнить';
  }
  if (val.length < 15) {
    return 'Номер телефона введена некорректно';
  }
  // print(val);
  // if (val.length > 16 ||
  //     val.length < 9 ||
  //     !RegExp(phoneNumberPattern).hasMatch(val)) {
  //   return 'Номер телефона введена некорректно';
  // }
  return null;
}

String? fieldIsDate(String? val) {
  if (val == null || val.isEmpty) {
    return 'Необходимо заполнить';
  }
  // if (val.length > 9) {
  //   int? day = int.tryParse(val.substring(0, 2));
  //   int? month = int.tryParse(val.substring(3, 5));
  //   if(day!=null && day<32)
  //   return 'Неправильная дата';
  // }
  return null;
}
