import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CommonHeaderTest extends StatelessWidget implements PreferredSizeWidget {
  const CommonHeaderTest({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(230);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: SvgPicture.asset("assets/home/profile_icon.svg"),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: const [
              CustomText(title: "Hello, Sumit", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14, maxLine: 1,
                overflow: TextOverflow.ellipsis, height: 1.4,),
              CustomText(title: "test@drivado.com", color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, maxLine: 1,
                  overflow: TextOverflow.ellipsis, height: 1.4),
            ],
          ),
        ),
        notificationWidget()
      ],
    );
  }
}