import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBookingSummaryDataRowWithIcon extends StatelessWidget {
  final String title;
  final String image;
  final String desc;
  const CustomBookingSummaryDataRowWithIcon(
      {super.key, required this.title, required this.desc, required this.image});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: SizedBox(
            child: Row(
              children: [
                SvgPicture.asset(image),
                SizedBox(width: 5,),
                CustomText(
                  title: title, 
                  color: Color(0XFF606060), 
                  fontWeight: FontWeight.w500, 
                  fontSize: 12,
                  height: 1.0
                ),
              ],
            )
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomText(title: desc,
              height: 1.0,
              color: Color(0XFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12)
        ),
      ],
    );
  }
}