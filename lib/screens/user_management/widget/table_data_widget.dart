import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDataTableRow extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String image;
  const CustomDataTableRow(
      {super.key, required this.title, required this.color, required this.fontWeight, required this.fontSize, required this.image});
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 110,
      child: Row(
          children: [
            SvgPicture.asset(image, height: 14,),
            SizedBox(width: 5,),
            CustomText(title: title, color: color, fontWeight: fontWeight, fontSize: fontSize),
            Spacer(),
            CustomText(title: ':', color: color, fontWeight: fontWeight, fontSize: fontSize),
          ]),
    );
  }
}