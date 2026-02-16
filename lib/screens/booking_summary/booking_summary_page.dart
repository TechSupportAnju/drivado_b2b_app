import 'package:drivado_b2b_app/screens/booking_summary/widgets/booking_summary_detail_widget.dart';
import 'package:drivado_b2b_app/screens/booking_summary/widgets/pax_booking_summary.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/common_button.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/widget/custom_top_progress_bar.dart';
import 'package:flutter/material.dart';

class BookingSummaryPage extends StatefulWidget {
  final bool? isTapOneway;
  const BookingSummaryPage({this.isTapOneway ,super.key});

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryPageState();
}
bool isButtonActive = false;
class _BookingSummaryPageState extends State<BookingSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(height: 70),
        backgroundColor: Colors.white,
        elevation: 0.0,
        shadowColor: Color(0xFFD9D9D9),
        centerTitle: true,
        leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.keyboard_backspace,
          color: Color(0xFF555555),
        )),
        title: const CustomText(
          title: 'Booking Summary',
          color: Color(0xFF101010),
          fontWeight: FontWeight.w600,
          fontSize: 20
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomTopProgressBar(
                tabCount: 1,
                isActive: isButtonActive,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BookingSummaryDetailWidget(isTapOneway: widget.isTapOneway ?? true),
                  SizedBox(height: 12),
                  PaxBookingSummary()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CommonButtonWidget(backgroundColor: Color(0XFFFFFFFF), borderColor: Color(0XFF606060), text: "Cancel", textColor: Color(0XFF606060))
                  ),
                  InkWell(
                    onTap: () {},
                    child: CommonButtonWidget(
                      backgroundColor: Color(0XFFFB4156), 
                      borderColor: Colors.transparent, text: "Pay now", textColor: Color(0XFFFFFFFF)
                    )
                  ),
                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonTapButton(
                onTap: (){}, 
                title: "Pay by invoice", 
                backgroundcolor: Colors.black,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}