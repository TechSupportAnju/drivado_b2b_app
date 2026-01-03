import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  final String text;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? textColor;

  const StatusWidget({
    super.key,
    required this.text,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(40)),
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.textColor
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: CustomText(
        title: widget.text, 
        fontSize: 12, 
        color: widget.textColor ?? Colors.transparent,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
    );
  }
}
