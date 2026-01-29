import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileWidget extends StatelessWidget {
  final String text;
  final String desc;
  final String image;


  const UserProfileWidget({
    super.key,
    required this.text,
    required this.image,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Container(
      height: 35,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(image, height:  screenWidth >= 650 ? 28 : 32,),
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
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF606060),
                          fontSize: screenWidth >= 650 ? 24 : 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Container(
                        width: screenWidth/1.7,
                        child: CustomText(
                          title: desc,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D0D0D),
                          fontSize: screenWidth >= 650 ? 24 : 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


