
import 'dart:async';

import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart' show SmoothRectangleBorder, SmoothBorderRadius;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'widgets/account_widget.dart';

class VerifyIdentifyPage extends StatefulWidget {
  const VerifyIdentifyPage({super.key});

  @override
  State<VerifyIdentifyPage> createState() => _VerifyIdentifyPageState();
}

class _VerifyIdentifyPageState extends State<VerifyIdentifyPage> {
  TextEditingController password = TextEditingController();

  bool isPasswordValidator = false;
  bool isTapPasswordName = false;
  bool isButtonActive = false;
  bool isIncorrectPassword = false;
  bool observeText = true;

  late Timer _timer;
  int _start = 30;
  bool isLoad = false;
  String otpPin = '';

  String timeToShow = '';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            int minutes = (_start/60).toInt();
            int seconds = (_start%60);
            timeToShow = "${minutes.toString().padLeft(2,"0")}:${seconds.toString().padLeft(2,"0")}";
          });
        }
      },
    );
  }

  void resendOtp() {
    setState(() {
      _start = 30;
      startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 53,
        height: 64,
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 20, color: Color(0xFF606060), fontWeight: FontWeight.w700),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffE6E8E7))
        )
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme =  PinTheme(
        width: 53,
        height: 64,
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 20, color: Color(0xFF606060), fontWeight: FontWeight.w700),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffE6E8E7))
        )
    );
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
         child: Column(
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
                    CustomText(title: 'Verify Identity', fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0D0D0D),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 36,),
            Column(
              children: [
                SvgPicture.asset('assets/more/alertForDel.svg'),
                SizedBox(height: 16,),
                CustomText(title: 'Enter Verification Code', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                SizedBox(height: 12,),
                CustomText(title: 'We\'ve sent a 4-digit code to',
                    textAlign: TextAlign.center,
                    color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 12),
                SizedBox(height: 12,),
                CustomText(title: 'techsupport3@drivado.com',
                    textAlign: TextAlign.center,
                    color: Color(0xFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 12),
                SizedBox(height: 40,),
                CustomText(title: 'Enter 6-digit code',
                    textAlign: TextAlign.center,
                    color: Color(0xFF000000), fontWeight: FontWeight.w400, fontSize: 12),
                SizedBox(height: 12,),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  showCursor: true,
                  onCompleted: (pin) {
                    otpPin = pin;
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(title: _start == 0 ? 'Didn’t receive a code? ' : 'Resend code in ',
                        textAlign: TextAlign.center,
                        color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 12),
                    CustomText(title: _start == 0 ? 'Resend' : timeToShow,
                        textAlign: TextAlign.center,
                        color: AppColors.secondary, fontWeight: FontWeight.w500, fontSize: 12),
                  ],
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: CustomDecorationsCards().baseBackgroundShadow(
                            radius: 8.0,
                            smooth: 1.0,
                            color: const Color(0xFFFEFFF0),
                            width: 0.50,
                            borderColor: const Color(0xFFFFA800)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/more/alertYellow.svg"),
                                      SizedBox(width: 6,),
                                      CustomText(
                                        title: 'Last chance to change your mind',
                                        color: const Color(0xFFFFA800),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      CustomText(title: "Once you click \'Delete Account\', all your data will be permanently\nremoved and cannot be recovered.",
                                          height: 1.4,
                                          color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: CustomDecorationsCards().baseBackgroundShadow(
                            radius: 8.0,
                            smooth: 1.0,
                            color: Color(0xffFFF0F1),
                            width: 0.50,
                            borderColor: Color(0xFFDC3545).withOpacity(0.5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    title: 'What will be deleted:',
                                    color: const Color(0xFF4F0214),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  CustomText(title: "•  Will permanently delete all your data",
                                      height: 1.2,
                                      color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                children: [
                                  CustomText(title: "•  Remove access to your account",
                                      height: 1.2,
                                      color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () async{
                          await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.all(12),
                                contentPadding: const EdgeInsets.only(top: 8, left: 45, right: 45, bottom: 16),
                                backgroundColor:  Colors.white,
                                shape:  SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 12,
                                    cornerSmoothing: 1.0,
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    SvgPicture.asset('assets/more/delPopupSucess.svg', height: 48,),
                                    SizedBox(height: 16,),
                                    CustomText(
                                        title: 'Account Deleted',
                                        textAlign: TextAlign.center,
                                        fontSize: 24,
                                        height: 1.4,
                                        color: Color(0xFF0D0D0D),
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                content: CustomText(
                                    title: 'Your account has been successfully deleted. We\'re sorry to see you go!',
                                    textAlign: TextAlign.center,
                                    fontSize: 16,
                                    height: 1.4,
                                    color: Color(0xFF606060),
                                    fontWeight: FontWeight.w400),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: GestureDetector(
                                      onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                       },
                                      child: Container(
                                          height: 44,
                                          decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.secondary, AppColors.secondary),
                                          alignment: Alignment.center,
                                          child: CustomText(title: 'Close', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 44,
                          width: MediaQuery.of(context).size.width,
                          decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, !isButtonActive ? AppColors.secondary.withOpacity(0.5) : AppColors.secondary, Colors.transparent),
                          alignment: Alignment.center,
                          child: CustomText(title: 'Delete account permanetly', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ))
    );
  }
}