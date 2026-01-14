import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_type_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/custom_booking_box.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/flight_detail_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

String source = 'J Hotel Tokyo Geo, 3 Chome-1-6 Nihonbashi-Honkokuchō, Nihonbashihongokuchō, Chuo City, Tokyo 103-0021, Japan';
class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    int totalSourLength = _calculateNumberOfLines(
      source,
      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 10),
      screenWidth * 0.7, // Subtract padding
    );
    int totalDestLength = _calculateNumberOfLines(
      source,
      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 10),
     screenWidth * 0.7, 
    );
    double totalLength = double.parse('$totalSourLength') + double.parse('$totalDestLength');
    print(totalLength);
    return Scaffold(
      body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/back.svg')),
                          const Spacer(),
                          const CustomText(title: 'Booking Summary', color: Color(0XF), fontWeight: FontWeight.w500, fontSize: 20),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              //_scaffoldKey.currentState!.openEndDrawer();
                            },
                          child: SvgPicture.asset('assets/menuBookingSummary.svg')),
                        ]
                    )
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                          decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0XFFE6E8E7)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: const CustomText(title: 'Booking ID', color: Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 12, height: 1.7)),
                                        ],
                                      ),
                                       const SizedBox(height: 5,),
                                       Row(
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: const CustomText(title: 'D024-15784', color: Color(0XFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 18, height: 1,)),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      //context.push('/document');
                                       //Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentPage()));
                                    },
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width * 0.3,
                                      padding: const EdgeInsets.symmetric(horizontal: 15.5),
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, Color(0XFF606060)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/booking_detail/document_icon.svg'),
                                          const SizedBox(width: 3),
                                          const CustomText(title: 'Documents', color: Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 14),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12,),
                              const Row(
                                children: [
                                  CustomText(title: 'Status: ', color:  Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 14, height: 1.7),
                                  CustomText(title: 'CONFIRMED', color: Color(0XFF28A745), fontWeight: FontWeight.w600, fontSize: 14, height: 1.7),
                                  Spacer(),
                                  CustomText(title: 'Payment: ', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14, height: 1.7),
                                  CustomText(title: 'UNPAID', color: Color(0XFF606060), fontWeight: FontWeight.w600, fontSize: 14, height: 1.7),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                          decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0XFFE6E8E7)),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.31,
                                                child: CustomText(title: 'Thu,', color: Color(0XFF606060), fontWeight: FontWeight.w700, fontSize: 14, height: 1,)),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.31,
                                                child: CustomText(title: 'Jan 18, 2024', color: Color(0XFF606060), fontWeight: FontWeight.w700, fontSize: 14, height: 1)),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.31,
                                              child:  CustomText(title: '13:25', color: Color(0XFF606060), fontWeight: FontWeight.w700, fontSize: 36, height: 1)),
                                          ],
                                        ),
                                        //isFlightTap ? const SizedBox(height: 25,) : Container()
                                      ],
                                    ),
                                    const Spacer(),
                                    FlightDetailWidget()
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12,),
                              Row(
                                children: [
                                  CustomText(title: 'Vehicle Type', color: Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 12, height: 1.7,),
                                  Spacer(),
                                  CustomText(title: 'Price', color: Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 12, height: 1.7),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                children: [
                                  CustomText(title: 'Standard Sedan'.toUpperCase(), color: Color(0XFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16, height: 1),
                                  const Spacer(),
                                  CustomText(title: 'USD 112', color: Color(0XFFFB4156), fontWeight: FontWeight.w700, fontSize: 16, height: 1,),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Column(
                                      children: [
                                        SvgPicture.asset("assets/booking_detail/source_detail_icon.svg", color: Colors.red),
                                        Dash(
                                          direction: Axis.vertical,
                                          length: totalLength * 2 + totalLength < 2 ? 40 : totalLength < 3 ? 50 : 70,
                                          dashLength: 5,
                                          dashThickness: 1.2,
                                          dashColor: Colors.grey),
                                        SvgPicture.asset("assets/booking_detail/dest_detail_icon.svg", color: Colors.red),
                                        const SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8,),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.69,
                                        child: CustomText(title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihonbashi-Honkokuchō, Nihonbashihongokuchō, Chuo City, Tokyo 103-0021, Japan", height: 1.3, color: Color(0XFF0D0D0D), fontWeight: FontWeight.w400, fontSize: 10)),
                                      const SizedBox(height: 17,),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            BookingTypeWidget(bookingType: "Oneway"),
                                            const SizedBox(width: 5,),
                                            BookingDurationWidget(bookingDuration: "37 km | 2 hr 53 min", textColor: Color(0XFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12, height: 1),
                                            const SizedBox(width: 5,),
                                            Container(
                                              height: 22,
                                              decoration: CustomDecorations().baseBackgroundDecoration(20.0, 0.0,Colors.grey, Colors.transparent, ),
                                              padding: const EdgeInsets.only(left: 8, right: 8, top: 0.8),
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset('assets/navigate.svg',),
                                                  const SizedBox(width: 1,),
                                                  const CustomText(title: 'Navigate', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 10),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 17,),
                                      SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.69,
                                      child: CustomText(title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihonbashi-Honkokuchō, Nihonbashihongokuchō, Chuo City, Tokyo 103-0021, Japan", height: 1.3, color: Color(0XFF0D0D0D), fontWeight: FontWeight.w400, fontSize: 10, letterSpacing: 1))
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Column(
                                children: [
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Pax Name:',
                                    desc: 'Sumit Modi',
                                    image: 'assets/pax.svg',
                                  ),
                                  SizedBox(height:12),
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Mob. number:',
                                    desc: '+919876543210',
                                    image: 'assets/phoneBookingSumm.svg',
                                  ),
                                  SizedBox(height:12),
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Email ID:',
                                    desc: 'tech@drivado.com',
                                    image: 'assets/email.svg',
                                  ),
                                  SizedBox(height:12),
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Passenger count:',
                                    desc: '3',
                                    image: 'assets/passengerCount.svg',
                                  ),
                                  SizedBox(height:12),
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Chauffeur name: ',
                                    desc: 'Sumit Modi',
                                    image: 'assets/pax.svg',
                                  ),
                                  SizedBox(height:12),
                                  CustomBookingSummaryDataRowWithIcon(
                                    title: 'Chauffeur number:',
                                    desc: '+919876543210',
                                    image: 'assets/phoneBookingSumm.svg',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 11.3, right: 15, top: 10),
                          decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.green, Colors.green),
                          alignment: Alignment.center,
                          child: Theme(
                            data: ThemeData().copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              dense: true,
                              minTileHeight: 5,
                              iconColor: Colors.green,
                              collapsedIconColor: Colors.green,
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              title: const CustomText(title: 'Additional Details', color: Colors.green, fontWeight: FontWeight.w500, fontSize: 14),
                              children: <Widget>[
                                SizedBox(height:12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Created date:',
                                  desc: '01-01-2025',
                                  image: 'assets/createdDate.svg',
                                ),
                                SizedBox(height:12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Ref. number:',
                                  desc: '25689876543210',
                                  image: 'assets/email.svg',
                                ),
                                SizedBox(height:12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Spl. request:',
                                  desc: 'I need one water bottle',
                                  image: 'assets/spReq.svg',
                                ),
                                // SizedBox(height:12),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
  int _calculateNumberOfLines(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null, // Allow for unlimited lines
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length;
  }
}