import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingSummaryDetailWidget extends StatelessWidget {
  final bool isTapOneway;
  final String travelDate;
  final String travelTime;
  final String source;
  final String destination;
  final String vehicleType;
  final String passengerLabel;
  final String distance;
  final String duration;
  final String amount;
  final String currency;
  const BookingSummaryDetailWidget({
    required this.isTapOneway,
    required this.travelDate,
    required this.travelTime,
    required this.source,
    required this.destination,
    required this.vehicleType,
    required this.passengerLabel,
    required this.distance,
    required this.duration,
    required this.amount,
    required this.currency,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final safeSource = source.trim().isEmpty ? 'Not found' : source.trim();
    final safeDestination =
        destination.trim().isEmpty ? 'Not found' : destination.trim();
    int totalSourLength = _calculateNumberOfLines(source,
    GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 14),
    screenWidth / 1.28);
    int totalDestLength = _calculateNumberOfLines(destination,
    GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 14),
    screenWidth / 1.28,);
    double totalLength = double.parse('$totalSourLength') + double.parse('$totalDestLength');
    print('totalLength');
    print(totalLength);
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
        padding: const EdgeInsets.all(12),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
            title: 'Booking Details',
            color: Color(0xFF0D0D0D),
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/booking_summary/calendar_icon.svg',
                        color: const Color(0xFF606060),
                        height: 14,width: 14,
                      ),
                      const SizedBox(width: 2),
                      CustomText(
                        title: travelDate,
                        color: const Color(0xFF606060),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.42,
                      ),
                      const SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/booking_summary/clock_icon.svg',
                        color: const Color(0xFF606060),
                        height: 14, width: 14,
                      ),
                      const SizedBox(width: 2),
                      CustomText(
                        title: travelTime,
                        color: const Color(0xFF606060),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.42,
                      ),
                    ],
                  )
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                  color:  Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      CustomText(
                        title: amount,
                        color: Color(0xFF606060),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: -0.42,
                        height: 1,
                      ),
                      
                      CustomText(
                        title: currency ,
                        color: Color(0xFFFB4156),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.42,
                        height: 1,
                      ),
                    ],
                  )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: true,
                          indicatorStyle:  IndicatorStyle(
                            width: 16,
                            height: 16,
                            indicator: SvgPicture.asset(
                              'assets/booking_summary/from_icon.svg', 
                              height: 16,
                            ),
                          ),
                          afterLineStyle:  LineStyle(
                            color: isTapOneway?  Color(0xFF606060) : Colors.transparent,
                            thickness: 1.5,
            
                          ),
                          beforeLineStyle:  LineStyle(
                            color: isTapOneway?  Color(0xFF606060) : Colors.transparent,
                            thickness: 1.5,
            
                          ),
                          endChild: ListTile(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                      title: safeSource,
                                      height: 1.33,
                                      color: Color(0xFF606060),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      isTapOneway? 
                      TimelineTile(
                        alignment: TimelineAlign.start,
                        indicatorStyle:  IndicatorStyle(
                          width: 16,
                          height: 16,
                          indicator: Center(
                            child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: 23,
                              lineThickness: 1.5,
                              dashLength: 5.0,
                              dashColor:   isTapOneway?  Colors.transparent: Colors.transparent,
                              dashRadius: 0.0,
                              dashGapLength: 0.0,
                              dashGapColor:    isTapOneway?  Colors.transparent : Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                          ) , 
                        ),
                        beforeLineStyle:  LineStyle(
                          color:   isTapOneway? Color(0xFF606060) : Colors.transparent  ,
                          thickness: 1.5,
                        ) ,
                        afterLineStyle: isTapOneway
                            ? LineStyle(
                          color:   isTapOneway? Color(0xFF606060) : Colors.transparent ,
                          thickness: 1.5,
                        ) : null,
                        // endChild: SizedBox(height: 20),
                        endChild: Padding(
                          padding:  EdgeInsets.only( top: totalSourLength.toDouble() == 1.0 ? 0 : totalSourLength * 8,
                            bottom: totalDestLength.toDouble() == 1.0 ? 0 : totalDestLength * 5
                          ),
                          
                        )
                      ) : Container(),
                      isTapOneway? 
                      TimelineTile(
                        alignment: TimelineAlign.start,
                        isLast: true,
                        indicatorStyle:IndicatorStyle(
                          width: 16,
                          height: 16,
                          indicator: SvgPicture.asset('assets/booking_summary/to_icon.svg', height: 16)
                        ),
                        beforeLineStyle: const LineStyle(
                          color: Color(0xFF606060),
                          thickness: 1.5,
                        ),
                        afterLineStyle: const LineStyle(
                          color: Color(0xFF606060),
                          thickness: 1.5,
                        ),
                        endChild: isTapOneway ?
                        ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        title: isTapOneway? safeDestination : "",
                                        height: 1.33,
                                        color: Color(0xFF606060),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                       
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ) : Container(),
                      ) : Container(),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20,),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                            color: Color(0xFFF5F6FA)  ,
                            borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 0),
                            alignment: Alignment.center,
                            child: CustomText(
                              title: vehicleType,
                              color: Color(0xFF606060),
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                            )
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                            color: Color(0xFFF5F6FA),
                            borderRadius:
                            BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                CustomText(
                                  title: passengerLabel,
                                  color: Color(0xFF606060),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),
                              ],
                            )
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                            color: Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                CustomText(
                                  title: distance,
                                  color: Color(0xFF606060),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),
                                const CustomText(
                                  title: ' | ',
                                  color: Color(0xFF606060),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12
                                ),
                                CustomText(
                                  title: duration,
                                  color: Color(0xFF606060),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                )
              ],
            )
          ]
        ),
      ),
    );
  }
  int _calculateNumberOfLines(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length;
  }
}