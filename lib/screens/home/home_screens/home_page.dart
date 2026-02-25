import 'package:drivado_b2b_app/screens/bookings/booking_list_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
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
      resizeToAvoidBottomInset: false,
      extendBody: false,
      backgroundColor:Color(0XFFFFFFFF),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF190C0C),
                image: DecorationImage(
                  image: AssetImage('assets/create_booking/mask.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 31),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset("assets/home/profile_icon.svg")
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        CustomText(title: "Hello, Sumit", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14, maxLine: 1, 
                        overflow: TextOverflow.ellipsis, height: 1.4,),
                        CustomText(title: "test@drivado.com", color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, maxLine: 1,
                        overflow: TextOverflow.ellipsis, height: 1.4),
                      ],
                    ),
                  ),
                  notificationWidget()
                ],
              ),
            ),
            Positioned(
              top:  150,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: CustomDecorations().baseBackgroundDecoration(
                  36.0,
                  1.0,
                  Color(0XFFFFFFFF),
                  Colors.transparent,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom +
                          kBottomNavigationBarHeight + 
                          92, 
                    ),
                  child: Container(
                    //height: MediaQuery.of(context).size.height * 0.7, 
                    decoration: CustomDecorations().baseBackgroundDecoration(
                      36.0,
                      1.0,
                      Color(0XFFFFFFFF),
                      Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: double.infinity,
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
                              children: [
                                CustomText(title: "Total Booking", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12),
                                SizedBox(height: 8),
                                CustomText(title: "1232", color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 32),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            width: double.infinity,
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      title: "Recent Bookings",
                                      color: Color(0XFF0D0D0D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                    InkWell(
                                      onTap: () {
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RootShell(bottomBarIndex: 1),
                                        ),
                                      );
                                      },
                                      child: CustomText(
                                        title: "See More",
                                        color: Color(0XFF606060),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1,
                                        textDecoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
            
                                RecentBookingList(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
