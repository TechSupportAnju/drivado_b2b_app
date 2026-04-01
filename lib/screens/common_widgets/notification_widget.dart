import 'package:drivado_b2b_app/screens/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Bell control in app headers; opens [NotificationScreen].
class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const NotificationScreen(),
          ),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0XFF352828),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/home/notification_icon.svg',
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
