import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'custom_decoration.dart';
import 'custom_text.dart';

class CustomButtons extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Function onTap;
  const CustomButtons(
      {super.key, required this.onTap, required this.title, required this.color, required this.fontWeight, required this.fontSize,});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [AppColors.secondary.withOpacity(0.9), AppColors.secondary],
          ),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 1,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: CustomText(
            title: title,
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize),
      ),
    );
  }
}