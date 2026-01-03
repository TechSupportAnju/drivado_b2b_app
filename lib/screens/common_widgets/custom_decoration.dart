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

class CustomDecorationsCards {
  const CustomDecorationsCards();

  ShapeDecoration baseBackgroundShadow({
    double? radius,
    double? smooth,
    Color? color,
    Color? borderColor,
    double? width,
    Color? boxShadowColor,
    double? spreadRadius,
    double? blurRadius,
    double? x,
    double? y,
  }) {
    final r = radius ?? 0.0;
    final s = smooth ?? 0.0;
    final bg = color ?? Colors.transparent;
    final border = borderColor ?? Colors.transparent;
    final w = width ?? 0.0;
    final shadow = boxShadowColor ?? Colors.transparent; 
    final spread = spreadRadius ?? 0.0;
    final blur = blurRadius ?? 0.0;
    final dx = x ?? 0.0;
    final dy = y ?? 0.0;

    return ShapeDecoration(
      color: bg,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: border, width: w),
        borderRadius: SmoothBorderRadius(
          cornerRadius: r,
          cornerSmoothing: s,
        ),
      ),
      shadows: [
        BoxShadow(
          color: shadow,
          spreadRadius: spread,
          blurRadius: blur,
          offset: Offset(dx, dy),
        ),
      ],
    );
  }
}
