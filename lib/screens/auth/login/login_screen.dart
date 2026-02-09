
import 'package:drivado_b2b_app/screens/auth/forgot_password/forgot_pasword.dart';
import 'package:drivado_b2b_app/screens/auth/signup/signup_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  //login-------------------------
  TextEditingController emailLogin = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isButtonActive = false;
  bool isEmailValidator = false;
  bool isTapEmailName = false;
  bool isPasswordValidator = false;
  bool isTapPassword = false;
  bool observeText = true;

  bool isEmailValid = true;
  bool isEmailValidShow = true;

  bool isLoad = false;

  bool isRemember = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  decoration: BoxDecoration(
                      color: Color(0xff190C0C),
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
                          height: 70,
                        ),
                        Row(
                          children: [
                            CustomText(
                                title:'Login to',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 32),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'your ',
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Account',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32,
                                          color: AppColors.secondary)),
                                ],
                              ),
                            )
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
                          horizontal: 16.0, vertical: 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          CustomTextField(
                              title: 'Email ID',
                              hintText: 'Enter your email ID',
                              controller: emailLogin,
                              isPassword: false,
                              icon: 'null',
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                              onChanged: (val) {
                              isEmailValid = EmailValidator.validate(emailLogin.text);
                              if(isEmailValid && emailLogin.text != '') {
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
                          const SizedBox(height: 12,),
                          CustomTextField(
                              title: 'Password',
                              hintText: 'Enter your password',
                              controller: password,
                              isPassword: observeText,
                              icon: 'null',
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                            onChanged: (val) {
                              if(password.text != '') {
                                isPasswordValidator = false;
                              }else {
                                isPasswordValidator = true;
                              }
                              setState(() {
                              });
                            },
                            onTap: () {
                              // isTapPassword = true;
                              // setState(() {
                              // });
                            },
                              onTapSuffix: () {
                                setState(() {
                                  observeText = !observeText;
                                });
                              },
                              suffix: true,
                              readOnly: false,
                              astric: true,
                              error: isPasswordValidator,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: ( ){
                                  setState(() {
                                    isRemember = !isRemember;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isRemember ? Icons.check_box :  Icons.check_box_outline_blank_rounded,
                                      color: isRemember ? AppColors.secondary : Color(0xFF606060),
                                      size: 17,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const CustomText(
                                        title: 'Remember me',
                                        color: Color(0xff606060),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                                },
                                child: const CustomText(
                                    title: 'Forgot Password?',
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomButtons(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RootShell()));
                          }, title: 'Log in', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don’t have an account ?  ',
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff606060)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Sign up',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: AppColors.secondary)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),

    );
  }
}
