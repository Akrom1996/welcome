import 'package:flutter/material.dart';

import '../utils/paddings.dart';
import '../utils/styles.dart';

class CustomHeadLine extends StatelessWidget {
  const CustomHeadLine({ Key? key, required this.text}) : super(key: key);
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: CustomPadding.kDefaultPadding),
      child: Text(
        text,
        style: CustomStyles.kHeadingStyle,
      ),
    );
  }
}
