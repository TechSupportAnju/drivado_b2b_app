import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaxBookingSummary extends StatefulWidget {
  const PaxBookingSummary({super.key});

  @override
  State<PaxBookingSummary> createState() => _PaxBookingSummaryState();
}

class _PaxBookingSummaryState extends State<PaxBookingSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomDecorationsCards().baseBackgroundShadow(
        color: Colors.white,
        radius: 12,
        smooth: 1.0,
        boxShadowColor: Color(0x19000000),
        blurRadius: 4,
        x: 0,
        y: 0,
        spreadRadius: 0
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: 'Passenger Details',
              color: const Color(0xFF190C0C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset("assets/booking_summary/pax_name_icon.svg"),
                SizedBox(width: 12),
                CustomText(
                  title: "Sakshi Diwakar",
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset("assets/booking_summary/pax_contact_icon.svg"),
                SizedBox(width: 12),
                CustomText(
                  title: "+91 98765 43210",
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset("assets/booking_summary/pax_email.svg"),
                SizedBox(width: 12),
                CustomText(
                  title: "example@drivado.com",
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset("assets/booking_summary/pax_flight_icon.svg"),
                SizedBox(width: 12),
                CustomText(
                  title: "EK51",
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset("assets/booking_summary/pax_special_req_icon.svg"),
                SizedBox(width: 12),
                CustomText(
                  title: "One water bottle",
                  color: const Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}