import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CreditLimitWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final String value1;
  final String value2;
  const CreditLimitWidget(
      {super.key, required this.title1, required this.title2, required this.value1, required this.value2});
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 15.0, vertical: 10),
      decoration: CustomDecorations()
          .baseBackgroundDecoration(
          12.0, 1.0, Color(0xffffffff),Color(0xFFE6E8E7)),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                  title: 'Credit Limit',
                  color: Color(0xFF0D0D0D),
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              CustomText(title: title1,
                  color: Color(0xFF606060),
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
              Spacer(),
              CustomText(title: value1,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              CustomText(title: title2,
                  color: Color(0xFF606060),
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
              Spacer(),
              CustomText(title: value2,
                  color: Color(0xFF0D0D0D),
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ],
          ),
        ],
      ),
    );
  }
}