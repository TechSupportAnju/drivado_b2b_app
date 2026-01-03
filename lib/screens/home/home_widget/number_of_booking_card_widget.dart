import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NumberOfBookingCardWidget extends StatefulWidget {
  final String svgPath;
  final int count;
  final String status;
  final Color iconBgColor;
  final double iconSize;

  const NumberOfBookingCardWidget({
    super.key,
    required this.svgPath,
    required this.count,
    required this.status,
    required this.iconBgColor,
    this.iconSize = 16,
  });

  @override
  State<NumberOfBookingCardWidget> createState() => _NumberOfBookingCardWidgetState();
}

class _NumberOfBookingCardWidgetState extends State<NumberOfBookingCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.26,
      padding: const EdgeInsets.all(12),
      decoration: CustomDecorationsCards().baseBackgroundShadow(
        radius: 8,
        smooth: 1,
        color: Colors.white,
        width: 0.5,
        borderColor: Color(0XFFE6E8E7).withOpacity(0.8),
        blurRadius: 10,
        boxShadowColor: Color(0XFF606060).withOpacity(0.1),
        x: 0,
        y: 0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: widget.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                widget.svgPath,
                height: widget.iconSize,
                width: widget.iconSize,
              ),
            ),
          ),

          const SizedBox(height: 8),

          CustomText(
            title: widget.count.toString(),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1,
          ),

          const SizedBox(height: 2),

          CustomText(
            title: widget.status.toString(),
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0XFF606060),
            height: 1,
          ),
        ],
      ),
    );
  }
}

