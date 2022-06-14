// To parse this JSON data, do
//
//     final partnersSuccess = partnersSuccessFromJson(jsonString);

import 'dart:convert';

import 'package:click_app/models/errors_model.dart';

PartnersSuccess partnersSuccessFromJson(String str) =>
    PartnersSuccess.fromJson(json.decode(str));

class PartnersSuccess {
  PartnersSuccess({required this.data, required this.status, this.errors});

  Data data;
  String status;
  Errors? errors;

  factory PartnersSuccess.fromJson(Map<String, dynamic> json) =>
      PartnersSuccess(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );
}

class Data {
  Data({
    required this.data,
    required this.pagesCount,
    required this.rowsCount,
  });

  List<Datum> data;
  int pagesCount;
  int rowsCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagesCount: json["pagesCount"],
        rowsCount: json["rowsCount"],
      );
}

class Datum {
  Datum({
    required this.title,
    required this.desc,
    required this.logo,
    required this.id,
  });

  String title;
  String desc;
  String logo;
  int id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        desc: json["desc"],
        logo: json["logo"],
        id: json["id"],
      );
}
