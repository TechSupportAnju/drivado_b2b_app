import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBookingSummaryDataRow extends StatelessWidget {
  final String title;
  final String desc;
  const CustomBookingSummaryDataRow(
      {super.key, required this.title, required this.desc,});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: SizedBox(
              width: 145,
              child: CustomText(title: title, color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height * 0.016)),
        ),
        SizedBox(width: 8,),
        Flexible(
          flex: 1,
          child: CustomText(title: desc, color: Color(0xFF3A434C), fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height * 0.016),
        ),
      ],
    );
  }
}
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
        Container(
          width: 110,
          child: Row(
            children: [
              SvgPicture.asset(image),
              SizedBox(width: 5,),
              CustomText(title: title, color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 12),
            ],
          ),
        ),
        CustomText(title: ":", color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 12),
        SizedBox(width: 18,),
        Expanded(
          child: CustomText(title: desc,
              height: 1.2,
              color: Color(0xFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ],
    );
  }
}