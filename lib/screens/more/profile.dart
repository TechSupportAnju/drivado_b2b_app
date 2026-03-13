import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/credit_limit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../user_management/widget/custom_booking_summary_row.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


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

    return  Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFF190C0C),
            ),
            alignment: Alignment.topLeft,
            child: SafeArea(
              bottom: false,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 35, bottom: 16),
                  child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset('assets/user_management/back.svg')),
                        Spacer(),
                        CustomText(title: 'Profile',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        Spacer(),
                        SizedBox(width: 40,)
                      ]
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16, top: 16),
            padding: EdgeInsets.all(12.0),
            decoration: CustomDecorationsCards().baseBackgroundShadow(radius: 12.0, smooth: 1.0, color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 132,
                  decoration: CustomDecorationsCards().baseBackgroundShadow(radius: 12.0, smooth: 1.0, color: Color(0xFFF5F6FA)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset('assets/more/profile.svg', height: 80, width: 80,),
                      SizedBox(height: 8,),
                      CustomText(title: 'Sumit Modi',
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    CustomBookingSummaryDataRowWithIcon(
                      title: 'Email ID',
                      desc: 'www.drivado.com',
                      image: 'assets/more/profile/mail.svg',
                    ),
                    SizedBox(height:12),
                    CustomBookingSummaryDataRowWithIcon(
                      title: 'Mob. number',
                      desc: '+91 9876543210',
                      image: 'assets/more/profile/call.svg',
                    ),
                    SizedBox(height:12),
                    CustomBookingSummaryDataRowWithIcon(
                      title: 'Language',
                      desc: 'UNDEFINED',
                      image: 'assets/more/profile/lang.svg',
                    ),
                    SizedBox(height:12),
                    CustomBookingSummaryDataRowWithIcon(
                      title: 'Currency',
                      desc: 'USD',
                      image: 'assets/more/profile/currency.svg',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: CreditLimitWidget(title1: 'Total unpaid booking', title2: 'Available credit limit', value1: 'USD 462', value2: 'USD 462434'),
          ),

        ],
      ),
    );
  }
}

