import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_company.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

userCompanyListTileWidget(context, title, value) {
  return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(value == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUserPage()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCompanyPage()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
        children: [
        SvgPicture.asset(value == 1 ? 'assets/user_management/manageUser.svg' : 'assets/user_management/company.svg'),
        const SizedBox(width: 12,),
        CustomText(title: title , color: Color(0xff0D0D0D), fontWeight: FontWeight.w500, fontSize: 12),],),
        ),
    );
}