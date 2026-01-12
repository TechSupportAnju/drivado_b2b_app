import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:drivado_b2b_app/models/country_code/country_code_data.dart';
import 'package:drivado_b2b_app/models/country_code/country_code_model.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_user.dart';
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
  String countryCode = '+91';

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

  List countrtyList = [];
  List<CountryCodeModel> countrylisttt = [];
  TextEditingController country = TextEditingController();
  List<CountryCodeModel> filterList = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // TODO: implement initState
    super.initState();
    fetchEditValue();
    fetchCountryCode();
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

  Future<void> fetchCountryCode() async {
    countrtyList.clear();
    countrylisttt.clear();
    countrylisttt = countryCodeData;
    filterList = List.from(countrylisttt);
    if (countrylisttt.isNotEmpty) {
      for (var element in countrylisttt) {
        countrtyList.add(element.dialCode);
      }
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
              userEmailTextField(context, 'Username (Email ID)', 'Enter your username (Email ID)', userEmailId, true),
              isUserEmailValidator ? const  SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isUserEmailValidator , userEmailId.text == '' ? 'Please enter your confirm email id': 'Email id and Confirm email id should be same'),
              const SizedBox(
                height: 16,
              ),
              firstTextField(context, 'First name', 'Enter your first name', firstName, true),
              isFirstNameValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isFirstNameValidator, 'Please enter first name'),
              const SizedBox(
                height: 16,
              ),
              lastTextField(context, 'Last name', 'Enter your last name', lastName, true),
              isLastNameValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isLastNameValidator, 'Please enter last name'),
              const SizedBox(
                height: 16,
              ),
              _contactTextField(context),
              isContactValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isContactValidator, 'Please enter your contact number'),
              const SizedBox(
                height: 16,
              ),
              emailTextField(context, 'Email ID', 'Enter your email id', emailId, true),
              isEmailValidator || !isEmailValidShow ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(emailId.text =='' ? isEmailValidator : !isEmailValidShow, emailId.text =='' ? 'Please enter your email id' : 'Please enter valid email id'),
              const SizedBox(
                height: 16,
              ),
              !widget.isEdit
              ? passwordTextField(context, 'Password', 'Enter your password', password, true)
              :  CustomTextField(
                readOnly: false,
                title: 'User Markup',
                hintText: 'Enter user markup',
                icon: 'null',
                astric: false,
                controller: userMarkup,
                height: 52.0,
                width:
                MediaQuery.of(context).size.width,
                onTap: () async {
                },
                onChanged: (val) {},
                suffix: false, isPassword: false,
              ),
              isPasswordValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isPasswordValidator, 'Please enter your password'),
              const SizedBox(
                height: 16,
              ),
              !widget.isEdit
                  ? confirmPasswordTextField(context, 'Confirm Password', 'Enter your confirm password', confirmPassword, true)
              : CustomTextField(
                readOnly: false,
                title: 'User Discount',
                hintText: 'Enter user discount',
                icon: 'null',
                astric: false,
                controller: userDiscount,
                height: 52.0,
                width:
                MediaQuery.of(context).size.width,
                onTap: () async {
                },
                onChanged: (val) {},
                suffix: false, isPassword: false,
              ),
              isConfirmPasswordValidator || password.text != confirmPassword.text  ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(password.text == '' ? isConfirmPasswordValidator : password.text != confirmPassword.text, confirmPassword.text != '' ? password.text != confirmPassword.text ? 'Password and confirm password must be same' : 'Please enter your confirm password': 'Please enter your confirm password'),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                 if(isButtonActive && !widget.isEdit){
                   showSucessDialog(context);
                 }
                 if(widget.isEdit && isButtonActive){
                   Navigator.pop(context);
                 }
                },
                child: Container(
                  height: 48,
                  decoration: ShapeDecoration(
                    color: isButtonActive ? AppColors.secondary : AppColors.secondary.withOpacity(0.44),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 1,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                      title: widget.isEdit ? 'Update' : 'Add user',
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

  //-------First Name Text Field-----------------------------
  Widget firstTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isFirstNameValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
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
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapFirstName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(firstName.text != '') {
              isFirstNameValidator = false;
            } else {
              isFirstNameValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(firstName.text != '') {
              isFirstNameValidator = false;
            } else {
              isFirstNameValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapFirstName = true;
          if(lastName.text == '' && isTapLastName) {
            isLastNameValidator = true;
            isTapLastName = false;
          }  if(emailId.text == '' && isTapEmailName) {
            isEmailValidator = true;
            isTapEmailName = false;
          }  if(phoneNumber.text == '' && isTapContactName) {
            isContactValidator = true;
            isTapContactName = false;
          } if(userEmailId.text == '') {
            isUserEmailValidator = true;
            isTapUserEmailName = false;
          } if(password.text == '' && isTapPasswordName) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          } if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

  //-------Last Name Text Field-----------------------------
  Widget lastTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isLastNameValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
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
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapLastName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(lastName.text != '') {
              isLastNameValidator = false;
            } else {
              isLastNameValidator = true;
            }
            setState(() {
            });
          } else {
            isButtonActive = false;
            if(lastName.text != '') {
              isLastNameValidator = false;
            } else {
              isLastNameValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapLastName = true;
          if(firstName.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          } if(emailId.text == '' && isTapEmailName) {
            isEmailValidator = true;
            isTapEmailName = false;
          }  if(phoneNumber.text == '' && isTapContactName) {
            isContactValidator = true;
            isTapContactName = false;
          } if(userEmailId.text == '' ) {
            isUserEmailValidator = true;
            isTapUserEmailName = false;
          } if(password.text == '' && isTapPasswordName) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          } if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

  // -------Email Id Text Field-----------------------------
  Widget emailTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isEmailValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        // textCapitalization: TextCapitalization.sentences,
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapEmailName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          isEmailValid = EmailValidator.validate(emailId.text);
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(emailId.text != '') {
              isEmailValidator = false;
            } else {
              isEmailValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(emailId.text != '') {
              isEmailValidator = false;
            } else {
              isEmailValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValidShow = true;
          isTapEmailName = true;
          if(userEmailId.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(firstName.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(lastName.text == '') {
            isLastNameValidator = true;
            isTapLastName = false;
          }
          if(phoneNumber.text == '') {
            isContactValidator = true;
            isTapContactName = false;
          }
          if(password.text == '' && isTapPasswordName) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          }
          if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

  // -------Confirm Email Id Text Field-----------------------------
  Widget userEmailTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isUserEmailValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        // textCapitalization: TextCapitalization.sentences,
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapUserEmailName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          isEmailValid = EmailValidator.validate(emailId.text);
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(userEmailId.text != '' ) {
              isUserEmailValidator = false;
            } else {
              isUserEmailValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(userEmailId.text != '' ) {
              isUserEmailValidator = false;
            } else {
              isUserEmailValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapUserEmailName = true;
          if(firstName.text == '' && isTapFirstName) {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(lastName.text == '' && isTapLastName) {
            isLastNameValidator = true;
            isTapLastName = false;
          }
          if(emailId.text == '' && isTapEmailName) {
            isEmailValidator = true;
            isTapEmailName = false;
          }
          if(phoneNumber.text == '' && isTapContactName) {
            isContactValidator = true;
            isTapContactName = false;
          }
          if(password.text == '' && isTapPasswordName) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          }
          if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

  // -------Password Text Field-----------------------------
  Widget passwordTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isPasswordValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        obscureText: observeText,
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints().loosen(),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  observeText = !observeText;
                });
              },
              child: SvgPicture.asset(
                  observeText ? 'assets/auth/eyeHide.svg' : 'assets/auth/eye.svg'),
            ),
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapPasswordName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          isEmailValid = EmailValidator.validate(emailId.text);
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(password.text != '') {
              isPasswordValidator = false;
            } else {
              isPasswordValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(password.text != '') {
              isPasswordValidator = false;
            } else {
              isPasswordValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapPasswordName = true;
          if(firstName.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(lastName.text == '') {
            isLastNameValidator = true;
            isTapLastName = false;
          }
          if(emailId.text == '' ) {
            isEmailValidator = true;
            isTapEmailName = false;
          }
          if(phoneNumber.text == '') {
            isContactValidator = true;
            isTapContactName = false;
          }
          if(userEmailId.text == '' ) {
            isUserEmailValidator = true;
            isTapUserEmailName = false;
          }
          if(confirmPassword.text == '' && isTapConfirmPasswordName) {
            isConfirmPasswordValidator = true;
            isTapConfirmPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

  // -------Confirm Password Text Field-----------------------------
  Widget confirmPasswordTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isConfirmPasswordValidator || password.text != confirmPassword.text ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        // textCapitalization: TextCapitalization.sentences,
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        obscureText: observeTextC,
        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 14),
        decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints().loosen(),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  observeTextC = !observeTextC;
                });
              },
              child: SvgPicture.asset(
                  observeTextC ? 'assets/auth/eyeHide.svg' : 'assets/auth/eye.svg'),
            ),
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, isTapConfirmPasswordName ? -5.0 : -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: '$title',
                    style:  GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor, fontWeight: FontWeight.w400),
                    children:  isStarShow ? [
                      const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.secondary,
                          )
                      )
                    ] : null
                ),),
            ),
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textFieldTextColor, fontSize: 13),
            hintText: '$hintText'
        ),
        onChanged: (val) {
          isEmailValid = EmailValidator.validate(emailId.text);
          if(firstName.text != '' && lastName.text != '' && phoneNumber.text != '' && isEmailValid && emailId.text != '' && userEmailId.text != '' && phoneNumber.text != '' && password.text != '' && confirmPassword.text == password.text) {
            isButtonActive = true;
            if(confirmPassword.text != '') {
              isConfirmPasswordValidator = false;
            } else {
              isConfirmPasswordValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(password.text != '') {
              isConfirmPasswordValidator = false;
            } else {
              isConfirmPasswordValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapConfirmPasswordName = true;
          if(firstName.text == '') {
            isFirstNameValidator = true;
            isTapFirstName = false;
          }
          if(lastName.text == '') {
            isLastNameValidator = true;
            isTapLastName = false;
          }
          if(emailId.text == '') {
            isEmailValidator = true;
            isTapEmailName = false;
          }
          if(phoneNumber.text == '') {
            isContactValidator = true;
            isTapContactName = false;

          }
          if(userEmailId.text == '' ) {
            isUserEmailValidator = true;
            isTapUserEmailName = false;

          }
          if(password.text == '' ) {
            isPasswordValidator = true;
            isTapPasswordName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  // //---------------------------------------------------

  //-----------------Error Message----------------------
  Widget _validationMessage(bool isVisible, String message) {
    return isVisible?
    Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        children: [
          Text(
            message,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 11, color: Colors.red),
          ),
        ],
      ),
    )
        : Container();
  }
//--------------------------------------------------


  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildCountryCodeDialog(context);
      },
    );
  }

  Dialog _buildCountryCodeDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter newState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: CustomDecorations().baseBackgroundDecoration(
                  5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _countrySearchField(context, newState),
                    _countryList(context, newState),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _countrySearchField(BuildContext context, StateSetter newState) {
    return Container(
      decoration: CustomDecorations().baseBackgroundDecoration(
          5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
      // BoxDecoration(color: const Color(0xFFFBFBFB), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/user_management/search.svg',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: country,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for countries',
                  hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: const Color(0xFF828282)),
                ),
                onChanged: (val) async {
                  filterList.clear();
                  if (val.isNotEmpty) {
                    filterList = countrylisttt
                        .where((element) =>
                    element.dialCode.contains(val) ||
                        element.name
                            .toLowerCase()
                            .contains(val.toLowerCase()) ||
                        element.code.contains(val))
                        .toList();
                  } else {
                    filterList = List.from(countrylisttt);
                  }
                  newState(() {
                    // shouldAutoFocus = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _countryList(BuildContext context, StateSetter newState) {
    return Container(
      height: 250,
      color: const Color(0xFFFBFBFB),
      // width: MediaQuery.of(context).size.width / 1.2,
      child: ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              //context.pop();
              Navigator.pop(context);
              setState(() {
                countryCode = filterList[index].dialCode;
              });
              country.clear();
              filterList = List.from(countrylisttt);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkSVGImage(
                            'https://country-code-au6g.vercel.app/${filterList[index].image}',
                            // placeholder: const CustomSingleLineShimmer(height: 20, width: 20,),
                            errorWidget: const Icon(Icons.error, color: Colors.red),
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.cover,
                            fadeDuration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          filterList[index].name,
                          overflow: TextOverflow.ellipsis,
                          style:
                          GoogleFonts.plusJakartaSans(color: Colors.black),
                        ),
                      ),
                      const Spacer(),
                      Text(filterList[index].dialCode,
                          style:
                          GoogleFonts.plusJakartaSans(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  //sucess popup ----------------------
  showSucessDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, newState) {
          // Start a timer to update progress
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Colors.transparent),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 8,
                            child: Center(child: SvgPicture.asset('assets/user_management/addUserPopupCheck.svg'))),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset('assets/user_management/closeAddUser.svg')),
                              const SizedBox(height: 35,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24,),
                    const CustomText(title: 'Congratulations!',
                        textAlign: TextAlign.center,
                        color: Color(0xFF101828), fontWeight: FontWeight.w600, fontSize: 24),
                    const SizedBox(height: 8,),
                    RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'User ',
                    style:  GoogleFonts.plusJakartaSans(
                        color: Color(0xFF344054), fontSize: 16,fontWeight: FontWeight.w400
                    ),
                    children:  [
                      TextSpan(
                          text: emailId.text,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.secondary,
                              fontSize: 16,fontWeight: FontWeight.w500
                          )
                      ),
                      TextSpan(
                          text: ' added successfully!',
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xFF344054),
                              fontSize: 16,fontWeight: FontWeight.w400
                          )
                      )
                    ]
                ),),
                    const SizedBox(height: 25,),
                    InkWell(
                     onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewUserPage()));
                     },
                     child: Container(
                       height: 44,
                       decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, AppColors.secondary, Colors.transparent),
                       alignment: Alignment.center,
                       child: const CustomText(title: 'Know more', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                     ),
                   )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
