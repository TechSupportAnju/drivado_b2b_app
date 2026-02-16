import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingSummaryDetailWidget extends StatefulWidget {
  final bool isTapOneway;
  const BookingSummaryDetailWidget({required this.isTapOneway ,super.key});

  @override
  State<BookingSummaryDetailWidget> createState() => _BookingSummaryDetailWidgetState();
}

class _BookingSummaryDetailWidgetState extends State<BookingSummaryDetailWidget> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var source =  widget.isTapOneway?  "Not found" :  "Not found";
    var destination = widget.isTapOneway? "destination" : "";
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
                        title: widget.isTapOneway?
                        "15/09/2025" : "15/09/2025",
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
                        title: widget.isTapOneway?
                        "10:25AM " : "10:25AM ",
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
                        title: "234.00 ",
                        color: Color(0xFF606060),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: -0.42,
                        height: 1,
                      ),
                      
                      CustomText(
                        title: "USD" ,
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
                            color: widget.isTapOneway?  Color(0xFF606060) : Colors.transparent,
                            thickness: 1.5,
            
                          ),
                          beforeLineStyle:  LineStyle(
                            color: widget.isTapOneway?  Color(0xFF606060) : Colors.transparent,
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
                                      title: "London Gatwick Airport (LGW) Horley London Heathrow Airport, London, UK",
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
                      widget.isTapOneway? 
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
                              dashColor:   widget.isTapOneway?  Colors.transparent: Colors.transparent,
                              dashRadius: 0.0,
                              dashGapLength: 0.0,
                              dashGapColor:    widget.isTapOneway?  Colors.transparent : Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                          ) , // No indicator for the middle tile
                        ),
                        beforeLineStyle:  LineStyle(
                          color:   widget.isTapOneway? Color(0xFF606060) : Colors.transparent  ,
                          thickness: 1.5,
                        ) ,
                        afterLineStyle: widget.isTapOneway
                            ? LineStyle(
                          color:   widget.isTapOneway? Color(0xFF606060) : Colors.transparent ,
                          thickness: 1.5,
                        ) : null,
                        // endChild: SizedBox(height: 20),
                        endChild: Padding(
                          padding:  EdgeInsets.only( top: totalSourLength.toDouble() == 1.0 ? 0 : totalSourLength * 8,
                            bottom: totalDestLength.toDouble() == 1.0 ? 0 : totalDestLength * 5
                          ),
                          
                        )
                      ) : Container(),
                      widget.isTapOneway? 
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
                        endChild: widget.isTapOneway ?
                        ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        title: widget.isTapOneway? "London Gatwick Airport (LGW) Horley London Heathrow Airport, London, UK" : "",
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
                              title: "Standard sedan",
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
                                  title: widget.isTapOneway? "1 Pax" :
                                  "2 Pax",
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
                                  title: widget.isTapOneway? "37 km" : "10 km",
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
                                  title: widget.isTapOneway?
                                  "2 hr 53 min" : "10 hr",
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