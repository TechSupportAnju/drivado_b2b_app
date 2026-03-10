import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:drivado_b2b_app/screens/auth/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:drivado_b2b_app/screens/auth/forgot_password/bloc/forgot_password_state.dart';
// import 'otp_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPagePageState();
}

class _ForgotPasswordPagePageState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();
  bool isButtonActive = false;
  bool isEmailValidator = false;
  bool isTapEmailName = false;
  bool isEmailValid = true;
  bool isEmailValidShow = true;
  bool isLoad = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.emailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset link has been sent to your email.'),
              ),
            );
            context.read<ForgotPasswordCubit>().clearFlags();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
          }
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state.isLoading;

          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                    decoration: BoxDecoration(
                        color: const Color(0xff190C0C),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/auth/loginbg.png'),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 0,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.keyboard_backspace,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Use mail to reset your\n',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'password',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color: AppColors.secondary)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              CustomText(title: 'Enter your email to reset your password easily.', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                top: 250,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: CustomDecorations().baseBackgroundDecoration(20.0, 1.0, Colors.white, Colors.transparent),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30,),
                            CustomTextField(
                              title: 'Email ID',
                              hintText: 'Enter your email ID',
                              controller: email,
                              isPassword: false,
                              icon: 'null',
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                              onChanged: (val) {
                                isEmailValid = EmailValidator.validate(email.text);
                                if(email.text != '') {
                                  isEmailValidator = false;
                                }else {
                                  isEmailValidator = true;
                                }
                                setState(() {
                                });
                              },
                              onTap: () {
                                isTapEmailName = true;
                                setState(() {
                                });
                              },
                              suffix: false,
                              readOnly: false,
                              astric: true,
                              error: isEmailValidator,),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomButtons(
                                isIcon: false,
                                onTap: () {
                                  final mail = email.text.trim();
                                  final valid = EmailValidator.validate(mail);
                                  if (!valid) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter a valid email address.'),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<ForgotPasswordCubit>().sendResetEmail(mail);
                                }, title: isLoading ? 'Sending...' : 'Continue', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                            const SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (Route<dynamic> route) => false);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Back to ',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: const Color(0xFF606060)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'sign in',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.secondary)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.secondary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // otpBottomSheets(context) {
  //   return showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     context: context,
  //     isScrollControlled: true,
  //     scrollControlDisabledMaxHeightRatio: 2,
  //     builder: (BuildContext context) {
  //       return  OtpBottomSheet(emailId: email.text, isLogin: 'forgot', password: '',);
  //     },
  //   );
  // }
}
