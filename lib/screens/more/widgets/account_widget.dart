import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_switch.dart';
import 'delete_popup.dart';
import 'logout_popup.dart';

class AccountInfoWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double widthFactor;

  const AccountInfoWidget({
    super.key,
    required this.text,
    required this.style,
    this.widthFactor = 1.8,

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}

class AccountPageHeader extends StatelessWidget {
  final String text;
  final String image;
  final Widget? route;
  final bool isMore;
  const AccountPageHeader({
    super.key,
    required this.text,
    required this.image,
    this.route,
    this.isMore = false
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    bool status = false;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (route != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => route!));
        } else {
        if(text == 'Logout') {
          showLogoutPopup(context);
        }
        if(text == 'Delete Account') {
         showDeleteDialog(context);
         }
        }
      },
      child: Container(
        height: 30,
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(image, height:  screenWidth >= 650 ? 28 : 30,),
                const SizedBox(width: 12,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth/1.7,
                          child: CustomText(
                            title: text,
                            fontWeight: FontWeight.w500,
                            color: text == 'Logout' || text == 'Delete Account' ? AppColors.secondary : Color(0xFF0D0D0D),
                            fontSize: screenWidth >= 650 ? 24 : 14,
                          ),
                        ),
                      ],
                    ),
                    text == 'Logout' ||  text == 'Delete Account' ? SizedBox(height: 4,) : Container(),
                    text == 'Logout' ||  text == 'Delete Account' ? Row(
                      children: [
                        SizedBox(
                          width: screenWidth/1.7,
                          child: CustomText(
                            title:  text == 'Logout' ? 'Securely log out of Account' : 'Permanently remove your account',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF606060),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ) : Container(),
                  ],
                ),
              ],
            ),
            isMore
            ? CustomSwitch(
              isText: false,
              value: status,
              onChanged: (value) {
                  status = value;
              },
            )
            : SvgPicture.asset('assets/more/arrow.svg',)
          ],
        ),
      ),
    );
  }
}

