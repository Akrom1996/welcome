import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/numbers.dart';
import '../utils/styles.dart';

class CustomCard extends StatelessWidget {

  final image;
  final title;
  final subTitle;

  const CustomCard({Key? key,required this.image,required this.title,required this.subTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 130,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomNumbers.inputBorderRadius),color: CustomColors.kBtnBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(
                CustomNumbers.inputBorderRadius),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: CustomStyles.kHeadingStyle
                      .copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  subTitle,
                  style: CustomStyles.kHeadingStyle
                      .copyWith(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
