import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/auth/signup/thank_you_screen.dart';
import 'package:drivado_b2b_app/screens/auth/signup/widget/more_less_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/contact_text_field.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_toaster.dart';
import 'package:drivado_b2b_app/screens/common_widgets/form_error_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivado_b2b_app/screens/auth/signup/repositories/sign_up_repository.dart';

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
  String? emailErrorText;
  String? confirmEmailErrorText;
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? companyNameErrorText;
  String? addressErrorText;
  String? contactErrorText;

  bool isLoad = false;
  bool isAgree = false;
  final SignupRepository _signupRepository = SignupRepository();

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
                                  if (firstName.text.isEmpty) {
                                    isFirstValidator = true;
                                    firstNameErrorText = 'Please enter your first name';
                                  } else {
                                    isFirstValidator = false;
                                    firstNameErrorText = null;
                                  }
                                  setState(() {});
                                },
                                onTap: () {
                                  // setState(() {
                                  // });
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isFirstValidator,),
                              FormErrorText(text: firstNameErrorText),
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
                                  if (lastName.text.isEmpty) {
                                    isLastValidator = true;
                                    lastNameErrorText = 'Please enter your last name';
                                  } else {
                                    isLastValidator = false;
                                    lastNameErrorText = null;
                                  }
                                  setState(() {});
                                },
                                onTap: () {
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isLastValidator,),
                              FormErrorText(text: lastNameErrorText),
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
                                  if (email.text.isEmpty) {
                                    isEmailValidator = true;
                                    emailErrorText = 'Please enter your email ID';
                                  } else if (!isEmailValid) {
                                    isEmailValidator = true;
                                    emailErrorText = 'Please enter a valid email ID';
                                  } else {
                                    isEmailValidator = false;
                                    emailErrorText = null;
                                  }
                                  setState(() {});
                                },
                                onTap: () {
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                              error: isEmailValidator,),
                              FormErrorText(text: emailErrorText),
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
                                  if (confirmEmail.text.isEmpty) {
                                    isConfirmEmailValidator = true;
                                    confirmEmailErrorText = 'Please enter your confirm email ID';
                                  } else if (confirmEmail.text.trim() != email.text.trim()) {
                                    isConfirmEmailValidator = true;
                                    confirmEmailErrorText = 'Email and confirm email must be same';
                                  } else {
                                    isConfirmEmailValidator = false;
                                    confirmEmailErrorText = null;
                                  }
                                  setState(() {});
                                },
                                onTap: () {
                                  // isTapPassword = true;
                                  // setState(() {
                                  // });
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isConfirmEmailValidator,
                              ),
                              FormErrorText(text: confirmEmailErrorText),
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
                                  if (companyName.text.isEmpty) {
                                    isCompanyNameValidator = true;
                                    companyNameErrorText = 'Please enter your company name';
                                  } else {
                                    isCompanyNameValidator = false;
                                    companyNameErrorText = null;
                                  }
                                  setState(() {});
                                },
                                onTap: () {
                                  // isTapPassword = true;
                                  // setState(() {
                                  // });
                                },
                                suffix: false,
                                readOnly: false,
                                astric: true,
                                error: isCompanyNameValidator,
                              ),
                              FormErrorText(text: companyNameErrorText),
                              const SizedBox(height: 12,),
                              ContactTextField(
                                isContactValidator: isContactValidator,
                                isTapContactName: isTapContactName,
                                controller: contactNumber,
                              onTap: () {
                                setState(() {
                                  isTapContactName = true;
                                });
                              },
                              onChanged: () {
                                if (contactNumber.text.isEmpty) {
                                  isContactValidator = true;
                                  contactErrorText = 'Please enter your contact number';
                                } else {
                                  isContactValidator = false;
                                  contactErrorText = null;
                                }
                                setState(() {});
                              },
                              ),
                              FormErrorText(text: contactErrorText),
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
                                  if (address.text.isEmpty) {
                                    isAddressValidator = true;
                                    addressErrorText = 'Please enter your address';
                                  } else {
                                    isAddressValidator = false;
                                    addressErrorText = null;
                                  }
                                  setState(() {});
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
                              FormErrorText(text: addressErrorText),
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
                                  onTap: () async {
                                    final f = firstName.text.trim();
                                    final l = lastName.text.trim();
                                    final e = email.text.trim();
                                    final a = address.text.trim();
                                    final cN = companyName.text.trim();
                                    final cE = confirmEmail.text.trim();
                                    final mobile = contactNumber.text.trim();

                                    setState(() {
                                      isFirstValidator = f.isEmpty;
                                      firstNameErrorText =
                                          isFirstValidator ? 'Please enter your first name' : null;

                                      isLastValidator = l.isEmpty;
                                      lastNameErrorText =
                                          isLastValidator ? 'Please enter your last name' : null;

                                      final emailValid = EmailValidator.validate(e);
                                      if (e.isEmpty) {
                                        isEmailValidator = true;
                                        emailErrorText = 'Please enter your email ID';
                                      } else if (!emailValid) {
                                        isEmailValidator = true;
                                        emailErrorText = 'Please enter a valid email ID';
                                      } else {
                                        isEmailValidator = false;
                                        emailErrorText = null;
                                      }

                                      if (cE.isEmpty) {
                                        isConfirmEmailValidator = true;
                                        confirmEmailErrorText =
                                            'Please enter your confirm email ID';
                                      } else if (cE != e) {
                                        isConfirmEmailValidator = true;
                                        confirmEmailErrorText =
                                            'Email and confirm email must be same';
                                      } else {
                                        isConfirmEmailValidator = false;
                                        confirmEmailErrorText = null;
                                      }

                                      isCompanyNameValidator = cN.isEmpty;
                                      companyNameErrorText = isCompanyNameValidator
                                          ? 'Please enter your company name'
                                          : null;

                                      isAddressValidator = a.isEmpty;
                                      addressErrorText =
                                          isAddressValidator ? 'Please enter your address' : null;

                                      isContactValidator = mobile.isEmpty;
                                      contactErrorText = isContactValidator
                                          ? 'Please enter your contact number'
                                          : null;
                                    });

                                    final allValid = !isFirstValidator &&
                                        !isLastValidator &&
                                        !isEmailValidator &&
                                        !isConfirmEmailValidator &&
                                        !isCompanyNameValidator &&
                                        !isAddressValidator &&
                                        !isContactValidator &&
                                        isAgree;

                                    if (!allValid) {
                                      if (!isAgree) {
                                        AppToast.showError(
                                          context,
                                          'Please fill all required fields correctly and accept consent.',
                                        );
                                      }
                                      return;
                                    }

                                    setState(() {
                                      isLoad = true;
                                    });

                                    try {
                                      await _signupRepository.SignupWithPassword(
                                        firstName: f,
                                        lastName: l,
                                        email: e,
                                        companyName: cN,
                                        address: a,
                                        mobile: mobile,
                                      );
                                      if (!mounted) return;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ThankYouScreen(),
                                        ),
                                      );
                                    } catch (e) {
                                      if (!mounted) return;
                                      AppToast.showError(context, e);
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          isLoad = false;
                                        });
                                      }
                                    }
                                  },
                                  title: isLoad ? 'Signing up...' : 'Sign up',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
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
                if (isLoad)
                  Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.secondary),
                    ),
                  ),
              ],
            ),
      ),

    );
  }
}
