import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppToast {
  AppToast._();

  static void show({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? leadingIcon,
    String? trailingIcon,
    Duration displayDuration = const Duration(seconds: 3),
  }) {
    InteractiveToast.slide(
      context: context,
      leading: leadingIcon != null? ToastLeading(iconAsset: leadingIcon) : null,
      title: ToastTextContent(
        title: title,
        subtitle: subtitle,
      ),
      trailing: trailingIcon != null? ToastSvgIcon(asset: trailingIcon) : null,
      toastStyle: ToastStyle(
        titleLeadingGap: 10,
        backgroundColor: Color(0XFF242C32),
        // boxShadow: [
        //   BoxShadow(
        //   color: Color(0x33000000),
        //   blurRadius: 10,
        //   offset: Offset(0, 8),
        //   spreadRadius: 0,
        //   ),
        //   BoxShadow(
        //   color: Color(0x1E000000),
        //   blurRadius: 30,
        //   offset: Offset(0, 6),
        //   spreadRadius: 0,
        //   ),
        //   BoxShadow(
        //   color: Color(0x23000000),
        //   blurRadius: 24,
        //   offset: Offset(0, 16),
        //   spreadRadius: 0,
        //   )
        //   ],
        gradient: RadialGradient(
          colors: [
            Color(0XFF16A329).withOpacity(0.69), Color(0XFF242C32)
          ],
          radius: 1.0,
          center: Alignment.centerLeft
        ),
        progressBarColor: Color(0XFF16A329),
      ),
      
      toastSetting: SlidingToastSetting(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        animationDuration: const Duration(milliseconds: 600),
        displayDuration: displayDuration,
        toastStartPosition: ToastPosition.top,
        toastAlignment: Alignment.center,
        showProgressBar: true,
        progressBarHeight: 4,
        padding: EdgeInsets.all(0)
      ),
      
    );
  }
}


class ToastLeading extends StatelessWidget {
  final String iconAsset;
  final Color backgroundColor;

  const ToastLeading({
    super.key,
    required this.iconAsset,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: ToastSvgIcon(asset: iconAsset),
    );
  }
}


class ToastTextContent extends StatelessWidget {
  final String title;
  final String subtitle;

  const ToastTextContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          title: title,
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          height: 1.8,
          letterSpacing: -0.41,
        ),
        CustomText(
          title: subtitle,
          color: Color(0XFFC8C5C5),
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 1.8,
          letterSpacing: -0.08,
        ),
      ],
    );
  }
}


class ToastSvgIcon extends StatelessWidget {
  final String asset;
  final double size;

  const ToastSvgIcon({
    super.key,
    required this.asset,
    this.size = 34,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
    );
  }
}
