import 'package:drivado_b2b_app/screens/bookings/bookings_widget/document_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingIdWidget extends StatelessWidget {
  const BookingIdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0XFFE6E8E7)),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentWidget()));
                  },
                  child: Container(
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
                CustomText(title: 'UNPAID', color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 14, height: 1.7),
              ],
            )

          ],
        ),
      ),
    );
  }
}