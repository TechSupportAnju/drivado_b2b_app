import 'package:drivado_b2b_app/screens/common_widgets/connectivity_widget.dart';
import 'package:drivado_b2b_app/screens/splash/splash_screen.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_repository.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/user_information_repository.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/single_company_repository.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/forgot_password/bloc/forgot_password_cubit.dart';
import 'package:drivado_b2b_app/screens/auth/forgot_password/repositories/forgot_password_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  //makes sure Flutter’s connection with the engine is ready before you run code that needs it.
  //as initializes Flutter before runApp() for things that must be set up first.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "api_key.env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ForgotPasswordCubit(repository: ForgotPasswordRepository()),
        ),
        BlocProvider<UserInformationBloc>(
          create: (context) => UserInformationBloc(userInformationRepository: UserInformationRepository(),
          ),
        ),
        BlocProvider<BookingListBloc>(
          create: (context) => BookingListBloc(
            repository: BookingListRepository(),
          ),
        ),
        BlocProvider<SingleCompanyBloc>(
          create: (context) => SingleCompanyBloc(
            repository: SingleCompanyRepository(),
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
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
          surfaceTintColor: Colors.transparent,
        ),
        fontFamily: 'PlusJakartaSans',
        primarySwatch: buildMaterialColor(AppColors.secondary),
        useMaterial3: false,
      ),
      home: const SplashPage(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: Stack(children: [child!, ConnectivityWidget()]),
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
