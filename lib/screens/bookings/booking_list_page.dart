import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
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
      backgroundColor: Color(0XFFFFFFFF),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0XFF190C0C),
            image: DecorationImage(
              image: AssetImage("assets/home/map_image.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            )
          ),
          child: Stack(
            children: [
              Positioned(
                top: 65,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 9),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: SvgPicture.asset("assets/home/profile_icon.svg")
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6,
                                children: [
                                  CustomText(title: "Hello, Sumit", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20, maxLine: 1, 
                                  overflow: TextOverflow.ellipsis, height: 1,),
                                  CustomText(title: "test@drivado.com", color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, maxLine: 1,
                                  overflow: TextOverflow.ellipsis, height: 1),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0XFF352828),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/home/notification_icon.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SearchBarWidget(),
                            FilterBooking()
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomText(title: "All Booking", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 14, height: 1),
                                SizedBox(width: 10),
                                Container(
                                  height: 20,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    color: Color(0XFF352828),
                                    borderRadius: BorderRadius.circular(32)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                    child: CustomText(title: "250", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 12, height: 1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(title: "Download report", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 14, height: 1),
                                SizedBox(width: 10),
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: Color(0XFF352828),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                                    child: SvgPicture.asset("assets/booking/download_icon.svg"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 250,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: CustomDecorations().baseBackgroundDecoration(
                    36.0,
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
      ),
    );
  }
}