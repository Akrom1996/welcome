// To parse this JSON data, do
//
//     final registrationSuccess = registrationSuccessFromJson(jsonString);

import 'dart:convert';

import 'errors_model.dart';

RegistrationSuccess registrationSuccessFromJson(String str) =>
    RegistrationSuccess.fromJson(json.decode(str));

class RegistrationSuccess {
  RegistrationSuccess({
    required this.data,
    required this.status,
    this.errors,
  });

  Data data;
  String status;
  Errors? errors;

  factory RegistrationSuccess.fromJson(Map<String, dynamic> json) =>
      RegistrationSuccess(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );
}

class Data {
  Data({
    required this.requestId,
  });

  String requestId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestId: json["requestId"],
      );
}
