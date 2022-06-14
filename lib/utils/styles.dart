import 'package:click_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'numbers.dart';

class CustomStyles {
  static TextStyle kHeadingStyle = TextStyle(
      color: CustomColors.kWhiteColor,
      fontSize: 24,
      fontWeight: FontWeight.w700);
  static TextStyle kGrayStyle = TextStyle(
      color: CustomColors.kGrayColor,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static OutlineInputBorder borderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: CustomColors.kBtnActiveColor),
      borderRadius: BorderRadius.circular(
          CustomNumbers.inputBorderRadius),);
}
