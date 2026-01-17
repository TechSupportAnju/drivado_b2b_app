
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

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }


  @override
  void dispose() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
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
                CustomText(title: 'Final Verification', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                SizedBox(height: 12,),
                CustomText(title: 'Please enter your password to complete the account\ndeletion process',
                    textAlign: TextAlign.center,
                    color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 12),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        height:52,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: SmoothRectangleBorder(
                            side: BorderSide(color: Color(0xffE6E8E7)),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 10,
                              cornerSmoothing: 1,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 14, top: 3.5),
                        child: TextField(
                          onTapOutside: (event) {
                            if(password.text == '') {
                              setState(() {
                              });
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          textCapitalization: TextCapitalization.sentences,
                          controller: password,
                          cursorHeight: 15,
                          obscureText: observeText,
                          autocorrect: false,
                          enableSuggestions: false,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13,height: 1.0, color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints().loosen(),
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  observeText = !observeText;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0, top: 0, ),
                                child: SvgPicture.asset(
                                    observeText ? 'assets/auth/eyeHide.svg' : 'assets/auth/eye.svg'),
                              ),
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.zero,
                            label: Container(
                              transform: Matrix4.translationValues(0.0, isTapPasswordName ? -5.0 : -2.0, 0.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Password',
                                    style:  GoogleFonts.plusJakartaSans(
                                        color: AppColors.textFieldTextColor, fontSize: 14,fontWeight: FontWeight.w400),
                                    children:  [
                                      TextSpan(
                                          text: ' *',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.secondary,
                                          )
                                      )
                                    ]
                                ),),
                            ),
                            // floatingLabelAlignment: FloatingLabelAlignment.start,
                            isDense: true,
                            hintText: 'Enter your password',
                            // labelText: 'Password*',
                            hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                            // labelStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textFieldTextColor),
                          ),
                          onChanged: (val) {
                            if(password.text != '') {
                              isButtonActive = true;
                            }else {
                              isButtonActive = false;
                            }
                            setState(() {
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: CustomDecorationsCards().baseBackgroundShadow(
                            radius: 8.0,
                            smooth: 1.0,
                            color: const Color(0xFFFEFFF0),
                            width: 0.50,
                            borderColor: const Color(0xFFFFA800)
                          //boxShadowColor:  Color(0x19000000),
                          // blurRadius: 0.0,
                          // x: 0, y: 0
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