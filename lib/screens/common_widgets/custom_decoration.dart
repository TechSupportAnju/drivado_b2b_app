import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CustomDecorations {
  ShapeDecoration baseBackgroundDecoration(radius, smooth, color, borderColor, {double width = 1.0}){
    return ShapeDecoration(
      color: color,
      shape: SmoothRectangleBorder(
        side:  BorderSide(color: borderColor, width: width),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: smooth,
        ),
      ),
    );
  }
}