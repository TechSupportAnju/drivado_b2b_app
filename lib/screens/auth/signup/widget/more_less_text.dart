import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class MoreLessText extends StatefulWidget {
  final String text;

  const MoreLessText({Key? key, required this.text}) : super(key: key);

  @override
  State<MoreLessText> createState() => _MoreLessTextState();
}

class _MoreLessTextState extends State<MoreLessText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: widget.text,
          height: 1.2,
          maxLine: isExpanded ? 6 : 2,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xff0d0d0d)
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: CustomText(
            title: isExpanded ? "Less" : "More",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.secondary
          ),
        ),
      ],
    );
  }
}