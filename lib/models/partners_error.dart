// To parse this JSON data, do
//
//     final partnersError = partnersErrorFromJson(jsonString);

import 'dart:convert';

import 'errors_model.dart';

PartnersError partnersErrorFromJson(String str) =>
    PartnersError.fromJson(json.decode(str));

class PartnersError {
  PartnersError({
    required this.status,
    required this.message,
    this.errors,
  });

  String status;
  String message;
  Errors? errors;

  factory PartnersError.fromJson(Map<String, dynamic> json) => PartnersError(
        status: json["status"],
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );
}
