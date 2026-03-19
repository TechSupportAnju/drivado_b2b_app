import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget maxDataTab(String imageIcon, String label) {
  return Container(
    decoration: CustomDecorations().baseBackgroundDecoration(28.0, 1.0, Colors.white, Colors.white),
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
          padding: const EdgeInsets.only(right: 6),
          child: Text(label,
            style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF0D0D0D),
                fontWeight: FontWeight.w600,
                fontSize: 12
            ),
          ),
        ),
      ],
    ),
  );
}