import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CancelBottomSheet extends StatefulWidget {
  const CancelBottomSheet({super.key});

  @override
  State<CancelBottomSheet> createState() => _CancelBottomSheetState();
}

class _CancelBottomSheetState extends State<CancelBottomSheet> {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 140,
      padding: EdgeInsets.all(20),
      decoration: CustomDecorations().baseBackgroundDecoration(25.0, 1.0, Colors.white, Colors.transparent),
      child: Column(
        children: [
          SvgPicture.asset("assets/booking_detail/line_icon.svg"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/booking_detail/cancel_icon.svg"),
              SizedBox(width: 18),
              CustomText(
                title: "Cancel Booking", 
                color: const Color(0xFFDC3646),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ],
      ),
    );
  }
}