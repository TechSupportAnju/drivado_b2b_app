

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

notificationWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Color(0XFF352828),
          borderRadius: BorderRadius.circular(100)
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
    );
}