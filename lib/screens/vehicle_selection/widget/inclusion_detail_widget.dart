import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InclusionDetailWidget extends StatelessWidget {
  const InclusionDetailWidget({super.key});

  void _onClose(BuildContext context) {
    Navigator.pop(context); // Example action
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Container(
      height: screenHeight * 0.45,
      width: screenWidth ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/vehicle/cross.svg",
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,
                    color: Colors.transparent,
                  ),
                  const CustomText(title: "Details", color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                  GestureDetector(
                    onTap: () {
                      _onClose(context);
                    },
                    child: SvgPicture.asset(
                      "assets/vehicle/cross.svg",
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),
            ),
            InclusionPopUp(title: "Free 60 minutes waiting time after flight landing for airport pickups, 15 minutes waiting time for all other pickups.", screenHeight: screenHeight),
            InclusionPopUp(title: "Free cancellation upto 24 hour prior to time for both oneway transfer and hourly disposals.", screenHeight: screenHeight,),
            InclusionPopUp(title: "Flight No./Train No. is mandatory for airport /station pickup and dropoff.", screenHeight: screenHeight),
            InclusionPopUp(title: "Guest/luggage capacities must be abided by for safety reasons. If you are unsure, select a larger class as chauffeurs may turn down service when they are exceeded.", screenHeight: screenHeight,),
            InclusionPopUp(title: "The vehicle images are just for reference, you may get a different vehicle of similar quality depending on destination.", screenHeight: screenHeight),
            InclusionPopUp(title: "All prices include VAT, Gratuities, Meet and Greet services.", screenHeight: screenHeight),
          ],
        ),
      ),
    );
  }
}

class InclusionPopUp extends StatelessWidget {
  const InclusionPopUp({
    super.key,
    required this.title,
    this.screenHeight,
  });
  final double? screenHeight;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SvgPicture.asset(
              "assets/vehicle/inclusion_tick_icon.svg",
              height: screenHeight! * 0.024,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(title ?? "",
              maxLines: 4,
              style: GoogleFonts.plusJakartaSans(
                color:  Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

