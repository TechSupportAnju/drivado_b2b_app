import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int activeIndex = -1;
  List faqTitleText = ['How do I create an account on Drivado B2B app?', 'Can I track my booking in real-time?', 'How do I view my booking history?', 'How do I make payment for my booking?', 'Can I cancel my booking?', 'How can I contact Drivado customer support?'];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body:  Column(
        children: [
          Container(
            height: 110,
            color: Colors.white,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_backspace, color: Color(0xFF606060),)),
                  SizedBox(width: 16,),
                  CustomText(title: 'FAQ',
                    height: 1.4,
                    fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0D0D0D),),
                ],
              ),
            ),
          ),
          SizedBox(height: 25,),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: CustomText(title: 'How can we help you?',
                          height: 1.4,
                          color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'What is Drivado?',
                                  color: Color(0xFF606060), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Drivado is a global ground transportation company offering reliable, comfortable rides with impeccable service and flexible options to suit any budget globally. We offer a variety of transfers, which include airport transfers, city-to-city transfers, and hourly disposals',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'In which cities and countries is Drivado available?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'We are available in 425+ cities spanning across 65+ countries.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'What types of rides can I book with Drivado?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'We offer a wide range of transportation services, including airport transfers, city-to-city travel, cross-border transfers, event transportation, corporate travel, and hourly rentals.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'How do I book a ride with Drivado?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Easily book your rides through our all-in-one travel platform, available on both web and mobile, or reach out to our support team for quick assistance.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'Are Drivado’s prices fixed?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Yes, we offer transparent, upfront pricing. The price you see at the time of booking is final what you pay.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'What vehicles are available for booking?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Drivado offers a wide variety of vehicles, from standard cars and vans/SUVs to premium and luxury vehicles, all operated by professional licensed chauffeurs.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'Do I need to wait if my flight is delayed?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Our team tracks every flight. Even if the flight is delayed, have no stress; the driver will arrive based on the actual arrival time. If your flight is delayed by more than 3 hours, please contact us.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'Can I book Drivado for corporate or business travel?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 5),
                                    child: CustomText(title: 'Certainly, Drivado offers customized mobility solutions that are tailored to your business or corporate travel needs. To know more, please contact our support team.',
                                      color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'Does Drivado offer 24/7 customer support?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Our support team is available 24/7, 365 days a year, providing round-the-clock assistance whenever you need it so that you are never left stranded.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),   SizedBox(height: 12,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'Can I cancel or modify my booking?',
                                  color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 14, height: 1.4,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15, top: 0),
                                    child: CustomText(title: 'Yes, all bookings can be cancelled or modified under our flexible cancellation policy. For more details, please refer to our cancellation/amendment policy.',
                                      color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 12, height: 1.4,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );// This trailing comma makes auto-formatting nicer for build methods
  }

}

