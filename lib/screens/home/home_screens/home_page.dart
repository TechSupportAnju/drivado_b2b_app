import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/number_of_booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/recent_booking_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                top: 100,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
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
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: CustomDecorations().baseBackgroundDecoration(
                    36.0,
                    1.0,
                    Colors.white,
                    Colors.transparent,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(12),
                            decoration: CustomDecorationsCards().baseBackgroundShadow(
                              radius: 12,
                              smooth: 1,
                              color: Colors.white,
                              blurRadius: 4,
                              boxShadowColor: Color(0XFF606060).withOpacity(0.16),
                              x: 0,
                              y: 0
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                CustomText(title: "Total Booking", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12),
                                CustomText(title: "1232", color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 32),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  spacing: 12,
                                  children: [
                                    NumberOfBookingCardWidget(
                                      svgPath: 'assets/home/calendar_icon.svg',
                                      iconBgColor: const Color(0xFFFEEECC).withOpacity(0.3),
                                      count: 600,
                                      status: "CONFIRMED",
                                    ),
                                    NumberOfBookingCardWidget(
                                      svgPath: 'assets/home/calendar_tick_icon.svg',
                                      iconBgColor: const Color(0xFFCEFFE0).withOpacity(0.3),
                                      count: 600,
                                      status: "COMPLETED",
                                    ),
                                    NumberOfBookingCardWidget(
                                      svgPath: 'assets/home/calendar_remove_icon.svg',
                                      iconBgColor: const Color(0xFFFFDBDF).withOpacity(0.3),
                                      count: 600,
                                      status: "CANCELLED",
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(12),
                          decoration: CustomDecorationsCards().baseBackgroundShadow(
                            radius: 12,
                            smooth: 1,
                            color: Colors.white,
                            blurRadius: 4,
                            boxShadowColor: Color(0XFF606060).withOpacity(0.16),
                            x: 0,
                            y: 0
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(title: "Recent Bookings", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16, height: 1.4),
                                    CustomText(title: "See More", color: Color(0XFF606060), fontWeight: FontWeight.w400, fontSize: 12, height: 1, textDecoration: TextDecoration.underline,),
                                  ],
                                ),
                                SizedBox(height: 16,),
                                RecentBookingList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
