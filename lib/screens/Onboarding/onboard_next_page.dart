import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class OnboardNextPage extends StatefulWidget {
  final bool? isLogin;
  const OnboardNextPage({required this.isLogin, super.key});

  @override
  State<OnboardNextPage> createState() => _OnboardNextPageState();
}

class _OnboardNextPageState extends State<OnboardNextPage> {

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width:  MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/splash/onbarding.png', ), fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CustomText(title: 'Enjoy the Drivado Experience',
                  textAlign: TextAlign.center,
                  height: 1.3,color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              const SizedBox(height: 10,),
              const CustomText(title: 'Book and receive instant confirmation. ',
                  textAlign: TextAlign.center,
                  height: 1.2,color: Colors.white, fontWeight: FontWeight.w300, fontSize: 15),
                  const SizedBox(height: 10,),
              const SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomButtons(
                    isIcon: false,
                    onTap: () {
                  Navigator.of(context).push(SwipeablePageRoute(
                    transitionDuration: const Duration(milliseconds: 700),
                    builder: (BuildContext context) => const LoginPage(),
                  ));
                }, title: 'Let\'s Go', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            ],
          ),
        ),
      ),
    );
  }
}