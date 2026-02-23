import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/contact_text_field.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/sucess_popup.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              ContactTextField(
                isContactValidator: isContactValidator,
                isTapContactName: isTapContactName,
                controller: phoneNumber,
                onTap: () {},
                onChanged: () {},
              ),
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

}
