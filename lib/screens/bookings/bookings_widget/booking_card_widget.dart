import 'package:drivado_b2b_app/screens/bookings/booking_detail_page.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_type_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';

// class BookingCardWidget extends StatelessWidget {
//   const BookingCardWidget({
//     super.key,
//   });
  
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: 9,
//       padding: EdgeInsets.only(top: 16, bottom: 16),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 19, right: 19, top: 0),
//           child: Container(
//             decoration: CustomDecorationsCards().baseBackgroundShadow(
//               radius: 12,
//               smooth: 1,
//               color: Color(0XFFFFFFFF),
//               blurRadius: 4,
//               x: 0,
//               y: 0
//             ),
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12, bottom: 12 ,right: 12, left: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         child: Row(
//                           children: [
//                             SvgPicture.asset("assets/booking/pax_icon.svg"),
//                             SizedBox(width: 6),
//                             Expanded(
//                               child: CustomText(
//                                 title: "Mr. Khaled abdul rehman hfndjfn", 
//                                 color: Color(0XFF0D0D0D), 
//                                 fontWeight: FontWeight.w600, 
//                                 fontSize: 12,
//                                 maxLine: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               )
//                             )
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailPage()));
//                         },
//                         child: StatusWidget(
//                           text: "Confirmed", textColor: Color(0XFF28A745), borderColor: Color(0XFF28A745).withOpacity(0.5),borderWidth: 0.5, backgroundColor: Color(0XFF28A745).withOpacity(0.1), fontSize: 10, fontWeight: FontWeight.w600
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DottedLine(
//                   direction: Axis.horizontal,
//                   lineThickness: 1.0,
//                   dashColor: Colors.grey,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: SizedBox(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             CustomText(title: "D0223-6854", color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 10, height: 1),
//                             SizedBox(height: 8),
//                             CustomText(title: "Thu, Jan 18", color: Color(0XFFFB4156), fontWeight: FontWeight.w700, fontSize: 12, height: 1,),
//                             SizedBox(height: 8),
//                             CustomText(title: "13:25", color: Color(0XFF606060), fontWeight: FontWeight.w800, fontSize: 24, height: 1,),
//                             //SizedBox(height: ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // SizedBox(width: 1),
//                     SizedBox(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.6,
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/booking/source_icon.svg"),
//                                 SizedBox(width: 9),
//                                 Expanded(
//                                   child: Transform.translate(
//                                     offset: Offset(0, 4),
//                                     child: CustomText(
//                                       title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihon Geo, 3 Chome-1-6 Nihon, J Hotel Tokyo Geo", 
//                                       color: Color(0XFF606060), 
//                                       fontWeight: FontWeight.w500, 
//                                       fontSize: 10, 
//                                       height: 1.4, 
//                                       maxLine: 2,
//                                       overflow: TextOverflow.ellipsis
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 6),
//                                 child: const DottedLine(
//                                   direction: Axis.vertical,
//                                   lineLength: 25,
//                                   lineThickness: 1,
//                                   dashLength: 3.0,
//                                   dashColor: Color(0xFF585858),
//                                   dashRadius: 0.0,
//                                   dashGapLength: 2.0,
//                                   dashGapColor: Colors.transparent,
//                                   dashGapRadius: 0.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.6,
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/booking/destination_icon.svg"),
//                                 SizedBox(width: 9),
//                                 Expanded(
//                                   child: CustomText(
//                                     title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihon Geo, 3 Chome-1-6 Nihon, J Hotel Tokyo Geo", 
//                                     color: Color(0XFF606060), 
//                                     fontWeight: FontWeight.w500, 
//                                     fontSize: 10, 
//                                     height: 1.4, 
//                                     maxLine: 2
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
                          
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 BookingTypeWidget(bookingType: "Oneway", textColor: Color(0XFFFB4156), fontWeight: FontWeight.w600, fontSize: 12, height: 1),
//                                 SizedBox(width: 12),
//                                 Container(
//                                   height: 24,
//                                   width: 124,
//                                   decoration: BoxDecoration(
//                                     color: Color(0XFFF5F6FA),
//                                     borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                                       child: CustomText(title: "37 km | 2 hr 53 min", color: Color(0XFFFB4156), fontWeight: FontWeight.w600, fontSize: 12, height: 1),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/booking/card.svg",
//                       width: MediaQuery.of(context).size.width,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                               "assets/booking/driver_icon.svg",
//                             ),
//                             SizedBox(width: 2),
//                             CustomText(
//                               title: "Reda Julien Ghilana", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 14, height: 1
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                               "assets/booking/driver_contact_icon.svg",
//                             ),
//                             SizedBox(width: 2),
//                             CustomText(
//                               title: "+91 9876543210", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 14, height: 1
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5, left: 12, right: 12, bottom: 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         child: CustomText(
//                           title: "LUXURY SEDAN", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w700, fontSize: 12, height: 1
//                         ),
//                       ),
//                       CustomText(
//                         title: " | ", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w700, fontSize: 14, height: 1
//                       ),
//                       SizedBox(
//                         child: CustomText(
//                           title: "USD 234.00", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w700, fontSize: 12, height: 1
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (BuildContext context, int index) => SizedBox(height: 12)
//     );
//   }
// }

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontScale = screenWidth / 375;  // Pixel-perfect scaling

    return ListView.separated(
      itemCount: 9,
      padding: EdgeInsets.only(top: 16 * fontScale, bottom: 16 * fontScale),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 19 * fontScale, right: 19 * fontScale),
          child: Container(
            width: screenWidth - (38 * fontScale),  // Responsive width
            decoration: CustomDecorationsCards().baseBackgroundShadow(
              radius: 12 * fontScale,
              smooth: 1,
              color: const Color(0xFFFFFFFF),
              blurRadius: 4 * fontScale,
              x: 0,
              y: 0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12 * fontScale, 12 * fontScale, 12 * fontScale, 12 * fontScale),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5, 
                        child: Row(
                          children: [
                            SizedBox(
                              child: SvgPicture.asset("assets/booking/pax_icon.svg"),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: CustomText(
                                title: "Mr. Khaled abdul rehman hfndjfn", 
                                color: Color(0XFF0D0D0D), 
                                fontWeight: FontWeight.w600, 
                                fontSize: 12,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingDetailPage())),
                        child: StatusWidget(
                          text: "Confirmed", textColor: Color(0XFF28A745), borderColor: Color(0XFF28A745).withOpacity(0.5),borderWidth: 0.5, backgroundColor: Color(0XFF28A745).withOpacity(0.1), fontSize: 10, fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1.0 * fontScale,
                  dashColor: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12 * fontScale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "D0223-6854",
                            color: const Color(0xFFFB4156),
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            height: 1,
                          ),
                          SizedBox(height: 8 * fontScale),
                          CustomText(
                            title: "Thu, Jan 18",
                            color: const Color(0xFFFB4156),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            height: 1,
                          ),
                          SizedBox(height: 8 * fontScale),
                          CustomText(
                            title: "13:25",
                            color: const Color(0xFF606060),
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.6,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/booking/source_icon.svg"),
                                SizedBox(width: 9 * fontScale),
                                Expanded(
                                  child: Transform.translate(
                                    offset: Offset(0, 4 * fontScale),
                                    child: CustomText(
                                      title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihon Geo, 3 Chome-1-6 Nihon, J Hotel Tokyo Geo",
                                      color: const Color(0xFF606060),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10 * fontScale,
                                      height: 1.4,
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5 * fontScale),
                            child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: 25 * fontScale,
                              lineThickness: 1 * fontScale,
                              dashLength: 3.0 * fontScale,
                              dashColor: const Color(0xFF585858),
                              dashRadius: 0.0,
                              dashGapLength: 2.0 * fontScale,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.6,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/booking/destination_icon.svg"),
                                SizedBox(width: 9),
                                Expanded(
                                  child: CustomText(
                                    title: "J Hotel Tokyo Geo, 3 Chome-1-6 Nihon Geo, 3 Chome-1-6 Nihon, J Hotel Tokyo Geo",
                                    color: const Color(0xFF606060),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    height: 1.4,
                                    maxLine: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BookingTypeWidget(
                                  bookingType: "Oneway",
                                  textColor: const Color(0xFFFB4156),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  height: 1,
                                ),
                                SizedBox(width: 12 ),
                                Container(
                                  height: 24 * fontScale,
                                  width: 124 * fontScale,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F6FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      child: CustomText(
                                        title: "37 km | 2 hr 53 min",
                                        color: const Color(0xFFFB4156),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth,
                      child: SvgPicture.asset("assets/booking/card.svg"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/booking/driver_icon.svg"),
                            SizedBox(width: 2 * fontScale),
                            CustomText(
                              title: "Reda Julien Ghilana",
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/booking/driver_contact_icon.svg"),
                            SizedBox(width: 2 * fontScale),
                            CustomText(
                              title: "+91 9876543210",
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12 , 5, 12 , 12 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        title: "LUXURY SEDAN",
                        color: const Color(0xFF0D0D0D),
                        fontWeight: FontWeight.w700,
                        fontSize: 12 * fontScale,
                        height: 1,
                      ),
                      CustomText(
                        title: " | ",
                        color: const Color(0xFF0D0D0D),
                        fontWeight: FontWeight.w700,
                        fontSize: 14 * fontScale,
                        height: 1,
                      ),
                      CustomText(
                        title: "USD 234.00",
                        color: const Color(0xFF0D0D0D),
                        fontWeight: FontWeight.w700,
                        fontSize: 12 * fontScale,
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12 * fontScale),
    );
  }
}
