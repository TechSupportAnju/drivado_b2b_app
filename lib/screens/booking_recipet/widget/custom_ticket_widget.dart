import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'clipper_widget.dart';

class CTicketWidget extends StatefulWidget {
  const CTicketWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
  });

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;

  @override
  State<CTicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<CTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CTicketClipper(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        decoration:  ShapeDecoration(
          color: widget.color,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 16,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class CTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(0.0, size.height/2 + totalLength*totalLength), radius: 20.0));
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / 2 + totalLength*totalLength), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
