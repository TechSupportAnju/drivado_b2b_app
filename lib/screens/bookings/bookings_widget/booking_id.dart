import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/document_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingIdWidget extends StatelessWidget {
  final String bookingId;
  final String status;
  final String paymentStatus;
  final BookingDetailData detail;

  const BookingIdWidget({
    super.key,
    required this.bookingId,
    required this.status,
    required this.paymentStatus,
    required this.detail,
  });

  static Color _statusColor(String s) {
    final l = s.toLowerCase();
    if (l.contains('confirm')) return const Color(0xFF28A745);
    if (l.contains('cancel')) return const Color(0xFFDC3545);
    if (l.contains('pending') || l.contains('assign')) {
      return const Color(0xFFFFC107);
    }
    return const Color(0xFF606060);
  }

  static Color _paymentColor(String p) {
    final u = p.toUpperCase();
    if (u.contains('PAID') && !u.contains('UNPAID')) {
      return const Color(0xFF28A745);
    }
    return const Color(0xFFFB4156);
  }

  @override
  Widget build(BuildContext context) {
    final stColor = _statusColor(status);
    final payColor = _paymentColor(paymentStatus);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        decoration: CustomDecorations().baseBackgroundDecoration(
          10.0,
          1.0,
          Colors.white,
          const Color(0xFFE6E8E7),
        ),
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
                          child: CustomText(
                            title: 'Booking ID',
                            color: const Color(0xFF606060),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: CustomText(
                            title: bookingId,
                            color: const Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DocumentWidget(
                              bookingId: bookingId,
                              detail: detail,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.5),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: CustomDecorations().baseBackgroundDecoration(
                      8.0,
                      1.0,
                      Colors.white,
                      const Color(0xFF606060),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/booking_detail/document_icon.svg',
                        ),
                        const SizedBox(width: 3),
                        const CustomText(
                          title: 'Documents',
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const CustomText(
                  title: 'Status: ',
                  color: Color(0xFF606060),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.7,
                ),
                CustomText(
                  title: status,
                  color: stColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.7,
                ),
                const Spacer(),
                const CustomText(
                  title: 'Payment: ',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.7,
                ),
                CustomText(
                  title: paymentStatus,
                  color: payColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
