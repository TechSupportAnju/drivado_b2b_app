import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_company.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/sucess_popup.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Color(0xFFE6E8E7)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                CustomTextField(
                    title: 'Company name',
                    hintText: 'Enter your company name',
                    controller: companyName,
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
                    isTapCompanyName = true;
                    setState(() {
                    });
                  },
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    isPassword: false, error: isCompanyNameValidator,),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Company Email ID',
                    hintText: 'Enter your company email id',
                    controller: emailId,
                    icon: 'null',
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                  onChanged: (val) {
                    isEmailValid = EmailValidator.validate(emailId.text);
                    if(isEmailValid && emailId.text != '') {
                      isEmailValidator = false;
                    }else {
                      isEmailValidator = true;
                    }
                    setState(() {
                    });
                  },
                  onTap: () {
                    isTapEmailName = true;
                    setState(() {
                    });
                  },
                    suffix: false,
                    readOnly: false,
                    astric: true,
                    isPassword: false, error: isEmailValidator,),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                    title: 'Website Link',
                    hintText: 'Enter your website link(optional)',
                    controller: websiteLink,
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
                  height: 12,
                ),
                CustomTextField(
                    title: 'Address',
                    hintText: 'Enter your address(optional)',
                    controller: address,
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
                  height: 12,
                ),
                CustomTextField(
                    title: 'GST/VAT',
                    hintText: 'Enter your GST/VAT(optional)',
                    controller: gst,
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
                  height: 32,
                ),
               GestureDetector(
                  onTap: () {
                    if(companyName.text == '') {
                      setState(() {
                        isCompanyNameValidator = true;
                      });
                    } else if(emailId.text == '') {
                      setState(() {
                        isEmailValidator = true;
                      });
                    } else {
                      showSucessDialog(context, companyName.text);
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
                        title: 'Add company',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
