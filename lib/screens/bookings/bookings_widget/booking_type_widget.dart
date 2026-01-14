import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BookingTypeWidget extends StatelessWidget {
  final String? bookingType;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  const BookingTypeWidget({this.bookingType, this.textColor, this.fontSize, this.fontWeight, this.height ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 72,
      //width: MediaQuery.of(context).size.width * 0.19,
      decoration: BoxDecoration(
        color: Color(0XFFF5F6FA),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Center(child: CustomText(title: bookingType ?? "N/A", color: textColor ?? Color(0XFFFB4156), fontWeight: fontWeight ?? FontWeight.w600, fontSize: fontSize ?? 12, height: height ?? 1)),
      ),
    );
  }
}

class BookingDurationWidget extends StatelessWidget {
  final String? bookingDuration;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  const BookingDurationWidget({this.bookingDuration, this.textColor, this.fontSize, this.fontWeight, this.height ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      //width: 72,
      //width: MediaQuery.of(context).size.width * 0.19,
      decoration: BoxDecoration(
        color: Color(0XFFF5F6FA),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Center(child: CustomText(title: bookingDuration ?? "N/A", color: textColor ?? Color(0XFFFB4156), fontWeight: fontWeight ?? FontWeight.w600, fontSize: fontSize ?? 12, height: height ?? 1)),
      ),
    );
  }
}