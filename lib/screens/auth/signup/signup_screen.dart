import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/auth/signup/thank_you_screen.dart';
import 'package:drivado_b2b_app/screens/auth/signup/widget/more_less_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/contact_text_field.dart';
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
import 'package:drivado_b2b_app/screens/auth/signup/bloc/signup_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/signup/bloc/signup_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //signup-------------------------
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmEmail = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  bool isFirstValidator = false;
  bool isLastValidator = false;
  bool isEmailValidator = false;
  bool isConfirmEmailValidator = false;
  bool isContactValidator = false;
  bool isTapContactName = false;
  bool isCompanyNameValidator = false;
  bool isAddressValidator = false;
  bool isEmailValid = true;
  bool isEmailValidShow = true;

  bool isLoad = false;
  bool isAgree = false;

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
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ThankYouScreen()),
              );
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is SignupLoading;

            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
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
                              height: 30,
                            ),
                            Row(
                              children: [
                                CustomText(
                                    title:'Sign up to ',
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
                  top: 200,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: CustomDecorations().baseBackgroundDecoration(20.0, 1.0, Colors.white, Colors.transparent),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          child: Column(
                            children: [
                              CustomTextField(
                                title: 'First Name',
                                hintText: 'Enter your first name',
                                controller: firstName,
                                isPassword: false,
                                icon: 'null',
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                onChanged: (val) {
                                  if(firstName.text != '') {
                                    isFirstValidator = false;
                                  }else {
                                    isFirstValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                  // setState(() {
                                  // });
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isFirstValidator,),
                              const SizedBox(height: 12,),
                              CustomTextField(
                                title: 'Last Name',
                                hintText: 'Enter your last name',
                                controller: lastName,
                                isPassword: false,
                                icon: 'null',
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                onChanged: (val) {
                                  if(lastName.text != '') {
                                    isLastValidator = false;
                                  }else {
                                    isLastValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isLastValidator,),
                              const SizedBox(height: 12,),
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
                                  if(isEmailValid && email.text != '') {
                                    isEmailValidator = false;
                                  }else {
                                    isEmailValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isEmailValidator,),
                              const SizedBox(height: 12,),
                              CustomTextField(
                                title: 'Confirm Email ID',
                                hintText: 'Enter your confirm email ID',
                                controller: confirmEmail,
                                isPassword: false,
                                icon: 'null',
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                onChanged: (val) {
                                  if(confirmEmail.text != '') {
                                    isConfirmEmailValidator = false;
                                  }else {
                                    isConfirmEmailValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                  // isTapPassword = true;
                                  // setState(() {
                                  // });
                                },
                                suffix: true,
                                readOnly: false,
                                astric: true,
                                error: isConfirmEmailValidator,
                              ),
                              const SizedBox(height: 12,),
                              CustomTextField(
                                title: 'Company Name',
                                hintText: 'Enter your company name',
                                controller: companyName,
                                isPassword: false,
                                icon: 'null',
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                onChanged: (val) {
                                  if(companyName.text != '') {
                                    isCompanyNameValidator = false;
                                  }else {
                                    isCompanyNameValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                  // isTapPassword = true;
                                  // setState(() {
                                  // });
                                },
                                suffix: true,
                                readOnly: false,
                                astric: true,
                                error: isCompanyNameValidator,
                              ),
                              const SizedBox(height: 12,),
                              ContactTextField(
                                isContactValidator: isContactValidator,
                                isTapContactName: isTapContactName,
                                controller: contactNumber,
                                onTap: () {},
                                onChanged: () {},
                              ),
                              const SizedBox(height: 12,),
                              CustomTextField(
                                title: 'Address',
                                hintText: 'Enter your address',
                                controller: address,
                                maxLine: 4,
                                isPassword: false,
                                icon: 'null',
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                onChanged: (val) {
                                  if(address.text != '') {
                                    isAddressValidator = false;
                                  }else {
                                    isAddressValidator = true;
                                  }
                                  setState(() {
                                  });
                                },
                                onTap: () {
                                  // isTapPassword = true;
                                  // setState(() {
                                  // });
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isAddressValidator,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: ( ){
                                      setState(() {
                                        isAgree = !isAgree;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          isAgree ? Icons.check_box :  Icons.check_box_outline_blank_rounded,
                                          color: isAgree ? AppColors.secondary : Color(0xFF606060),
                                          size: 17,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width /1.2,
                                          child: MoreLessText(
                                            text: "I consent to receiving digital and telephone communication from Drivado regarding its services. I understand I may change my preference or opt-out of communication with Drivado at anytime using the unsubscribe link provided in Drivado email communication.",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              CustomButtons(
                                  isIcon: false,
                                  onTap: () {
                                    final f = firstName.text.trim();
                                    final l = lastName.text.trim();
                                    final e = email.text.trim();
                                    final a = address.text.trim();
                                    final cN = companyName.text.trim();
                                    final cE = confirmEmail.text.trim();
                                    final mobile = contactNumber.text.trim();

                                    final valid = f.isNotEmpty &&
                                        l.isNotEmpty &&
                                        e.isNotEmpty &&
                                        cE.isNotEmpty &&
                                        cN.isNotEmpty &&
                                        a.isNotEmpty &&
                                        mobile.isNotEmpty &&
                                        EmailValidator.validate(e) &&
                                        e == cE &&
                                        isAgree;

                                    if (!valid) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please fill all required fields correctly and accept consent.'),
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<SignupCubit>().signup(
                                      firstName: f,
                                      lastName: l,
                                      email: e,
                                      mobile: mobile,
                                      address: address.text,
                                      companyName: companyName.text
                                    );
                                  },
                                     title: isLoading ? 'Signing up...' : 'Sign up',
                                     color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Already have an account ?  ',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xff606060)),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Login',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.secondary)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
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
      ),

    );
  }
}
