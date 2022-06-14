import 'dart:convert';

import 'package:click_app/models/mapper.dart';

class OTPModel extends Parser {
  String? requestId;
  String? password;
  OTPModel({this.requestId, this.password});
  @override
  String toJsonString() {
    return jsonEncode({'requestId': requestId, 'password': password});
  }
}
