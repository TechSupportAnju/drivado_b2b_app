import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomViewCompanyWidget extends StatelessWidget {
final String title;
final String icon;
final Function onPress;
final int isSelect;
final int index;
const CustomViewCompanyWidget(
{super.key, required this.title, required this.icon, required this.onPress, required this.isSelect, required this.index});
@override
Widget build(BuildContext context) {
return  GestureDetector(
  behavior: HitTestBehavior.translucent,
  onTap: () {
    onPress();
  },
  child: Column(
    children: [
      Container(
          height: 24,
          width: 24,
          decoration: CustomDecorations().baseBackgroundDecoration(4.0, 1.0, isSelect == index ? AppColors.secondary : Colors.transparent, isSelect == index ? Colors.transparent : Color(0xFFEDF1F3)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(icon, color: isSelect == index ? Colors.white : AppColors.arrowColor,),
          )),
      SizedBox(height: 5,),
      CustomText(title: title, fontWeight: FontWeight.w500, fontSize: 8, color: isSelect == index ? AppColors.secondary : Colors.black,)
    ],
  ),
);
  }
}