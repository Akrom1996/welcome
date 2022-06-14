import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/numbers.dart';
import '../utils/paddings.dart';
import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback press;
  final String text;

  const CustomButton({Key? key, required this.press, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              horizontal: CustomPadding.kDefaultPadding, vertical: 8),
          decoration: BoxDecoration(
              color: CustomColors.kBtnActiveColor,
              borderRadius:
                  BorderRadius.circular(CustomNumbers.inputBorderRadius)),
          child: Text(
           text,
            style: CustomStyles.kHeadingStyle
                .copyWith(color: Colors.white, fontSize: 14),
          ),
        ));
  }
}
