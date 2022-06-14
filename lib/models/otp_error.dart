// To parse this JSON data, do
//
//     final otpError = otpErrorFromJson(jsonString);

import 'dart:convert';

import 'package:click_app/models/errors_model.dart';

OtpError otpErrorFromJson(String str) => OtpError.fromJson(json.decode(str));


class OtpError {
  OtpError({
    required this.status,
    required this.message,
    this.errors,
  });

  String status;
  String message;
  Errors? errors;

  factory OtpError.fromJson(Map<String, dynamic> json) => OtpError(
    status: json["status"],
    message: json["message"],
    errors: json["errors"]==null?null: Errors.fromJson(json["errors"]),
  );
}


