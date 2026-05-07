import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingCancelledCard extends StatelessWidget {
  const BookingCancelledCard({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: CustomDecorationsCards().baseBackgroundShadow(
        radius: 8.0,
        smooth: 1.0,
        color: Colors.white,
        boxShadowColor:  Color(0x14000000),
        blurRadius: 8.0,
        x: 0, y: 2
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              //spacing: 12,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  
                  decoration: CustomDecorationsCards().baseBackgroundShadow(
                    radius: 8.0,
                    smooth: 1.0,
                    color: const Color(0x19DC3545),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                   
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          
                          children: [
                            SvgPicture.asset("assets/booking_detail/cancelled_icon.svg"),
                            SizedBox(height: 4),
                            CustomText(
                              title: 'Booking Cancelled !',
                              color: const Color(0xFFDC3545),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                            SizedBox(height: 6),
                            CustomText(
                              title: 'This booking was cancelled 24 hours before the scheduled time.',
                              color: const Color(0xCCDC3545),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              height: 1,
                              letterSpacing: -0.30
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(Icons.circle, size: 7, color: Color(0XFF007BFF)),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: CustomText(
                         title: 'Refund will be processed within 7-10 business days to your original payment method',
                          fontWeight: FontWeight.w500, fontSize: 12, color: Color(0XFF007BFF), height: 1.2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
    }
  }
