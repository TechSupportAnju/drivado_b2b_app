
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class AnimatedToggleManagement extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;

  const AnimatedToggleManagement({
    super.key,
    required this.values,
    required this.onToggleCallback,
  });
  @override
  _AnimatedToggleStateM createState() => _AnimatedToggleStateM();
}

class _AnimatedToggleStateM extends State<AnimatedToggleManagement> {
  bool initialPosition = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            initialPosition = !initialPosition;
            var index = 0;
            if (!initialPosition) {
              index = 1;
            }
            widget.onToggleCallback(index);
            setState(() {});
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 44,
            decoration:CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, Color(0xFFE6E7E8)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    alignment: Alignment.center,
                    child: CustomText(
                      title: widget.values[0],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF606060),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    alignment: Alignment.center,
                    child: CustomText(
                      title: widget.values[1],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF606060),
                    ),
                  ),
                ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
            initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width/2.3,
              height: 36,
              decoration:CustomDecorations().baseBackgroundDecoration(6.0, 1.0, Color(0xFFF5F6FA), Color(0xFFE6E8E7)),
              alignment: Alignment.center,
              child: CustomText(
                title: initialPosition ? widget.values[0] : widget.values[1],
                fontSize: 14,
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}