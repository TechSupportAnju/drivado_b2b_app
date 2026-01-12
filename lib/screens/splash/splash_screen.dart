import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

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
      context, MaterialPageRoute(builder: (context) => LoginPage())
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