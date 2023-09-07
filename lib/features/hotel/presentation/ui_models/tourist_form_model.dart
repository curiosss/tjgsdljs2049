class TouristFormModel {
  String title;
  bool Function()? validate;
  String? name;
  String? surname;
  String? dob;
  String? residence;
  String? passport;
  String? passportExpire;

  TouristFormModel({
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'dob': dob,
      'residence': residence,
      'passport': passport,
      'passportExpire': passportExpire,
      // 'passportExpire': passportExpire != null
      //     ? DateFormat('YYYY-MM-dd').format(passportExpire!)
      //     : null,
    };
  }
}
