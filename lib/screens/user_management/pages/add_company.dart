import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_company.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCompanyPage extends StatefulWidget {
  final bool isEdit;
  const AddCompanyPage({super.key, required this.isEdit});

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {

  //add company controller--------------------
  TextEditingController companyName = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController websiteLink = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController companyDiscount = TextEditingController();
  TextEditingController companyMarkup = TextEditingController();

  bool isLogin = true;
  String countryCode = '+91';

  bool isButtonActive = false;
  bool isCompanyNameValidator = false;
  bool isEmailValidator = false;
  bool isWebsiteValidator = false;
  bool isAddressValidator = false;
  bool isGstValidator = false;

  bool isTapCompanyName = false;
  bool isTapEmailName = false;
  bool isTapWebsiteName = false;
  bool isTapAddressName = false;
  bool isTapGstName = false;

  bool isEmailValid = true;
  bool isEmailValidShow = true;


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // TODO: implement initState
    super.initState();
    fetchEditVal();
  }

  fetchEditVal() {
    if(widget.isEdit) {
      isButtonActive = true;
      companyName = TextEditingController(text: 'Drivado');
      emailId = TextEditingController(text: 'tech@drivado.com');
      websiteLink = TextEditingController(text: 'www.drivado.com');
      address = TextEditingController(text: 'Kolkata, West Bengal 700091');
      gst = TextEditingController(text: 'DI785- 7126532');
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
        title: CustomText(title: widget.isEdit ? 'Edit Company' :  'Add Company', color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Colors.white),
                padding: EdgeInsets.all(20),
                // child: ImageSelector(height: 100, width: 100, color: Color(0xffE6E8E7),),
              ),
              const SizedBox(height: 20,),
              firstTextField(context, 'Company name', 'Enter your company name', companyName, true),
              isCompanyNameValidator ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(isCompanyNameValidator, 'Please enter company name'),
              const SizedBox(
                height: 16,
              ),
              emailTextField(context, 'Company Email ID', 'Enter your company email id', emailId, true),
              isEmailValidator || !isEmailValidShow ? const SizedBox(height: 5,) : const SizedBox(height: 0,) ,
              _validationMessage(emailId.text =='' ? isEmailValidator : !isEmailValidShow, emailId.text =='' ? 'Please enter your email id' : 'Please enter valid email id'),
              const SizedBox(
                height: 16,
              ),
              _commonTextField(context, 'Website Link', 'Enter your website link(optional)', websiteLink, false, (val) {}),
              const SizedBox(
                height: 16,
              ),
              _commonTextField(context, 'Address', 'Enter your address(optional)', websiteLink, false, (val) {}),
              const SizedBox(
                height: 16,
              ),
              _commonTextField(context, 'GST/VAT', 'Enter your GST/VAT(optional)', websiteLink, false, (val) {}),
              widget.isEdit
                  ? const SizedBox(
                height: 16,
              ) : Container(),
              widget.isEdit
                  ? _commonTextField(context, 'Company Discount', 'Enter your company discount', companyDiscount, false, (val) {})
                  : Container(),
              widget.isEdit
                  ? const SizedBox(
                height: 16,
              ) : Container(),
              widget.isEdit
                  ? _commonTextField(context, 'Company Markup', 'Enter your company markup', companyMarkup, false, (val) {})
                  : Container(),
              const SizedBox(
                height: 42,
              ),
             GestureDetector(
                onTap: () {
                  if(isButtonActive){
                    showSucessDialog(context);
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
                      title: widget.isEdit ? 'Update' : 'Add company',
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


  //-------Company Name Text Field-----------------------------
  Widget firstTextField(BuildContext context, title, hintText, controller, isStarShow) {
    return  Container(
      height: 52,
      width: MediaQuery.of(context).size.width,
      decoration:  ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(color: isCompanyNameValidator ?  AppColors.secondary.withOpacity(0.44) : Color(0xffE6E8E7)),
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
              transform: Matrix4.translationValues(0.0, isTapCompanyName ? -5.0 : -1.0, 0.0),
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
          if(companyName.text != '' && isEmailValid && emailId.text != '' ) {
            isButtonActive = true;
            if(companyName.text != '') {
              isCompanyNameValidator = false;
            } else {
              isCompanyNameValidator = true;
            }
            setState(() {
            });
          }else {
            isButtonActive = false;
            if(companyName.text != '') {
              isCompanyNameValidator = false;
            } else {
              isCompanyNameValidator = true;
            }
            setState(() {
            });
          }
        },
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          isTapCompanyName = true;
          if(emailId.text == '' && isTapEmailName) {
            isEmailValidator = true;
            isTapEmailName = false;
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
          if(companyName.text != '' && isEmailValid && emailId.text != '' ) {
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
          if(companyName.text == '') {
            isCompanyNameValidator = true;
            isTapCompanyName = false;
          }
          setState(() {
          });
        },
      ),
    );
  }
  //---------------------------------------------------

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

//-----------commom-----------------
  Widget _commonTextField(BuildContext context, title, hintText, controller,
      isStarShow, Function(String)? onChanged, ) {
    return Container(
      height: 52,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: const BorderSide(color: Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: Container(
              transform: Matrix4.translationValues(0.0, -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: title,
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textFieldTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: '',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.secondary,
                          ))
                    ]),
              ),
            ),
            isDense: true,
            hintStyle: GoogleFonts.plusJakartaSans(
                color: AppColors.textFieldTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 13),
            hintText: '$hintText'),
        onChanged: onChanged,
        onTap: () {
          isEmailValid = EmailValidator.validate(emailId.text);
          isEmailValidShow = EmailValidator.validate(emailId.text);
          if (companyName.text != '' &&
              emailId.text != '' &&
              isEmailValid) {
            setState(() {
              isButtonActive = true;
            });
          } else {
            isButtonActive = false;
            if (companyName.text == '') {
              isCompanyNameValidator = true;
            }
            if (emailId.text == '') {
              isEmailValidator = true;
            }
            setState(() {});
          }
        },
      ),
    );
  }
  //----------------------------------------------------

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
                                    //context.pop();
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewCompanyPage()));
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
