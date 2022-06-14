import 'package:flutter/material.dart';

import '../utils/paddings.dart';
import '../utils/styles.dart';
class CustomSubHeadLine extends StatelessWidget {

  final String text;

  const CustomSubHeadLine({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: CustomPadding.kDefaultPadding,right: CustomPadding.kDefaultPadding),
      child: Text(text,
          style: CustomStyles.kGrayStyle),
    );
  }
}
