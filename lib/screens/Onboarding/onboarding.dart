import 'package:drivado_b2b_app/screens/Onboarding/widget/custom_onboard_swipe_button.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'onboard_next_page.dart';

int onBoardingValue = 1;

class Onboarding extends StatefulWidget {
  final bool? isLogin;
  const Onboarding({required this.isLogin, super.key});

  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  bool isSwipe = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        body: isSwipe
            ? Container()
            : SizedBox(
          width: MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SizedBox(
                     height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width -20, MediaQuery.of(context).size.height,), // You can adjust this to control the size of the U
                            painter: USmoothCircularEdgesPainter(),
                          ),
                          Positioned(
                            height: MediaQuery.of(context).size.height /1.7,
                            bottom: 5,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                              },
                              onVerticalDragStart: (val) {
                                setState(() {
                                  isSwipe = true;
                                });
                                onBoardingValue = onBoardingValue + 1;
                                if(onBoardingValue == 3) {
                                  Navigator.of(context).push(SwipeablePageRoute(
                                    transitionDuration: const Duration(seconds: 1),
                                    canOnlySwipeFromEdge: true,
                                    builder: (BuildContext context) => const OnboardNextPage(isLogin: false),
                                  ));
                                } else {
                                  Navigator.of(context).push(SwipeablePageRoute(
                                    transitionDuration: const Duration(seconds: 1),
                                    canOnlySwipeFromEdge: true,
                                    builder: (BuildContext context) => const Onboarding(isLogin: false),
                                  ));
                                }
                              },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0, right: 0),
                                    child: SvgPicture.asset(
                                      'assets/splash/swipe.svg', height: 35,),
                                  )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height:  MediaQuery.of(context).size.height/1.8,
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(onBoardingValue == 1 ? 'assets/splash/on.png' : 'assets/splash/on2.png', height: 266,),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height:  MediaQuery.of(context).size.height/2.9,
                            color: Colors.white,
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(title: onBoardingValue == 1 ? 'Request a Ride' : 'Choose your vehicle',
                                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: screenWidth * 0.075),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(title: onBoardingValue == 1
                                            ? 'Select Pick-up and drop-off location and search for available car categories.'
                                            : 'Select from available category of cars based on your requirement with all inclusive prices (no hidden charges). ',
                                            height: 1.2,
                                            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 11,),
                                  Row(
                                    children: [
                                     GestureDetector(
                                       onTap :( ){
                                         Navigator.of(context).push(SwipeablePageRoute(
                                           transitionDuration: const Duration(milliseconds: 700),
                                           builder: (BuildContext context) => const OnboardNextPage(isLogin: false),
                                         ));
                                       },
                                       child: Container(
                                         height: 36,
                                         width: 120,
                                         decoration: CustomDecorations().baseBackgroundDecoration(50.0, 0.0, Colors.white, AppColors.arrowColor),
                                         alignment: Alignment.center,
                                         child: CustomText(title: 'Skip', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w500, fontSize: 14),
                                       ),
                                     ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, bottom: 15),
                            child: Column(
                              children: [
                                Container(
                                  height: onBoardingValue == 1 ? 35 : 6,
                                  width: 6,
                                  decoration: CustomDecorations().baseBackgroundDecoration(20.0, 0.0, onBoardingValue == 1 ? AppColors.secondary : AppColors.strokeColor, Colors.transparent),
                                ),
                                const SizedBox(height: 18,),
                                Container(
                                  height: onBoardingValue == 1 ? 6 : 35,
                                  width: 6,
                                  decoration: CustomDecorations().baseBackgroundDecoration(20.0, 0.0, onBoardingValue == 1 ? AppColors.strokeColor : AppColors.secondary, Colors.transparent),
                                ),
                                const SizedBox(height: 18,),
                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: CustomDecorations().baseBackgroundDecoration(20.0, 0.0, AppColors.strokeColor, Colors.transparent),
                                ),
                                const SizedBox(height: 21,),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height:  MediaQuery.of(context).size.height/9,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

