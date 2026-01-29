import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget maxDataTab(String imageIcon, String label) {
  return Container(
    padding: const EdgeInsets.only(left: 2, right: 5, bottom: 2, top: 2),
    decoration: ShapeDecoration(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          imageIcon,
          height: 20,
          width: 20,
          fit: BoxFit.fill,
          placeholderBuilder: (BuildContext context) => const Icon(
            Icons.error_outline,
            size: 16,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Text(label,
            style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF1A2126),
                fontWeight: FontWeight.w600,
                fontSize: 12
            ),
          ),
        ),
      ],
    ),
  );
}