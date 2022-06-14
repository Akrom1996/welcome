import 'dart:convert';

import 'package:click_app/models/mapper.dart';

class Registration extends Parser {
  String type;
  String number;
  Registration({required this.type, required this.number});
  @override
  String toJsonString() {
    return jsonEncode({"type": type, "login": number});
  }
}
