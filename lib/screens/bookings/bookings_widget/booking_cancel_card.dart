import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingCancelledCard extends StatelessWidget {
  /// From booking API [`cancellationFees`]; numeric 0 shows full-refund messaging.
  final dynamic cancellationFee;
  const BookingCancelledCard({super.key, required this.cancellationFee});

  static bool _feeIsZero(dynamic fee) {
    if (fee == null) return true;
    if (fee is num) return fee == 0;
    final s = fee.toString().trim();
    if (s.isEmpty) return true;
    final n = num.tryParse(s);
    return n != null ? n == 0 : (s == '0' || s == '0.0');
  }

  static String _feeAmountLabel(dynamic fee) {
    if (fee == null || _feeIsZero(fee)) return '0';
    if (fee is num) {
      final d = fee.toDouble();
      if ((d - d.roundToDouble()).abs() < 1e-9) return d.round().toString();
      return fee.toString();
    }
    final n = num.tryParse(fee.toString());
    if (n != null) return _feeAmountLabel(n);
    return fee.toString();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        //height: MediaQuery.of(context).size.height * 0.201,
        // margin: const EdgeInsets.only(top: 16, bottom: 16),
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
                spacing: 12,
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
                      spacing: 4,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6,
                            children: [
                              SvgPicture.asset("assets/my_booking_icons/cancelled_booking_icon.svg"),
                              CustomText(
                                  title: 'Booking Cancelled !',
                                  color: const Color(0xFFDC3545),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                              CustomText(
                                  title: 'This booking was cancelled 24 hours before the scheduled time.',
                                  color: const Color(0xCCDC3545),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.30
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _feeIsZero(cancellationFee)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5,),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Icon(Icons.circle, size: 7, color: AppColors.bookingCardBlueColor,),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: CustomText(
                          title: 'Refund will be processed within 7-10 business days to your original payment method',
                          fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.bookingCardBlueColor, height: 1.2,
                        ),
                      ),
                    ],
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(10),
                    decoration: CustomDecorationsCards().baseBackgroundShadow(
                        radius: 8.0,
                        smooth: 1.0,
                        color: const Color(0x0CDC3545),
                        width: 0.25,
                        borderColor: const Color(0xFFFB4156)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      //spacing: 16,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  children: [
                                    CustomText(title: "${_feeAmountLabel(cancellationFee)} ", color: const Color(0xFF0D0D0D),fontSize: 16, fontWeight: FontWeight.w600),
                                    CustomText(title: "USD", color: const Color(0xFFFB4156),fontSize: 16, fontWeight: FontWeight.w600),
                                  ],
                                )
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: CustomText(
                                title: 'Cancellation fee',
                                color: const Color(0xFF606060),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: ShapeDecoration(
                              color: const Color(0x19DC3545),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: const Color(0xFFDC3545),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              //spacing: 10,
                              children: [
                                CustomText(
                                  title:  'Fee Applied',
                                  color: const Color(0xFFDC3545),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
  }
}