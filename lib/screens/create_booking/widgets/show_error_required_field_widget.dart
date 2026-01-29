//error popup ----------------------
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowErrorRequiredFieldWidget extends StatefulWidget {
  const ShowErrorRequiredFieldWidget({
    super.key,
  });

  @override
  State<ShowErrorRequiredFieldWidget> createState() => _ShowErrorRequiredFieldWidgetState();
}

class _ShowErrorRequiredFieldWidgetState extends State<ShowErrorRequiredFieldWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double progress = 1.0;
  Timer? timer;
 @override
   void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        timer!.cancel();
      },
      child: StatefulBuilder(
        builder: (context, newState) {
          // Start a timer to update progress
          timer ??= Timer.periodic(const Duration(milliseconds: 30), (t) {
            if (progress <= 0.01) {
              t.cancel();
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop(); // Close the dialog safely
              }
            } else {
              newState(() {
                // Update animation
                _animation = Tween<double>(
                  begin: _animation.value,
                  end: progress,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.linear,
                  ),
                );

                // Restart animation
                _animationController.reset();
                _animationController.forward();
                // Update current progress
                progress -= 0.01;
              });
            }
          });
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.transparent,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/create_booking/Warning.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 3.0,
                  right: 6,
                  bottom: 0.3,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/create_booking/toastIcon.svg'),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              SizedBox(
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.45,
                                child: const Row(
                                  children: [
                                    CustomText(
                                      title: 'Action Required',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      height: 1.3,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              SizedBox(
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.45,
                                child: const Row(
                                  children: [
                                    CustomText(
                                      title: 'Incomplete fields. Please fill in all required\ninformation now',
                                      color: Color(0xffC8C5C5),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ],
                                ),
                              ),
                              //   autoCloseDuration: const Duration(seconds: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          value: progress,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xffFB4156),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}

