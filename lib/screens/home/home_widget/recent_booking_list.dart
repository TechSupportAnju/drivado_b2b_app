import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentBookingList extends StatelessWidget {
  // final List<String> items;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const RecentBookingList({
    super.key,
    //required this.items,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
        child: ListView.separated(
        itemCount: 9,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: CustomDecorationsCards().baseBackgroundShadow(
              radius: 8,
              smooth: 1,
              color: Colors.white,
              width: 0.50,
              borderColor: const Color(0xFFE6E8E7),
              blurRadius: 10,
              boxShadowColor: Colors.transparent,
              x: 0,
              y: 0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: CustomDecorations().baseBackgroundDecoration(
                        8.0,
                        1.0,
                        const Color(0x0CFB4156),
                        Colors.transparent,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/home/calendar_icon.svg",
                          color: Color(0XFFFB4156), 
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "D0624-6478",
                          color: Color(0XFF0D0D0D),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/home/calendar_icon.svg",
                              color: Color(0XFF606060), 
                              height: 12,
                              width: 12,
                            ),
                            SizedBox(width: 4),
                            CustomText(
                              title: "05 Dec 2025",
                              color: Color(0XFF606060),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    StatusWidget(
                      text: "Upcoming",
                      backgroundColor: const Color(0xFFE6FFE6),
                      textColor: const Color(0xFF098C31),
                      borderColor: const Color(0x7F28A745),
                      borderWidth: 0.5
                    ),
                    SizedBox(width: 16),
                    SvgPicture.asset("assets/home/arrow_icon.svg"),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
      ),
    );
  }
}
