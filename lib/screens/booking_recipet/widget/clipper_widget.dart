import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_ticket_widget.dart';
import 'oval_widget.dart';

class CustomTicket extends StatefulWidget {
  final bool isTapOneway;
  final String? countryCode;
  const CustomTicket({required this.isTapOneway, this.countryCode, super.key});

  @override
  State<CustomTicket> createState() => _CustomTicketState();
}


String formatDuration(String durationInSeconds) {
  double? seconds = double.tryParse(durationInSeconds);

  if (seconds == null || seconds < 0) {
    return 'Invalid Duration';
  }
  Duration duration = Duration(seconds: seconds.floor());

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);

  if (hours > 0 && minutes > 0) {
    return '$hours Hr $minutes min';
  } else if (hours > 0 && minutes == 0) {
    return '$hours Hr';
  } else if (hours == 0 && minutes > 0) {
    return '$minutes min';
  } else {
    return '0 min';
  }
}

double totalLength = 0.0;
class _CustomTicketState extends State<CustomTicket> {

  int _calculateNumberOfLines(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var source = fromController.text;
    var destination = toController.text;
    int totalSourLength = _calculateNumberOfLines(
      source,
      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 14),
      screenWidth / 1.28, // Subtract padding
    );
    int totalDestLength = _calculateNumberOfLines(
      destination.toString(),
      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 14),
      screenWidth / 1.28, // Subtract padding
    );
    totalLength = (double.parse('$totalSourLength') + double.parse('$totalDestLength'));
    double newHeight = 520 + totalLength * 23;
    return CTicketWidget(
      width: MediaQuery.of(context).size.width,
      height: newHeight,
      isCornerRounded: true,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ClipPath(
        clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))
            )   ),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 6.0
                  )
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:  30,right:  30, top: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: newHeight/2 + totalLength*2 - 30,
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      const CustomText(title: 'Booking Details',  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          SvgPicture.asset("assets/booking_recipet/booking_id_icon.svg"),
                          const SizedBox(width: 12,),
                          CustomText(
                            title: 'D0425-56777',
                            color: const Color(0xFF0D0D0D),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 9,),
                      customRowWidget('assets/booking_recipet/source_location.svg', source),
                      widget.isTapOneway? const SizedBox(height: 9,) : Container(),
                      widget.isTapOneway? customRowWidget('assets/booking_recipet/location_dropoff.svg', destination) : Container(),
                      const SizedBox(height: 9,),
                      customRowWidget('assets/booking_recipet/calendar.svg', "15/09/2025"),
                      const SizedBox(height: 9,),
                      customRowWidget('assets/booking_recipet/clock.svg', "9:30 AM"),
                      const SizedBox(height: 9,),
                      customRowWidget('assets/booking_recipet/booking_type_icon.svg',"Airport transfers" ),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          OvalChipGroup(
                            items: [
                              ChipSpec.text("Standard Sedan"),
                              ChipSpec.icon("2 Pax"),

                            ],
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFE6E8E7),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 16,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          title: "37 km",
                                          color: const Color(0xFF606060),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.30,

                                        ),
                                        CustomText(
                                          title: ' | ',
                                          color: const Color(0xFF606060),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.30,

                                        ),
                                        CustomText(
                                          title: "2 hr 53 min",
                                          color: const Color(0xFF606060),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.30,

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const DottedLine(),
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(height: 25,),
                    const CustomText(title: 'Passenger Details', color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                    const SizedBox(height: 15,),
                    customRowWidget('assets/booking_recipet/pax_name_icon.svg', "Sumit Modi"),
                    const SizedBox(height: 7,),
                    customRowWidget('assets/booking_recipet/pax_contact_icon.svg',  "+91 9876543210"),
                    const SizedBox(height: 7,),
                    customRowWidget('assets/booking_recipet/pax_email.svg',  "tech@drivado.com"),
                    const SizedBox(height: 7,),
                    customRowWidget('assets/booking_recipet/pax_flight_icon.svg', "EK31"),
                    const SizedBox(height: 7),
                    customRowWidget('assets/booking_recipet/pax_special_req_icon.svg', "Not found"),
                    const SizedBox(height: 15,),
                    const Divider(color: Color(0xffE6E8E7), thickness: 1,),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(title: 'Price: ', color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 20, height: 1.62,),
                        CustomText(
                            title: '2345',
                            color:  Color(0xFF0D0D0D), fontWeight: FontWeight.w700, fontSize: 20, height: 1.62),
                        CustomText(
                            title:" USD", color: AppColors.secondary, fontWeight: FontWeight.w700, fontSize: 20, height: 1.62),
                      ],
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  customRowWidget(svgImage, text) {
    return Row(
      children: [
        SvgPicture.asset('$svgImage'),
        const SizedBox(width: 12,),
        Expanded(child: CustomText(title: '${text == '' ? 'Not Found': text}',
          color: AppColors.arrowColor, fontWeight: FontWeight.w500, fontSize: 14, height: 1.2,)),
      ],
    );
  }
}

