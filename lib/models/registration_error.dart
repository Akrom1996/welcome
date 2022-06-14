// To parse this JSON data, do
//
//     final registrationError = registrationErrorFromJson(jsonString);

import 'dart:convert';

RegistrationError registrationErrorFromJson(String str) => RegistrationError.fromJson(json.decode(str));

class RegistrationError {
  RegistrationError({
    required this.status,
    required this.message,
    this.errors,
  });

  String status;
  String message;
  Errors? errors;

  factory RegistrationError.fromJson(Map<String, dynamic> json) => RegistrationError(
    status: json["status"],
    message: json["message"],
    errors: json["errors"]==null?null: Errors.fromJson(json["errors"]),
  );
}

class Errors {
  Errors({
    required this.login,
  });

  String login;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    login: json["Login"],
  );
}
