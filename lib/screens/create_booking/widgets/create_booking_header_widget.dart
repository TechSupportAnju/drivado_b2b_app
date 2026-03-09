import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'greeting_widget.dart';

class CreateBookingHeaderWidget extends StatelessWidget {
  const CreateBookingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xff190C0C),
        image: DecorationImage(
          image: AssetImage('assets/create_booking/mask.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 40),
      child: Row(
        children: [
          GreetingWidget(),
          const Spacer(),
          notificationWidget()
        ],
      ),
    );
  }
}