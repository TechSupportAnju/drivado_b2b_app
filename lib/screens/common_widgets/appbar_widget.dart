import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? bottomWidget;
  final double bottomHeight;

  const CommonAppBar({
    super.key,
    this.bottomWidget,
    this.bottomHeight = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF190C0C),
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight, 
      title: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset("assets/home/profile_icon.svg"),
          ),
          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: "Hello, Sumit",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.4,
                ),
                SizedBox(height: 2),
                CustomText(
                  title: "test@drivado.com",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.4,
                ),
              ],
            ),
          ),
          notificationWidget(),
        ],
      ),
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomHeight),
              child: bottomWidget!,
            )
          : null,
    );
  }
}