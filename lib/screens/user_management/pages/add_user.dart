import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/contact_text_field.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/common_widgets/form_error_text.dart';
import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/sucess_popup.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/services/user_management/add_child_user_repository.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/add_child_user_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/add_child_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/add_child_user_state.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  String? usernameErrorText;
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? contactErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;



  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // TODO: implement initState
    super.initState();
    fetchEditValue();
  }

  /// Reloads manage-users / manage-company data on the parent screen ([UserMangementPage]).
  Future<void> _refreshSingleCompanyList(BuildContext context) async {
    final profile = context.read<UserInformationBloc>().state;
    if (profile is! UserInformationLoaded) return;
    final id = profile.userData.singleCompanyQueryId.trim();
    if (id.isEmpty) return;
    final token = await AuthService.getAccessToken();
    if (token == null || token.trim().isEmpty) return;
    if (!context.mounted) return;
    context.read<SingleCompanyBloc>().add(
          SingleCompanyFetchRequested(
            id: id,
            accessToken: token.trim(),
          ),
        );
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
    return BlocProvider(
      create: (_) => AddChildUserBloc(repository: AddChildUserRepository()),
      child: BlocListener<AddChildUserBloc, AddChildUserState>(
        listener: (context, state) {
          if (state is AddChildUserSuccess) {
            context.read<AddChildUserBloc>().add(const AddChildUserReset());
            _refreshSingleCompanyList(context);
            showSucessDialog(context, emailId.text.trim());
          } else if (state is AddChildUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
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
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Color(0xFFE6E8E7)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                CustomTextField(
                    title: 'Username (Email ID)',
                    hintText: 'Enter your username (Email ID)',
                    controller: userEmailId,
                    isPassword: false,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      final text = userEmailId.text.trim();
                      final validEmail = EmailValidator.validate(text);
                      if (text.isEmpty) {
                        isUserEmailValidator = true;
                        usernameErrorText = 'Please enter username (email ID)';
                      } else if (!validEmail) {
                        isUserEmailValidator = true;
                        usernameErrorText = 'Please enter a valid email ID';
                      } else {
                        isUserEmailValidator = false;
                        usernameErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    error: isUserEmailValidator),
                FormErrorText(text: usernameErrorText),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'First name',
                    hintText: 'Enter your first name',
                    controller: firstName,
                    isPassword: false,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      if (firstName.text.trim().isEmpty) {
                        isFirstNameValidator = true;
                        firstNameErrorText = 'Please enter first name';
                      } else {
                        isFirstNameValidator = false;
                        firstNameErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    error: isFirstNameValidator),
                FormErrorText(text: firstNameErrorText),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Last name',
                    hintText: 'Enter your last name',
                    controller: lastName,
                    icon: 'null',
                    height: 52,
                    isPassword: false,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      if (lastName.text.trim().isEmpty) {
                        isLastNameValidator = true;
                        lastNameErrorText = 'Please enter last name';
                      } else {
                        isLastNameValidator = false;
                        lastNameErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    error: isLastNameValidator),
                FormErrorText(text: lastNameErrorText),
                const SizedBox(
                  height: 12,
                ),
                ContactTextField(
                  isContactValidator: isContactValidator,
                  isTapContactName: isTapContactName,
                  controller: phoneNumber,
                  onTap: () {
                    setState(() {
                      isTapContactName = true;
                    });
                  },
                  onChanged: () {
                    if (phoneNumber.text.trim().isEmpty) {
                      isContactValidator = true;
                      contactErrorText = 'Please enter contact number';
                    } else {
                      isContactValidator = false;
                      contactErrorText = null;
                    }
                    setState(() {});
                  },
                ),
                FormErrorText(text: contactErrorText),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Email ID',
                    hintText: 'Enter your email id',
                    controller: emailId,
                    isPassword: false,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      final text = emailId.text.trim();
                      final validEmail = EmailValidator.validate(text);
                      if (text.isEmpty) {
                        isEmailValidator = true;
                        emailErrorText = 'Please enter email ID';
                      } else if (!validEmail) {
                        isEmailValidator = true;
                        emailErrorText = 'Please enter a valid email ID';
                      } else {
                        isEmailValidator = false;
                        emailErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    error: isEmailValidator),
                FormErrorText(text: emailErrorText),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    controller: password,
                    isPassword: observeText,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      if (password.text.isEmpty) {
                        isPasswordValidator = true;
                        passwordErrorText = 'Please enter password';
                      } else {
                        isPasswordValidator = false;
                        passwordErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    onTapSuffix: () {
                      setState(() {
                        observeText = !observeText;
                      });
                    },
                    suffix: true,
                    readOnly: false,
                    astric: true,
                    error: isPasswordValidator),
                FormErrorText(text: passwordErrorText),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    controller: confirmPassword,
                    isPassword: observeTextC,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    onChanged: () {
                      if (confirmPassword.text.isEmpty) {
                        isConfirmPasswordValidator = true;
                        confirmPasswordErrorText = 'Please enter confirm password';
                      } else if (confirmPassword.text != password.text) {
                        isConfirmPasswordValidator = true;
                        confirmPasswordErrorText = 'Password and confirm password must be same';
                      } else {
                        isConfirmPasswordValidator = false;
                        confirmPasswordErrorText = null;
                      }
                      setState(() {});
                    },
                    onTap: () {},
                    onTapSuffix: () {
                      setState(() {
                        observeTextC = !observeTextC;
                      });
                    },
                    suffix: true,
                    readOnly: false,
                    astric: true,
                    error: isConfirmPasswordValidator),
                FormErrorText(text: confirmPasswordErrorText),
                const SizedBox(
                  height: 32,
                ),
                BlocBuilder<AddChildUserBloc, AddChildUserState>(
                  builder: (context, blocState) {
                    final submitting = blocState is AddChildUserSubmitting;
                    return GestureDetector(
                  onTap: submitting
                      ? null
                      : () {
                   final fName = firstName.text.trim();
                   final lName = lastName.text.trim();
                   final username = userEmailId.text.trim();
                   final phone = phoneNumber.text.trim();
                   final mail = emailId.text.trim();
                   final pass = password.text;
                   final cPass = confirmPassword.text;

                   final usernameValid = EmailValidator.validate(username);
                   final mailValid = EmailValidator.validate(mail);

                   setState(() {
                     if (username.isEmpty) {
                       isUserEmailValidator = true;
                       usernameErrorText = 'Please enter username (email ID)';
                     } else if (!usernameValid) {
                       isUserEmailValidator = true;
                       usernameErrorText = 'Please enter a valid email ID';
                     } else {
                       isUserEmailValidator = false;
                       usernameErrorText = null;
                     }

                     if (fName.isEmpty) {
                       isFirstNameValidator = true;
                       firstNameErrorText = 'Please enter first name';
                     } else {
                       isFirstNameValidator = false;
                       firstNameErrorText = null;
                     }

                     if (lName.isEmpty) {
                       isLastNameValidator = true;
                       lastNameErrorText = 'Please enter last name';
                     } else {
                       isLastNameValidator = false;
                       lastNameErrorText = null;
                     }

                     if (phone.isEmpty) {
                       isContactValidator = true;
                       contactErrorText = 'Please enter contact number';
                     } else {
                       isContactValidator = false;
                       contactErrorText = null;
                     }

                     if (mail.isEmpty) {
                       isEmailValidator = true;
                       emailErrorText = 'Please enter email ID';
                     } else if (!mailValid) {
                       isEmailValidator = true;
                       emailErrorText = 'Please enter a valid email ID';
                     } else {
                       isEmailValidator = false;
                       emailErrorText = null;
                     }

                     if (pass.isEmpty) {
                       isPasswordValidator = true;
                       passwordErrorText = 'Please enter password';
                     } else {
                       isPasswordValidator = false;
                       passwordErrorText = null;
                     }

                     if (cPass.isEmpty) {
                       isConfirmPasswordValidator = true;
                       confirmPasswordErrorText = 'Please enter confirm password';
                     } else if (cPass != pass) {
                       isConfirmPasswordValidator = true;
                       confirmPasswordErrorText =
                           'Password and confirm password must be same';
                     } else {
                       isConfirmPasswordValidator = false;
                       confirmPasswordErrorText = null;
                     }
                   });

                   final allValid = !isUserEmailValidator &&
                       !isFirstNameValidator &&
                       !isLastNameValidator &&
                       !isContactValidator &&
                       !isEmailValidator &&
                       !isPasswordValidator &&
                       !isConfirmPasswordValidator;

                   if (allValid) {
                     if (widget.isEdit) {
                       showSucessDialog(context, emailId.text.trim());
                       return;
                     }
                     final profile =
                         context.read<UserInformationBloc>().state;
                     final companyId = profile is UserInformationLoaded
                         ? (profile.userData.company?.id?.trim() ?? '')
                         : '';
                     if (companyId.isEmpty) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           content: Text(
                             'Company not found on your profile. Open Manage booking or refresh profile.',
                           ),
                         ),
                       );
                       return;
                     }
                     final code = countryCode.trim().isEmpty
                         ? '+91'
                         : countryCode.trim();
                     final mobile = '$code${phoneNumber.text.trim()}';
                     context.read<AddChildUserBloc>().add(
                           AddChildUserSubmitted(
                             parentCompanyId: companyId,
                             firstName: fName,
                             lastName: lName,
                             userName: username,
                             email: mail,
                             password: pass,
                             mobile: mobile,
                           ),
                         );
                   }
                  },
                  child: Container(
                    height: 48,
                    decoration: ShapeDecoration(
                      color: submitting
                          ? AppColors.secondary.withOpacity(0.55)
                          : AppColors.secondary,
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 10,
                          cornerSmoothing: 1,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                        title: submitting ? 'Adding user…' : 'Add user',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
        ),
      ),
    );
  }

}
