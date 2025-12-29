import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double? letterSpacing;
  final double? height;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextDecoration? textDecoration;
  const CustomText(
      {super.key, required this.title, this.maxLine, required this.color, required this.fontWeight, required this.fontSize, this.letterSpacing, this.height, this.overflow, this.textAlign, this.textDecoration});
  @override
  Widget build(BuildContext context) {
    return  Text(title, overflow: overflow,textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.plusJakartaSans(decoration: textDecoration,
          fontSize: fontSize, fontWeight: fontWeight, color: color, height: height ?? 1),);
  }
}
