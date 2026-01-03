import 'dart:developer';
import 'package:drivado_b2b_app/screens/Onboarding/onboarding.dart';
import 'package:drivado_b2b_app/screens/home/home_screens/home_page.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appStarted();
    });
  }

  Future<void> appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
        MaterialPageRoute(
          builder: (_) => const RootShell(bottomBarIndex: 0),
      ),
      //MaterialPageRoute(builder: (context) => HomePage())
      //Onboarding(isLogin: false)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Center(
          child: Image.asset(
            'assets/logo.png', height: 1470,
          ),
        ),
      ),
    );
  }
}