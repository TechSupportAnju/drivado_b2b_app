import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/appbar_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});
  @override
  State<BookingListPage> createState() => _BookingListPageState();
}
class _BookingListPageState extends State<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Color(0XFFFFFFFF),
      // appBar: CommonAppBar(
      //   bottomContent: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           SearchBarWidget(),
      //           InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => SearchFilterPage(),
      //                 ),
      //               );
      //             },
      //             child: FilterBooking(),
      //           )
      //         ],
      //       ),

      //       const SizedBox(height: 16),

      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               CustomText(
      //                 title: "All Booking",
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w500,
      //                 fontSize: 14,
      //               ),
      //               const SizedBox(width: 10),
      //               Container(
      //                 height: 20,
      //                 width: 38,
      //                 decoration: BoxDecoration(
      //                   color: const Color(0XFF352828),
      //                   borderRadius: BorderRadius.circular(32),
      //                 ),
      //                 child: const Center(
      //                   child: CustomText(
      //                     title: "250",
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 12,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),

      //           Row(
      //             children: [
      //               CustomText(
      //                 title: "Download report",
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w500,
      //                 fontSize: 14,
      //               ),
      //               const SizedBox(width: 10),
      //               Container(
      //                 height: 22,
      //                 width: 22,
      //                 decoration: BoxDecoration(
      //                   color: const Color(0XFF352828),
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(5),
      //                   child: SvgPicture.asset(
      //                     "assets/booking/download_icon.svg",
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      appBar: CommonAppBar(
        bottomHeight: 120,
        bottomWidget: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBarWidget(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchFilterPage(),
                        ),
                      );
                    },
                    child: FilterBooking(),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        title: "All Booking",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 38,
                        decoration: BoxDecoration(
                          color: const Color(0XFF352828),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Center(
                          child: CustomText(
                            title: "250",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  Row(
                    children: [
                      CustomText(
                        title: "Download report",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: const Color(0XFF352828),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            "assets/booking/download_icon.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: CustomDecorations().baseBackgroundDecoration(
                  0.0,
                  1.0,
                  Color(0XFFF5F6FA),
                  Colors.transparent,
                ),
                child: BookingCardWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}