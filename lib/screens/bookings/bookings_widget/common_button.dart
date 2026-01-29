import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const CommonButtonWidget({required this.backgroundColor, required this.borderColor, required this.text, required this.textColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, backgroundColor, borderColor),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
        child: Center(
          child: CustomText(title: text, color: textColor, fontWeight: FontWeight.w500, fontSize: 16, height: 2.4)
        ),
      ),
    );
  }
}