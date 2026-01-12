import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {

  TextEditingController newPassword = TextEditingController();

  bool observeText = false;

  bool isButtonActiveUpdate = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff190C0C),
        centerTitle: true,
        leading:GestureDetector(
            onTap: () {
              //context.pop();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset('assets/user_management/back.svg'),
            )),
        title:  const CustomText(title: 'Update Password', color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 20),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17),
        child: Container(
          decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xFFEDF1F3)),
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 52,
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
                padding: const EdgeInsets.only(left: 14, top: 4.5),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: newPassword,
                  cursorHeight: 15,
                  obscureText: observeText,
                  autocorrect: false,
                  enableSuggestions: false,
                  style: GoogleFonts.plusJakartaSans(fontSize: 13,height: 1.0, color: Color(0xff191919), fontWeight: FontWeight.w500),
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
                    label: Container(
                      transform: Matrix4.translationValues(0.0, isButtonActiveUpdate ? -5.0 : -3.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'New Password',
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
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    isDense: true,
                    hintText: 'Enter your new password',
                    // labelText: 'Password*',
                    hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                    // labelStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textFieldTextColor),
                  ),
                  onChanged: (val) {
                    if(newPassword.text != '') {
                      isButtonActiveUpdate = true;
                    } else {
                      isButtonActiveUpdate = false;
                    }
                    setState(() {
                    });
                  },
                ),
              ),
              SizedBox(height: 12,),
              Container(
                alignment: Alignment.center,
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, isButtonActiveUpdate ? AppColors.secondary : AppColors.secondary.withOpacity(0.44), isButtonActiveUpdate ? AppColors.secondary : Colors.transparent),
                child: CustomText(title: 'Update', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
              )
            ],
          ),
        ),
      )
    );
  }

}
