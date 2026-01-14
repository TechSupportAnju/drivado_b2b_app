import 'dart:async';
import 'package:drivado_b2b_app/screens/auth/forgot_password/new_password_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpBottomSheet extends StatefulWidget {
  final emailId, password;
  final String isLogin;
  const OtpBottomSheet({super.key,required this.isLogin, required this.emailId, required this.password});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  late Timer _timer;
  int _start = 120;
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
      _start = 120;
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
    return Container(
      height: MediaQuery.of(context).size.height/1.2,
      width: MediaQuery.of(context).size.width,
      decoration: CustomDecorations().baseBackgroundDecoration(20.0, 1.0, Colors.white, Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24,),
            Row(
              children: [
                CustomText(title: 'Check Your Email', color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 20),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CustomText(title: 'We\'ve sent a verification code to', color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 14,),
              ],
            ),
            SizedBox(height: 40,),
            CustomText(title: '${widget.emailId}', color: Color(0xFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 16, textAlign: TextAlign.center),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: CustomText(title: "Please check your email enter the 6-digit code to activate your account.",
                  color: Color(0xFF606060),
                  fontWeight: FontWeight.w400, fontSize: 12,  textAlign: TextAlign.center),
            ),
            SizedBox(height: 40,),
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
            SizedBox(height: 32,),
            GestureDetector(
              onTap: () {
                if(_start == 0) {
                  resendOtp();
                }
              },
              child: RichText(
                text: TextSpan(
                  text: 'Didn’t receive a code? ',
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF606060)),
                  children: <TextSpan>[
                    TextSpan(
                        text: _start == 0 ? 'Resend' : timeToShow,
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.secondary)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32,),
            CustomButtons(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
            }, title: 'Continue', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: RichText(
                text: TextSpan(
                  text: 'Wrong email address? ',
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: Color(0xFF606060)),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Edit email',
                        style: GoogleFonts.plusJakartaSans(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}