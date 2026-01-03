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
    return ListView.builder(
      itemCount: 9,
      padding:const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: CustomDecorationsCards().baseBackgroundShadow(
            radius: 8,
            smooth: 1,
            color: Colors.white,
            width: 0.5,
            borderColor: Color(0XFFE6E8E7).withOpacity(0.8),
            blurRadius: 10,
            boxShadowColor: Color(0XFF606060).withOpacity(0.1),
            x: 0,
            y: 0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              SizedBox(
                child: Row(
                  spacing: 8,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: CustomDecorations().baseBackgroundDecoration(
                        8.0,
                        1.0,
                        Color(0XFFFB4156).withOpacity(0.1),
                        Colors.transparent,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset("assets/home/calendar_icon.svg", color: Color(0XFFFB4156), 
                            height: 16, width: 16,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        CustomText(title: "D0624-6478", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 16, height: 1,),
                        Row(
                          spacing: 4,
                          children: [
                            SvgPicture.asset("assets/home/calendar_icon.svg", color: Color(0XFF606060), 
                            height: 12, width: 12,
                          ),
                            CustomText(title: "05 Dec 2025", color: Color(0XFF606060), fontWeight: FontWeight.w400, fontSize: 12, height: 1,),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(
                child: Row(
                  spacing: 16,
                  children: [
                    StatusWidget(text: "Upcoming", textColor: Color(0XFF28A745), borderColor: Color(0XFF28A745).withOpacity(0.8),borderWidth: 0.5),
                    SvgPicture.asset("assets/home/arrow_icon.svg"),
                  ],
                ),
              )
            ],
          ),
        );
        
      },
    );
  }
}
