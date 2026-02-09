import 'dart:async';
import 'package:drivado_b2b_app/models/country_code/country_code_model.dart';
import 'package:drivado_b2b_app/screens/booking_recipet/booking_recipet.dart';
import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/country_code_dialog_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/widget/custom_top_progress_bar.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import 'package:loading_animation_widget/loading_animation_widget.dart';


class PassengerDetailsPage extends StatefulWidget {
  final selectedVehicle;
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;

  const PassengerDetailsPage({
    required this.selectedVehicle,
    required this.isTapOneway,
    this.isLogin,
    this.bookingSearchId,
    super.key}
      );

  @override
  State<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController flightNo = TextEditingController();
  TextEditingController specialReq = TextEditingController();
  bool isButtonActive = false;
  String countryCode = '+91';

  TextEditingController country = TextEditingController();
  bool isFirstNameValidator = false;
  bool isLastNameValidator = false;
  bool isContactValidator = false;
  bool isEmailIdValidator = false;

  bool isTapFirstName = false;
  bool isTapLastName = false;
  bool isTapEmailName = false;
  bool isTapContactName = false;

  bool isEmailValid = true;
  bool isEmailValidShow = true;
  List countrtyList = [];
  List<CountryCodeModel> countrylisttt = [];

  List<CountryCodeModel> filterList = [];
  bool isLoading = false;
  bool isAgree = false;
  String onewayDate = "";
  String onewayDay = "";
  String onewayMonth = "";
  String onewayYear = "";
  String hourlyDate = "";
  String hourlyDay = "";
  String hourlyMonth = "";
  String hourlyYear = "";
  String flightStatus = '';
  bool isFlightStatus = false;
  // FlightStatusResponse? flightStatusResponse;
  Timer? debounce;
  int toggleValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Timer? _debounce;
  String? flightNumber;


  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
              flexibleSpace: Container(
                height: 70,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              shadowColor: Color(0xFFD9D9D9),
              centerTitle: true,
              leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.keyboard_backspace,
                    color: Color(0xFF555555),
                  )),
              title: const CustomText(
                  title: 'Passenger Details',
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
          body:  Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTopProgressBar(
                  tabCount: topProgressBarIndex,
                  isActive: isButtonActive,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        CustomTextField(
                          title: 'First',
                          hintText: 'Enter your first name',
                          controller: firstName,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                            if(firstName.text != '') {
                              isFirstNameValidator = false;
                            }else {
                              isFirstNameValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isFirstNameValidator,),
                        const SizedBox(height: 12),
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
                              isLastNameValidator = false;
                            }else {
                              isLastNameValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isLastNameValidator,),
                        const SizedBox(height: 12),
                        _contactTextField(context),
                        isContactValidator
                            ? const SizedBox(height: 5)
                            : const SizedBox(height: 0),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Email ID',
                          hintText: 'Enter your email id',
                          controller: emailId,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                            if(emailId.text != '') {
                              isEmailIdValidator = false;
                            }else {
                              isEmailIdValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isEmailIdValidator,),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Flight Number (Optional)',
                          hintText: 'Enter your flight number',
                          controller: flightNo,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                          },
                          onTap: () {},
                          suffix: false,
                          readOnly: false,
                          astric: false,
                          error: false,),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Any special request (Optional)',
                          hintText: 'Enter any special request',
                          controller: specialReq,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: false,
                          error: false,),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            const SizedBox(width: 1),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                isAgree = !isAgree;
                                setState(() {
                                });
                                print('isAgree===');
                                print(isAgree);
                                if(isAgree) {
                                  isButtonActive = true;
                                } else {
                                  isButtonActive = false;
                                }
                                setState(() {
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MediaQuery.of(context).size.width >= 500?
                                  const SizedBox(height: 3)  : Container(),
                                  Icon(
                                    isAgree
                                        ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                                    color: isAgree
                                        ? AppColors.secondary : Color(0xFF8E8E93),
                                    size: 18,
                                  ),
                                  MediaQuery.of(context).size.width >= 500
                                      ? Container() : const SizedBox(height: 11)
                                ],
                              ),
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  isAgree = !isAgree;
                                  setState(() {
                                  });
                                  print('isAgree===');
                                  print(isAgree);
                                  if(isAgree) {
                                    isButtonActive = true;
                                  } else {
                                    isButtonActive = false;
                                  }
                                  setState(() {
                                  });
                                },
                                child: const SizedBox(width: 10)
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'I agree to ',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black,
                                      height: 1.4
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Terms & Conditions, Booking Conditions ',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.secondary
                                        )
                                    ),
                                    TextSpan(
                                        text: 'and ',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black
                                        )
                                    ),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.secondary
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: (isAgree)
                              ? () {
                            topProgressBarIndex = 2;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingReceiptPage(
                                isTapOneway: widget.isTapOneway)));
                          }
                          : () {
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: isButtonActive && isAgree
                                    ? AppColors.secondary
                                    : AppColors.secondary
                                    .withOpacity(0.44),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: const CustomText(
                                title: 'Confirm Booking',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
  //----For country code & contact number text filed----
  Widget _contactTextField(BuildContext context) {
    return Container(
      height: 52,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          side: BorderSide(
              color: isContactValidator
                  ? AppColors.secondary
                  : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        controller: contactNumber,
        // readOnly: true,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        keyboardType: TextInputType.number,
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600, fontSize: 14),
        decoration: InputDecoration(
            prefixIcon: !isTapContactName?
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(
                    context),
              ],
            ) : null,
            prefix: isTapContactName?
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(
                    context), // Positioned country code picker
              ],
            ) : null,
            label: Container(
              transform: Matrix4.translationValues(0.0, -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: 'Contact number',
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor,
                        fontWeight: FontWeight.w400),
                    children: const [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          )
                      )
                    ]
                ),
              ),
            ),
            isDense: true,
            border: InputBorder.none,
            hintStyle: GoogleFonts.plusJakartaSans(
                color: AppColors.textFieldTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 13),
            hintText: 'Enter your contact number'),
        onChanged: (val) {
          log(val);
          if (firstName.text != '' &&
              lastName.text != '' &&
              contactNumber.text != '' &&
              isEmailValid &&
              emailId.text != '') {
            isButtonActive = true;

            if (contactNumber.text != '') {
              isContactValidator = false;
            } else {
              isContactValidator = true;
            }
            setState(() {});
          } else {
            isButtonActive = false;
            if (contactNumber.text != '') {
              isContactValidator = false;
            } else {
              isContactValidator = true;
            }
            setState(() {
              // sendContactNumber = contactNumber.text.toString();
              // log(sendContactNumber.toString());
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapContactName = true;
          if (firstName.text == '') {
            isFirstNameValidator = true;
          }
          if (lastName.text == '') {
            isLastNameValidator = true;
          }
          if (emailId.text == '' && isTapEmailName) {
            isEmailIdValidator = true;
          }
          setState(() {
            log(firstName.text);
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
        // height: 52,
        width: countryCode.length > 4
            ? 69
            : countryCode.length > 3
            ? 60
            : 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            countryCode.isEmpty
                ? LoadingAnimationWidget.threeArchedCircle(
                color: Colors.white,
                size: 30
            )
                : CustomText(
                title: countryCode,
                color: Color(0xFF6A6A6A),
                fontSize: 14,
                fontWeight: FontWeight.w600),
            const SizedBox(width: 5),
            const Icon(Icons.expand_more_sharp,
                color: Color(0xff949494), size: 20),
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
