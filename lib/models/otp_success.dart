// To parse this JSON data, do
//
//     final otpSuccess = otpSuccessFromJson(jsonString);

import 'dart:convert';

import 'errors_model.dart';

OtpSuccess otpSuccessFromJson(String str) =>
    OtpSuccess.fromJson(json.decode(str));

class OtpSuccess {
  OtpSuccess({
    required this.status,
    this.message,
    this.errors,
    required this.data,
  });

  String status;
  String? message;
  Errors? errors;
  Data data;

  factory OtpSuccess.fromJson(Map<String, dynamic> json) => OtpSuccess(
        status: json["status"],
        message: json["message"] ?? "",
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.issuedDate,
    required this.accessExpiresDate,
    required this.refreshExpiresDate,
    required this.user,
  });

  String accessToken;
  String refreshToken;
  DateTime issuedDate;
  DateTime accessExpiresDate;
  DateTime refreshExpiresDate;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        issuedDate: DateTime.parse(json["issuedDate"]),
        accessExpiresDate: DateTime.parse(json["accessExpiresDate"]),
        refreshExpiresDate: DateTime.parse(json["refreshExpiresDate"]),
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.id,
    this.lastName,
    this.firstName,
    this.middleName,
    required this.userName,
    this.birthday,
    this.gender,
    required this.phoneNumber,
    this.email,
    this.avatar,
    this.rating,
    this.roles,
  });

  int id;
  String? lastName;
  String? firstName;
  String? middleName;
  String userName;
  DateTime? birthday;
  String? gender;
  String phoneNumber;
  String? email;
  String? avatar;
  int? rating;
  List<String>? roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        lastName: json["lastName"] ?? null,
        firstName: json["firstName"] ?? null,
        middleName: json["middleName"] ?? null,
        userName: json["userName"] ?? null,
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        gender: json["gender"] ?? null,
        phoneNumber: json["phoneNumber"] ?? null,
        email: json["email"] ?? null,
        avatar: json["avatar"] ?? null,
        rating: json["rating"] ?? null,
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
      );
}
