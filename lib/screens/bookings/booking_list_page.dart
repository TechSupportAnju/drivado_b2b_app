import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/appbar_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:flutter/material.dart';

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
      appBar: CommonHeader(),
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