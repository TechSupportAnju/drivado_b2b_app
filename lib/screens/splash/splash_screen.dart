import 'dart:developer';

import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/auth/login/repositories/login_repository.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
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
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      final email = await AuthService.getEmail();
      if (email != null && email.isNotEmpty) {
        try {
          final newToken = await LoginRepository().fetchAccessToken(email);
          await AuthService.saveAccessToken(newToken);
        } catch (e, st) {
          log('Splash: refresh access token failed: $e', stackTrace: st);
        }
      }
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => loggedIn ? RootShell() : const LoginPage(),
      ),
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
            'assets/logo.png',
            height: 1470,
          ),
        ),
      ),
    );
  }
}
