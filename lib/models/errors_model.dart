class Errors {
  Errors({
    this.additionalProp1,
    this.additionalProp2,
    this.additionalProp3,
  });

  String? additionalProp1;
  String? additionalProp2;
  String? additionalProp3;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    additionalProp1: json["additionalProp1"],
    additionalProp2: json["additionalProp2"],
    additionalProp3: json["additionalProp3"],
  );

}