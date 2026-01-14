import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SvgPicture.asset('assets/thankyou.svg'),
          SizedBox(height: 20,),
          CustomText(title: 'Thank You', color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
          SizedBox(height: 12,),
          CustomText(title: 'Our team will contact you soon!', color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 16),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_backspace, color: AppColors.secondary,),
                SizedBox(width: 16,),
                CustomText(title: 'Back', color: AppColors.secondary, fontWeight: FontWeight.w600, fontSize: 16),
              ],
            ),
          ),
          SizedBox(height: 150,),
        ],
      ),
    );
  }
}