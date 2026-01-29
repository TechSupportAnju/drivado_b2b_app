import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BookingStatusWidget extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool?> onChanged;
  const BookingStatusWidget({
    required this.value,
    required this.text,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: Colors.white, 
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0XFFFB4156); 
              }
              return Colors.white; 
            },
          ),
          side: BorderSide(
            width: 1,
            color: const Color(0x7F606060),
          ),
        ),
        CustomText(
          title: text,
          color: const Color(0xFF606060),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.14,
        ),
      ],
    );
  }
}