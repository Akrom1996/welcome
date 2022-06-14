import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../utils/numbers.dart';
import '../utils/paddings.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key,required this.press}) : super(key: key);
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: CustomPadding.kBackBtnPadding,top: 8),
      width: 40,
      height: 40,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.kBtnBackgroundColor,
        borderRadius:
        BorderRadius.circular(CustomNumbers.backBtnBorderRadius),),
      child: SvgPicture.asset("assets/svg/arrow-left.svg",width: 24,height: 24,),
    ),);
  }
}
