import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF5F6FA),
      body:  Column(
        children: [
          Container(
            height: 110,
            color: Colors.white,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_backspace, color: Color(0xFF606060),)),
                  SizedBox(width: 16,),
                  CustomText(title: 'Terms & Conditions',
                    height: 1.4,
                    fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0D0D0D),),
                ],
              ),
            ),
          ),
          SizedBox(height: 25,),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: CustomText(title: 'Terms and Conditions applicable to the use of the Drivado-Platform (including the drivado-App) and to the Services provided by Transportation Service Providers ("drivado T&C").',
                          height: 1.4,
                          color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                      child: Column(
                        children: [
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'General',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Scope of Application',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'These Terms and Conditions ("T&C") govern (i) the access and use of the website ',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'www.drivado.com',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrl(Uri.parse(' https://www.drivado.com/'));
                                                    },
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                              TextSpan(
                                                  text: ' , associated websites, the drivado-app and other content, websites, applications, products and services (in the following jointly referred to as "Platform") made available or supplied by Drivado Transfers Pvt. Ltd.("drivado"), and the (ii) arrangement of agreements on driver, mobility, and logistics services ("Services") through the Platform or by phone or email with service providers co-operating with Drivado ("Service Providers"). Associated websites are websites other than the website',
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                              TextSpan(
                                                  text: ' www.drivado.com ',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrl(Uri.parse('https://www.drivado.com/'));
                                                    },
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                              TextSpan(
                                                  text: ' which Drivado uses to arrange agreements on Services and/or which third parties use to offer Services, or to arrange contracts on Services based on an agreement with drivado.',
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. About Drivado',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado arranges agreements on Services ("Service Agreements") which are concluded between Users and Service Providers. "Users" in terms of these T&C are individuals and legal entities who use the Platform, with or without being registered with Drivado for the use of the Services or the Platform.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '3. Acceptance of T&C',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'By accessing, registering for or using the Platform the User accepts the application of these T&C. Therefore, please read these T&Cs carefully before accessing or using the Platform.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '4. Modification of T&C',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado reserves the right to make modifications of these T&C, which will be posted at this location. The modifications will only form part of the agreement, once the User has accepted these modifications. It is sufficient for this purpose, if Drivado informs the User of the new version of the T&C using the e-mail which has been provided by the User for notification purposes. In case the User does not object to the modifications of the T&C within four weeks, the acceptance shall be deemed as granted. As part of the e-mail, which is used to communicate the new version of the T&C, Drivado will inform the User about the possibility to object to the modification and regarding the meaning of the four-week-deadline.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '5. No application of T&C of user',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Terms and Conditions of the User are not applicable, even if Drivado does not explicitly object to their inclusion.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '6. Language of agreement',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        Row(
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.left,
                                              text: TextSpan(
                                                text: 'The language of the agreement is English.',
                                                style: GoogleFonts.plusJakartaSans(
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.policyText2Color),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '7. Availability of these T&C',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The current version of the T&C shall always be displayed and Users are also authorized to print or save electronic copies.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '8. Data Privacy',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado and Service Providers collect and store the personal data which is necessary to process the business transactions. They observe the legal requirements during the processing of the personal data. In addition, please refer to our privacy policy here.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'Registration for the Platform and the Platform User Agreement',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Registration process',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The registration of the User is not necessary to use the Platform. The registration is free of charge and requires that the User accepts these T&C. To complete the registration process, the User is required to provide certain details (e.g., first and last name, email). If the User requests registration online, the confirmation email is sent to User with all details. The User can always correct their details up before sending the request for registration. By completing the registration request process via web, app, phone or email the User submits a binding offer to conclude the agreement for the use of the Platform ("Platform User Agreement"). Drivado reserves the right to accept or reject the offer and there shall be no claims to the formation of a Platform User Agreement. If Drivado accepts the offer by the User to form a Platform User Agreement, Drivado will inform the User via e-mail to the e-mail address provided by the User and generate a user account for the User. The confirmation of the registration will be stored by Drivado, however, it will not be visible and accessible anymore to the User through the Platform.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. Entitlement to registration',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The registration is only possible for individuals who are not limited in their legal capacity, legal entities and partnerships. The registration of a legal entity or a partnership may only be carried out by an individual with power of attorney, who shall be identified by name.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '3. Accuracy of details',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The User is obliged to maintain accurate, up-to-date, and complete details in their account. Failure to keep accurate, up-to-date, and complete account details may result in the User\'s inability to access and use Services or Drivado\'s termination of this Agreement with the User.',     style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '4. Communication via email',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                               text: 'Legally binding statements can be delivered to the User using the e-mail address stored in the account.',
                                                style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '5. Passwords',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                                text: 'The User is required to keep his password secret. S/He is not entitled to allow third parties to use his or her user account. As soon as the User is aware or has reason to believe that a third party is accessing his/her login details or otherwise gained or may gain access to his/her user account, s/he is obliged to notify Drivado about this fact immediately. Drivado is then entitled to block the User account until clarification of the issue.',
                                                style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '6. Liability for misuse of user account',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The User is liable to Drivado for all actions, which are carried out using User\'s account, unless the User is not responsible for such misuse.',
                                                style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '7. Termination',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The Platform User Agreement is entered into for an indefinite duration. The User can terminate this agreement at any time without prior notice by writing an email to ',
                                                style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'support@drivado.com',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                                    },
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                              TextSpan(
                                                text: ' or declaring in written form by mail or hand delivery to:\n\nDrivado Transfers Pvt. Ltd.Merlin Infinite,Unit #506, DN-51,Street Number 11, DN Block,Sector V, Bidhannagar, Kolkata,West Bengal 700091, India.\n\nDrivado can also terminate this agreement with a User at any time without prior notice by communicating by email to the email address associated with the User account.',
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'Service Agreements – Contractual Relationship & Conclusion',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Contractual Relationship',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado enables Users to arrange and schedule services with Service Providers (i.e. licensed chauffeur / limousine companies). Drivado arranges agreements on Services ("Service Agreement") which are concluded between the User and the Service Provider directly. Thus, Users are entitled to file claims against Service Providers directly. The User acknowledges that Drivado serves strictly as an intermediate or broker and not as a transportation service provider. The User shall have no claim to the formation or arrangement of Service Agreements.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. Conclusion of Service Agreements',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                          text: 'Service Agreements between the User and Service Providers are concluded through the Platform as follows: First the User indicates the desired service (e.g., one-way or hourly booking) and fills in the booking screen of the Platform. The fee for the Services will then be displayed for each booking class. The User then chooses a booking class and confirms his/her payment method, the associated billing details, and contact information supporting the provision of Services. The User can review and correct the details of his/her Service request ("Booking Request") before submitting the Booking Request by clicking the button "BOOK" (or a button with a similar indication). When a User submits a Booking Request whether via the Platform or by phone or by email to drivado, the User makes an offer for the conclusion of a Service Agreement with a Service Provider. Upon receiving a Booking Request, Drivado sends to the User an email to confirm the receipt of the Booking Request, including the details that were received. The Service Agreement between the User and the Service Provider only comes into effect upon Drivado\'s submission of a separate statement ("Ride Details") by email shortly before the ride, stating the name and contact details of the selected Service Provider. If Drivado cannot find a Service Provider to fulfil the Booking Request, Drivado will inform the User by email that the Booking Request cannot be fulfilled. In addition to these T&C, the Booking Conditions applicable at the time of booking shall apply. The Booking Conditions can be viewed at: ',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                  text: 'Booking Conditions.',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrl(Uri.parse('https://drivado.com/bookingConditions'));
                                                    },
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),

                                            ]
                                          ),
                                        ),
                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'The Cancellation of Service Agreements',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Cancellation conditions',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The User may cancel Service Agreements free of charge or with costs according to the conditions which apply to the respective booking class agreed upon in the respective Service Agreement. The Booking Conditions are accessible at: ',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                              children: [
                                                TextSpan(
                                                    text: 'Booking Conditions.',
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        launchUrl(Uri.parse('https://drivado.com/bookingConditions'));
                                                      },
                                                    style: GoogleFonts.plusJakartaSans(
                                                        height: 1.4,
                                                        decoration: TextDecoration.underline,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12,
                                                        color: AppColors.policyText2Color)),

                                              ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. Cancellation only via Platform.',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'To warrant a smooth and save transaction, all cancellation requests must be made through the website ',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                  text: 'www.drivado.com',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrl(Uri.parse('https://www.drivado.com/'));
                                                    },
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      decoration: TextDecoration.underline,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),
                                              TextSpan(
                                                text: ', the drivado app, by phone or by email. Drivado will confirm valid cancellations to the User by e-mail.',
                                                  style: GoogleFonts.plusJakartaSans(
                                                      height: 1.4,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: AppColors.policyText2Color)),

                                            ]
                                          ),
                                        ),
                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                title: CustomText(title: 'The payment of Fees due under the Service Agreements',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Fees due',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'All fees agreed upon in Service Agreements include possible charges and the statutory tax, if applicable. Unless agreed otherwise, the fee for bookings by route applies to the agreed journey without stopovers and without detours. In case of bookings by time or by route, the User must still pay the agreed amount of the fee if the passenger ends the journey early or shortens it.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. Invoices',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado will send an invoice of the fees to the User (exclusively) by e-mail on behalf of the Service Provider.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),

                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '3. Payment method',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The fee shall be paid using the payment method chosen by the User during the booking process. For payments upon invoice the fee is payable within 10 days after notification of the invoice.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),

                                          ),
                                        ),
                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                title: CustomText(title: 'Liability of drivado under the Platform User Agreement and of Service Providers under Service Agreements',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '1.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                text: ' Drivado shall only be liable towards the User, in particular in regards to its contractual obligations under the Platform User Agreement and any obligations in regards to the arrangement of Service Agreements, according to this Section VI. In no event shall Drivado be liable for any actions or omissions by Service Providers, in particular under any Service Agreement. Neither Service Providers nor drivers it employs or subcontracts are neither vicarious agents nor subcontractors of Drivado.',
                                                style: GoogleFonts.plusJakartaSans(
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.policyText2Color),
                                              ),
                                            ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        RichText(
                                          text: TextSpan(
                                            text: '2.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                text: ' The liability of drivado towards the User, in particular according to the Platform User Agreement, and the liability of Service Providers towards the User, in particular according to Service Agreements, are governed by the following rules:',
                                                style: GoogleFonts.plusJakartaSans(
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.policyText2Color),
                                              ),
                                            ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        RichText(
                                          text: TextSpan(
                                            text: '3.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                                children: [
                                                  TextSpan(
                                                    text: ' Drivado and the Service Provider respectively assume unlimited liability for damages caused wilfully or as a result of gross negligence by them, by their employees and by their vicarious agents, as well as in the event of fraudulent non-disclosure of defaults, explicit guarantees and damages arising from personal injuries (life, body and health).',
                                                    style: GoogleFonts.plusJakartaSans(
                                                        height: 1.4,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12,
                                                        color: AppColors.policyText2Color),

                                                  ),
                                                ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        RichText(
                                          text: TextSpan(
                                            text: '4.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                text: ' Drivado and the Service Provider respectively shall only be liable for other damages if they are in violation of an obligation, which must be observed to make the due performance of the agreement possible and on whose observation the other party to the agreement can usually rely. At the same time, the liability for damages is limited to those damages, which are deemed typical for this type of contract and foreseeable. Possible liabilities according to product liability law remain unaffected.',
                                                style: GoogleFonts.plusJakartaSans(
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.policyText2Color),

                                              ),
                                            ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        RichText(
                                          text: TextSpan(
                                            text: '5.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                              text: ' Drivado does not warrant or assume liability for obligations according to arranged Service Agreements. In particular, Drivado is then not liable for the non-compliance with regulations under public law by Service Providers.',
                                              style: GoogleFonts.plusJakartaSans(
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: AppColors.policyText2Color)),
                                            ]
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        RichText(
                                          text: TextSpan(
                                            text: '6.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                            children: [
                                              TextSpan(
                                                text: ' Furthermore, Drivado shall not be liable for the accuracy, reliability, and completeness of the contents and programmes provided by Drivado on the Platform free of charge as well as damages, which may arise from them.',
                                                style: GoogleFonts.plusJakartaSans(
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.policyText2Color),

                                              ),
                                            ]
                                          ),
                                        ),
                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                                                collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                title: CustomText(title: 'Final Provisions for both the Platform User Agreement and the Service Agreements',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: '1. Assignment',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado is entitled to completely or partially assign all rights and obligations derived from the Platform User Agreement to a third party giving 4 weeks prior notice; in this case the User may terminate the User Agreement for good cause.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '2. Force majeure',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 14,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'If events or circumstances outside Drivado\'s or a Service Provider\'s sphere of influence (force majeure) make the performance of their respective contractual obligations impossible, drivado or the Service Provider, whoever is affected, shall be relieved from their obligation to perform. In particular, the disruption or outage of the internet or other networks, telecommunications connections, power supply or other infrastructures as well as disruptions or defaults produced by providers or suppliers as well as severe weather are considered force majeure.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '3. Governing law',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'The Platform User Agreement and Service Agreements shall each be governed exclusively by the law of the Local Courts of Kolkata, India.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),

                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Row(
                                          children: [
                                            CustomText(title: '4. Venue',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'For those Users, who are registered business people, the agreed venue for all legal disputes which may arise in relation with this agreement and the individual agreements shall be Kolkata.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),

                                          ),
                                        ),

                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xffE6E8E7)),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                               collapsedIconColor: AppColors.secondary,
                                dense: true,
                                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                title: CustomText(title: 'Company Identification',
                                  height: 1.4,
                                  color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14,),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(title: 'The contact details of drivado are as follows:',
                                              height: 1.4,
                                              color: AppColors.policyTextColor, fontWeight: FontWeight.w400, fontSize: 14,),
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Drivado Transfers Pvt. Ltd.Merlin Infinite,Unit #506, DN-51,Street Number 11, DN Block,Sector V, Bidhannagar, Kolkata,West Bengal 700091, India.',
                                            style: GoogleFonts.plusJakartaSans(
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: AppColors.policyText2Color),
                                          ),
                                        ),
                                     ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}

