import 'package:drivado_b2b_app/screens/common_widgets/connectivity_widget.dart';
import 'package:drivado_b2b_app/screens/splash/splash_screen.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/login/bloc/login_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/login/repositories/login_repository.dart';
import 'package:drivado_b2b_app/screens/auth/signup/bloc/signup_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/signup/repositories/sign_up_repository.dart';
import 'package:drivado_b2b_app/screens/auth/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:drivado_b2b_app/screens/auth/forgot_password/repositories/forgot_password_repository.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(repository: LoginRepository()),
        ),
        BlocProvider(
          create: (_) => SignupCubit(repository: SignupRepository()),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordCubit(
            repository: ForgotPasswordRepository(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drivado b2b',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        primarySwatch: buildMaterialColor(AppColors.secondary),
        useMaterial3: false,
      ),
      home: SplashPage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            ConnectivityWidget(),
          ],
        );
      },
    );
  }
  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

