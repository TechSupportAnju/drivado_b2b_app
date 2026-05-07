import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CancellationPolicyWidget extends StatelessWidget {
  const CancellationPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: CustomDecorationsCards().baseBackgroundShadow(
        radius: 12.0,
        smooth: 1.0,
        color: const Color(0xFFFEFFF0),
        width: 0.50,
        borderColor: const Color(0xFFFFA800)
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      SvgPicture.asset("assets/booking/cancellation_policy_icon.svg"),
                      CustomText(
                        title: 'Cancellation Policy',
                        color: const Color(0xFFFFA800),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                Row(
                  spacing: 2,
                  children: [
                    CustomText(title: "•  Before 24 hours", color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),
                    CustomText(title: ": 100% refund of booking amount", color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),
                  ],
                ),
                Row(
                  spacing: 2,
                  children: [
                    CustomText(title: "•  Within 24 hours:", color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),
                    CustomText(title: ":  No refund available", color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}