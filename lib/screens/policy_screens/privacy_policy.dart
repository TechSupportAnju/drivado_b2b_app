import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: Column(
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
                  CustomText(title: 'Privacy Policy', height:1.4, fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0D0D0D),),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 25),
                    child: Column(
                      children: [
                        const CustomText(title: 'With these Privacy Policy, Drivado Transfers Pvt. Ltd., Merlin Infinite, Unit #506, DN-51, Street Number 11, DN Block, Sector V, Bidhannagar, Kolkata, West Bengal 700091, India. (hereinafter referred to as "Drivado" or "we") wishes to inform you of how your personal data is handled. You can view and print out the Privacy Policy from here.',
                            height: 1.4,
                            textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 14),
                        const SizedBox(height: 16,),
                        CustomText(title: 'We take the protection of personal data and thus your privacy very seriously. We wish to set out here how we protect your data and what it means for you when you use our customizable services.',
                            height: 1.4,
                            textAlign: TextAlign.left, color: AppColors.policyText2Color, fontWeight: FontWeight.w400, fontSize: 12),
                        const SizedBox(height: 27,),
                        const Row(
                          children: [
                            CustomText(title: 'Scope of application',
                                height: 1.4,
                                textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'The Privacy Policy apply only for utilization of the website ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'www.drivado.com',
                                  recognizer: new TapGestureRecognizer()
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
                                  text: ' and related local and mobile applications and programs (hereinafter referred to as "Platform"). When you visit other websites or apps, the privacy policy of the relevant operator apply. This is also the case if we refer users to the website of a third party by way of a link. We recommend that you find out about the handling of your personal data on that website.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.policyText2Color)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Data processing office and data protection officer',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'The responsible office and service provider is:Drivado Transfers Pvt. Ltd.Merlin Infinite,Unit #506, DN-51,Street Number 11, DN Block,Sector V, Bidhannagar, Kolkata,West Bengal 700091, India.Commercial register court: Local Court of Kolkata, India. (hereinafter referred to as "drivado") For all questions relating to data protection you can contact the drivado data protection officer, at any time by sending an e-mail to ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'What is personal data?',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Personal data is information which can be associated with you as an individual. Examples include your name, address, postal address, telephone number or e-mail address. Non-personal data are details such as the number of users of a site.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Collection, processing and utilization of personal data by Drivado',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'Personal data is collected via the Platform when you choose to provide it, e.g., in the course of registration, the log-in process, completing forms, sending e-mails or in particular by making bookings. The personal data we may collect includes:Contact information (such as name, postal address, e-mail address and telephone number)Account information (such as username and password)Demographic information (such as age and gender)Booking enquiry informationGeo-location informationInformation about the device you use to access the Platform (such as IP address, operating system and web browser)User preference information ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'We use this data for the purposes stated in each case or which are obvious from the enquiry, for example the booking enquiry data is used to satisfy your requirements. Your data is only used for commercial purposes in the course of our own advertising (including recommendation advertising) within the scope of what is statutorily permitted. Data is transferred to third parties only to the extent that this is necessary to fulfil the contract, e.g. to process a credit card payment through your credit card company. When you registered for the newsletter, we will use your registration data to send said newsletter to you. We may share your data within our group of affiliated companies, subject to these Privacy Policy. We may disclose information about you (i) if we are required to do so by law or legal process, (ii) when we believe disclosure is necessary to prevent harm or financial loss, or (iii) in connection with an investigation of suspected or actual fraudulent or illegal activity.We reserve the right to transfer personal information we have about you in the event we sell or transfer all or a portion of our business or assets. Should such a sale or transfer occur, we will use reasonable efforts to direct the transferee to use personal information you have provided to us in a manner that is consistent with these Privacy Policy. Following such a sale or transfer, you may contact the entity to which we transferred your personal information with any enquiries concerning the processing of that information.When you visit the Platform, we may also collect information about your online activities over time and across third-party websites or online services. Because there is not yet a consensus on how companies should respond to web browser-based or other do-not-track ("DNT") mechanisms, we do not respond to web browser-based DNT signals at this time.If we also wish to use your personal data in the future for other purposes, we will always ask you for your consent. After giving consent you will be able to revoke your consent at any given time, and we will apply your preferences going forward. To improve our online services, we can store and use information about how you use our services and our websites. The data which is collected in this manner cannot be related back to a single person (pseudonymization). If you would like to opt out of this, please contact us at ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),TextSpan(
                                  text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Newsletter and objection',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'When you subscribe to our newsletter mailing list, we will inform you regularly about new products, useful tips and news as well as exclusive offers. After successful registration, you will receive a confirmation e-mail. You may object at any time to the use of your e-mail-address for this purpose you can send your objection to ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: '\nWhen you no longer want to receive our newsletter, you can unsubscribe at any time by clicking on the unsubscribe link which can be found in any newsletter or emailing us at',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                  fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: '. In addition, we would like to inform you that you can at any time file a general objection to any use of your data for the purposes of marketing or opinion research. This objection should be sent to:Drivado Transfers Pvt. Ltd.Merlin Infinite,Unit #506, DN-51,Street Number 11, DN Block,Sector V, Bidhannagar, Kolkata,West Bengal 700091, India.Or by e-mail to: ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Credit card data',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'During the booking process with Drivado you have the option to provide your credit card details in order to pay for your ride by credit card. (Card is charged instantly at the time of booking.)For the handling of payment via credit cards, Drivado secured a professional Payment Service Provider (PSP) called Razorpay (',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'www.razorpay.com',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://drivado.com/https://razorpay.com/'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: '), that is certified to the PCI-DSS, and that is required to protect your credit card data.Drivado itself does not store any type of credit card data from your card; in order to allow you to use a card that has been already registered for future payments, we will only save a reference number that distinctly identifies your card with Razorpay.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                  fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'GPS tracking',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            // text: 'During the booking process with Drivado you have the option to provide your credit card details in order to pay for your ride by credit card. (Card is charged instantly at the time of booking.)For the handling of payment via credit cards, Drivado secured a professional Payment Service Provider (PSP) called Razorpay (',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'To provide high-quality customer service, Drivado can determine your requested driver\'s coordinates via mobile phone (GPS tracking). This location information will not be stored and will be used exclusively to allow for a reserved ride to process or to inform the customer about an upcoming ride. In order to allow you, our customer, to comfortably book by using the drivado mobile applications (Android and iOS Apps) from your current location as the pick-up location, our apps locate your position (if you activated this option in your local app permissions in Settings). That is how you agree to allow for your location data to be captured. Drivado will not store any movement data or your permanent residence at any point in time.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Security, SSL technology',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            // text: 'During the booking process with Drivado you have the option to provide your credit card details in order to pay for your ride by credit card. (Card is charged instantly at the time of booking.)For the handling of payment via credit cards, Drivado secured a professional Payment Service Provider (PSP) called Razorpay (',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Drivado has taken technical and organizational measures designed to protect your personal data, particularly against accidental or deliberate manipulation, loss, destruction or access by unauthorized persons. These security measures are constantly adjusted in line with technical developments. The transfer of personal data between your smart phone and our server is always encoded (SSL procedure, Secure Socket Layer).',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Disclosure, correction and deletion of data',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'You can request from us at any time disclosure of data stored under your name or your e-mail address and have this data corrected, blocked or deleted. For this and other requests for disclosure, correction or deletion please contact us via email (',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: ') by mentioning your name and your contact address.The data protection officer at Drivado can also be reached at this address below by post:Drivado Transfers Pvt. Ltd.Merlin Infinite,Unit #506, DN-51,Street Number 11, DN Block,Sector V, Bidhannagar, Kolkata,West Bengal 700091, India.Drivado deletes recorded and collected data as soon as and to the extent that this is legally stipulated. If deletion is prevented by an obligation under statute, company by-laws or contracts to retain the information for a certain period, the data is not deleted but rather simply blocked. In addition, courts, criminal investigation authorities or other legally appointed authorities based on statute may request the data or demand disclosure, and we will comply with such demand in accordance with applicable law.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Use of cookies',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'Drivado uses cookies to analyze web traffic, optimize the performance and content of the Platform, gauge the efficacy of advertising campaigns and encourage trust and security in the Platform. Cookies are small text files which are stored on your computer by your Internet browser. Most of the cookies are deleted from your hard disk at the end of the browser sessions ("session cookies"). Other cookies stay on your computer and ensure that Drivado can recognize your computer on your next visit and analyze your usage ("permanent cookies"). You can prevent the storage of cookies by setting your web browser not to accept new cookies, to notify you of new cookies or to delete all cookies already stored. You can get help with changing your settings via the help function of your web browser or at ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'www.allaboutcookies.org',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://drivado.com/https://www.allaboutcookies.org/'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: '. Please note that some functions of the web page are only possible by using cookies. We therefore recommend not deactivating the cookie function.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Use of Google Analytics',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'Our platform uses Google Analytics, a web analytics service provided by Google Inc., 1600 Amphitheatre Parkway Mountain View, CA 94043, USA ("Google"). It uses the feature called "trackPageview". This transmits only page views and events, i.e. drivado sees which pages have been called up and which actions have been carried out. However, no personal data is transmitted to Google in this process. The information created about your usage of the Platform is sent to a Google in the USA in anonymized form and stored there. Google uses this information to evaluate your usage of the Platform, to compile reports for drivado on the activities on the Platform and to provide additional services associated with utilization of apps and the Internet. Google may also pass on this information to third parties, provided this is legally permissible or if this data is processed by third parties on behalf of Google. On no account will Google associate your IP address with other data stored by Google. For further information, see ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'www.google.com/intl/policies/privacy',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://policies.google.com/privacy?hl=policies'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: ' (general information on Google Analytics and data protection).You can find additional information ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: 'here ',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://marketingplatform.google.com/about/'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: '(general information on Google Analytics and Data Protection).We only use Google Analytics with the activated IP anonymization. This means that the users\' IP address is shortened by Google for the member states within the European Union or for other parties to the Agreement on the European Economic Area. The full IP address is sent to and shortened by a Google server in the USA only in exceptional cases. The IP address transmitted by the user\'s browser is not merged with other Google information.You may prevent cookies used here from installing by selecting the appropriate setting in your browser software; however please note that by doing this, you may not be able to use all the extensive features of this website.Furthermore, you can prevent data analysis by Google Analytics on this website by downloading and installing the browser plug-in available at the following link: ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: 'tools.google.com/dlpage/gaoptout.',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://tools.google.com/dlpage/gaoptout'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Google Tag Manager',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            // text: 'Our platform uses Google Analytics, a web analytics service provided by Google Inc., 1600 Amphitheatre Parkway Mountain View, CA 94043, USA ("Google"). It uses the feature called "trackPageview". This transmits only page views and events, i.e. drivado sees which pages have been called up and which actions have been carried out. However, no personal data is transmitted to Google in this process. The information created about your usage of the Platform is sent to a Google in the USA in anonymized form and stored there. Google uses this information to evaluate your usage of the Platform, to compile reports for drivado on the activities on the Platform and to provide additional services associated with utilization of apps and the Internet. Google may also pass on this information to third parties, provided this is legally permissible or if this data is processed by third parties on behalf of Google. On no account will Google associate your IP address with other data stored by Google. For further information, see ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'The Platform uses the Google Tag Manager. This service enables the management of website tags via an interface. The Google Tag Manager only implements tags. That means: no cookies are used and no personal data is collected. The Google Tag Manager activates other tags, which may in turn collect data. But Google Tag Manager does not access this data. If deactivation has been implemented at domain or cookie level this remains in place for all tracking tags, provided these were implemented with the Google Tag Manager.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Use of Google Maps',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'For users of our Android App (and users of our Drivado Website): This app uses Google Maps API applications. These applications are essential for the functionality and full provision of the booking service. By using this app, you declare your agreement to applicability of the conditions of use and the Google privacy policy. The user conditions of Google can be found under ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'www.google.com/policies/terms.',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://policies.google.com/privacy?hl=policies'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: '\nThe Google Privacy Policy can be found at ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: 'www.google.com/intl/policies/privacy',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://policies.google.com/privacy?hl=policies'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: 'Google Maps is used to show you a map of the relevant area. All location data is submitted to Google in anonymized form; no other information is submitted to Google. Google cannot identify you when you use the "My Location" function in Google Maps. Mobile devices are fundamentally anonymous. If you use Google Maps on your mobile device, Google does not collect any personal data such as your name or your telephone number. Therefore Google does not know the owner or user of the smart phone.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Use of OpenStreetMap',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'For users of our iOS App: This app uses OpenStreetMap API applications. These applications are essential for the functionality and full provision of the booking service. By using this app, you declare your agreement to applicability of the conditions of use and the privacy policy of OpenStreetMap. The OpenStreetMap conditions of use can be found at ',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'www.openstreetmap.org/copyright.',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://www.openstreetmap.org/copyright'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: 'The OpenStreetMap privacy policy can be found at ',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                text: 'here',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://wiki.openstreetmap.org/wiki/Privacy_Policy'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                              TextSpan(
                                  text: '. All location data is submitted to OpenStreetMap in anonymized form; no other information is submitted to OpenStreetMap.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      // decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Facebook',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'This website contains the plug-ins of the social network Facebook (e.g., the "Like" button), network operated by Facebook Inc., 1601 S. California Ave, Palo Alto, CA 94304, USA ("Facebook"). When you interact with the plug-ins, as for instance when clicking the "Like" button, you can, as a Facebook registered user, automatically leave a note in your Facebook profile, letting your network of friends know that you liked the contents that you visited. To that extent, our website allows for an ongoing data exchange with Facebook. Please note that data exchange or the connection to our website is already in place and does not depend on activating the social plug-in / "Like" button or on logging in to Facebook. If you do not want to allow Facebook to create a movement profile for you, please log out of Facebook. Closing the Facebook page is not sufficient. Please read about the purpose and scope of data collection and the additional data processing and usage by Facebook, as well as about your rights concerning this matter and settings to protect your privacy at',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: ': http://www.facebook.com/policy.php',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('https://www.facebook.com/privacy/policy/?entry_point=data_policy_redirect&entry=0'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Your California Privacy Rights',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            text: 'If you are a California resident and would like information identifying the categories of personal information which we share with our affiliates and/or third parties for marketing purposes, and the contact information for such affiliates and/or third parties, please submit a written request to the following address',
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: ': support@drivado.com',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse('mailto:support@drivado.com'));
                                    },
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                        const Row(
                          children: [
                            Expanded(
                              child: CustomText(title: 'Changes/Additions to this Data Protection Policy',
                                  height: 1.4,
                                  textAlign: TextAlign.left, color: AppColors.policyTextColor, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.policyText2Color),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Drivado reserves the right to change and expand these Privacy Policy at any time.\nPlease find information about the current status of our data protection policy from here.',
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.policyText2Color)),
                
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

