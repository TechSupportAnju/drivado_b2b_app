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
  ShapeDecoration draggableSheetDecoration(radiusTopLeft, radiusTopRight, radiusBottomLeft, radiusBottomRight, smooth,  color, borderColor){
    return ShapeDecoration(
      color: color,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: SmoothBorderRadius.only(
          topLeft: SmoothRadius(cornerRadius: radiusTopLeft, cornerSmoothing: smooth),
          topRight: SmoothRadius(cornerRadius: radiusTopRight, cornerSmoothing: smooth),
          bottomLeft: SmoothRadius(cornerRadius: radiusBottomLeft, cornerSmoothing: smooth),
          bottomRight: SmoothRadius(cornerRadius: radiusBottomRight, cornerSmoothing: smooth),
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

class CustomCardDecorations {
  ShapeDecoration baseBackgroundCardDecoration({
    required double radius,
    required double smooth,
    required bool isSelected,
    required Color selectedGradientStart,
    required Color selectedGradientEnd,
    required Color unselectedColor,
    required Color borderColor,
  }) {
    return ShapeDecoration(
      // Apply gradient if selected, otherwise use the unselected color
      gradient: isSelected
          ? LinearGradient(
        colors: [selectedGradientStart, selectedGradientEnd],
        begin: const Alignment(0.00, -1.1),
        end: const Alignment(0, 1.5),
      )
          : null,
      color: isSelected ? null : unselectedColor,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.0),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: smooth,
        ),
      ),
    );
  }
}