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
      // toastStyle: ToastStyle(
      //   titleLeadingGap: 10,
      //   backgroundColor: Color(0XFF242C32),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Color(0x33000000),
      //       blurRadius: 10,
      //       offset: Offset(0, 8),
      //       spreadRadius: 0,
      //       ),
      //       BoxShadow(
      //       color: Color(0x1E000000),
      //       blurRadius: 30,
      //       offset: Offset(0, 6),
      //       spreadRadius: 0,
      //       ),
      //       BoxShadow(
      //       color: Color(0x23000000),
      //       blurRadius: 24,
      //       offset: Offset(0, 16),
      //       spreadRadius: 0,
      //     ),
      //   ],
      //    gradient: RadialGradient(
      //     center: Alignment(0.50, 0.50),
      //     radius: 1,
      //     colors: [const Color(0xFF16A329),Color(0XFF242C32)],
      //   ),
              
      //   progressBarColor: Color(0XFF16A329),
      // ),

      toastStyle: ToastStyle(
        titleLeadingGap: 12,
        backgroundColor: Color(0XFF242C32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.35),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
        progressBarColor: Color(0XFF16A329),
      ),
      
      // toastSetting: SlidingToastSetting(
      //   maxWidth: MediaQuery.of(context).size.width * 0.9,
      //   animationDuration: const Duration(milliseconds: 600),
      //   displayDuration: displayDuration,
      //   toastStartPosition: ToastPosition.top,
      //   toastAlignment: Alignment.center,
      //   showProgressBar: true,
      //   progressBarHeight: 4,
      //   padding: EdgeInsets.all(0)
      // ),
      toastSetting: SlidingToastSetting(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        animationDuration: const Duration(milliseconds:6500),
        displayDuration: displayDuration,
        toastStartPosition: ToastPosition.top,
        toastAlignment: Alignment.center,
        showProgressBar: true,
        progressBarHeight: 4,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      
    );
  }
}


// class ToastLeading extends StatelessWidget {
//   final String iconAsset;
//   final Color backgroundColor;

//   const ToastLeading({
//     super.key,
//     required this.iconAsset,
//     this.backgroundColor = Colors.transparent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Stack(
//       children: [
//         Container(
//           width: 34,
//           height: 34,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: backgroundColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withAlpha(25),
//                 spreadRadius: 3,
//                 blurRadius: 4,
//               ),
//             ],
            
//           ),
//           alignment: Alignment.center,
//           child: ToastSvgIcon(asset: iconAsset),
//         ),
//       ],
//     );
//   }
// }
class ToastLeading extends StatelessWidget {
  final String iconAsset;

  const ToastLeading({
    super.key,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              radius: 0.5,
              colors: [
                const Color(0xFF16A329).withOpacity(0.35),
                const Color(0xFF22C55E).withOpacity(0.2),
                
              ],
              stops: const [0.0, 0.6],
            ),
          ),
        ),

        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconAsset,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
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
