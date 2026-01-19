import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  TextEditingController hourlyFromController = TextEditingController();


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
      body: Stack(
        children: [
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff190C0C),
              image: DecorationImage(
                image: AssetImage('assets/create_booking/mask.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 40),
            child: Row(
              children: [
                Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.4,
                              child: CustomText(
                                title: 'Good Morning',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.4,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Let’s Explore ',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'World',
                                      style:
                                      GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.4,
                              child: CustomText(
                                title: 'With Us',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                const Spacer(),
                notificationWidget()
              ],
            ),
          ),
          Positioned(
            top: 200,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
                decoration: CustomDecorations().baseBackgroundDecoration(25.0, 1.0, Colors.white, Colors.transparent,),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      readOnly: true,
                      title: 'From',
                      hintText: 'Enter your pickup location',
                      icon: 'assets/home_page_icons/location_icon.svg',
                      controller: hourlyFromController,
                      height: 52.0,
                      astric: true,
                      width: MediaQuery.of(context).size.width,
                      error: false,
                      onTap: () {
                      },
                      onChanged: (val) {},
                      suffix: false, isPassword: false,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

