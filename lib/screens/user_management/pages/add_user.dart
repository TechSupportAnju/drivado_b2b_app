import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/country_code_dialog_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/sucess_popup.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserPage extends StatefulWidget {
  final bool isEdit;
  const AddUserPage({super.key, required this.isEdit});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {

  //add user controller--------------------
  TextEditingController userEmailId = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController userMarkup = TextEditingController();
  TextEditingController userDiscount = TextEditingController();

  bool isLogin = true;

  bool isButtonActive = false;
  bool isFirstNameValidator = false;
  bool isLastNameValidator = false;
  bool isContactValidator = false;
  bool isEmailValidator = false;
  bool isUserEmailValidator = false;
  bool isConfirmPasswordValidator = false;
  bool isPasswordValidator = false;

  bool isTapFirstName = false;
  bool isTapLastName = false;
  bool isTapEmailName = false;
  bool isTapContactName = false;
  bool isTapUserEmailName = false;
  bool isTapConfirmPasswordName = false;
  bool isTapPasswordName = false;

  bool isEmailValid = true;
  bool isEmailValidShow = true;

  bool observeText = true;
  bool observeTextC = true;
  bool isRemember = false;



  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // TODO: implement initState
    super.initState();
    fetchEditValue();
  }

  fetchEditValue() {
    if(widget.isEdit) {
      userEmailId = TextEditingController(text: 'test@drivado.com');
      firstName = TextEditingController(text: 'Sumit');
      lastName = TextEditingController(text: 'Modi');
      phoneNumber = TextEditingController(text: '9876543210');
      emailId = TextEditingController(text: 'test@drivado.com');
      isTapContactName = true;
      isButtonActive = true;
    }
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
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff190C0C),
        centerTitle: true,
        leading:GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset('assets/user_management/back.svg'),
            )),
        title:  const CustomText(title: 'Add User', color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 20),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CustomTextField(
                  title: 'Username (Email ID)',
                  hintText: 'Enter your username (Email ID)',
                  controller: userEmailId,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: false,
                  readOnly: false,
                  astric: false,
                  isPassword: isUserEmailValidator),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  title: 'First name',
                  hintText: 'Enter your first name',
                  controller: firstName,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: false,
                  readOnly: false,
                  astric: false,
                  isPassword: isFirstNameValidator),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  title: 'Last name',
                  hintText: 'Enter your last name',
                  controller: lastName,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: false,
                  readOnly: false,
                  astric: false,
                  isPassword: false),
              const SizedBox(
                height: 16,
              ),
              _contactTextField(context),
              // isContactValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              // _validationMessage(isContactValidator, 'Please enter your contact number'),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  title: 'Email ID',
                  hintText: 'Enter your email id',
                  controller: emailId,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: false,
                  readOnly: false,
                  astric: false,
                  isPassword: isEmailValidator),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: password,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: true,
                  readOnly: false,
                  astric: false,
                  isPassword: isPasswordValidator),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  title: 'Confirm Password',
                  hintText: 'Enter your confirm password',
                  controller: confirmPassword,
                  icon: 'null',
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  onChanged: () {},
                  onTap: () {},
                  suffix: true,
                  readOnly: false,
                  astric: false,
                  isPassword: isConfirmPasswordValidator),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                 if(firstName.text != '' && lastName.text != '' && userEmailId.text != '' && emailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text){
                   showSucessDialog(context, emailId.text);
                 } else {
                   setState(() {
                     // firstName.text =
                   });
                 }
                },
                child: Container(
                  height: 48,
                  decoration: ShapeDecoration(
                    color: AppColors.secondary,
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 1,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                      title: 'Add user',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----For country code & contact number text filed----
  Widget _contactTextField(BuildContext context) {
    return Container(
      height: 52,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isContactValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: phoneNumber,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        keyboardType: TextInputType.number,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 13),
        decoration: InputDecoration(
            prefixIcon: !isTapContactName ? Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(context), // Positioned country code picker
              ],
            ) : null,
            prefix: isTapContactName ? Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(context), // Positioned country code picker
              ],
            ) : null,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapContactName ? -8.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: 'Contact number',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400, fontSize: 13),
                    children:  const [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          )
                      )
                    ]
                ),),
            ),
            border: InputBorder.none,
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: 'Enter your contact number'
        ),
        onChanged: (val) {
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(phoneNumber.text != '') {
              isContactValidator = false;
            } else {
              isContactValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(phoneNumber.text != '') {
              isContactValidator = false;
            } else {
              isContactValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapContactName = true;
          if(firstName.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(lastName.text == '') {
            isLastNameValidator = true;
            isTapLastName = false;
          }
          if(emailId.text == '' && isTapEmailName) {
            isEmailValidator = true;
            isTapEmailName = false;
          }
          if(userEmailId.text == '') {
            isUserEmailValidator = true;
            isTapUserEmailName = false;
          }
          if(password.text == '' && isTapPasswordName) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          }if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  Widget _countryCodePicker(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _showDropdown(context),
      child: SizedBox(
        width:countryCode.length > 4
          ? 69
          : countryCode.length > 3
        ? 60
        : 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            countryCode.isEmpty ?
            const CircularProgressIndicator()
                : Text(
                countryCode, style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF6A6A6A), fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(width: 2),
            const Icon(Icons.expand_more_sharp, color: Color(0xff949494), size: 20),
          ],
        ),
      ),
    );
  }
  //--------------------------------------------------

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CountryCodeDialogWidget();
      },
    );
  }



}
