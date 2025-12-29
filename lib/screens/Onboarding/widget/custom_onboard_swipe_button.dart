import 'package:flutter/material.dart';

class USmoothCircularEdgesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const gradient =  LinearGradient(
      colors: [
        Color(0xFFFFFFFF), // Color 2D3443
        Color(0xFFFFFFFF), // Color 0B0C0D
      ],
      begin: Alignment.topCenter,  // Start of the gradient
      end: Alignment.bottomCenter, // End of the gradient
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    final path = Path();


    // Start at the top-left corner
    path.moveTo(0, 0);

    // Draw line to top-right corner
    path.lineTo(size.width, 0);

    // Line down to the start of the U-shape
    path.lineTo(size.width, size.height / 1.4 - 65);

    // Start of U-shape with rounded edge
    path.arcToPoint(
      Offset(size.width - 20, size.height /1.4 - 29),
      radius: const Radius.circular(50),
      clockwise: true,
    );

    path.quadraticBezierTo(
      size.width - 40, size.height/1.4 - 10, // Control point for the middle of U-shape
      size.width - 15,  size.height/1.4 + 10 , // End of the U-shape
    );
    // Bottom of U-shape with rounded edge
    path.arcToPoint(
      Offset(size.width, size.height /1.4 + 40),
      radius: const Radius.circular(40),
      clockwise: true,
    );


    // Line down to bottom-right corner
    path.lineTo(size.width, size.height);

    // Line to bottom-left corner
    path.lineTo(0, size.height);

    // Close the path
    path.close();

    // Draw the path
    canvas.drawPath(path, paint);

    // Start the U-shape with a small arc to make it circular at the start
    // path.arcToPoint(
    //   Offset(size.width * 0.63 - 20, 10),
    //   radius: Radius.circular(20),
    //   clockwise: false,
    // );

    // // Draw the U-shape curve using quadratic bezier
    // path.quadraticBezierTo(
    //   size.width * 0.5, 55, // Control point for the middle of U-shape
    //   size.width * 0.43, 11, // End of the U-shape
    // );
    //
    // // Add the small arc at the end of the U-shape to make it circular
    // path.arcToPoint(
    //   Offset(size.width * 0.37, 0),
    //   radius: Radius.circular(25),
    //   clockwise: false,
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

