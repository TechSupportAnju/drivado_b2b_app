import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/more/account_settings_page.dart';
import 'package:drivado_b2b_app/screens/more/profile.dart';
import 'package:drivado_b2b_app/screens/more/widgets/profile_user_avatar.dart';
import 'package:drivado_b2b_app/screens/policy_screens/faq.dart';
import 'package:drivado_b2b_app/screens/policy_screens/privacy_policy.dart';
import 'package:drivado_b2b_app/screens/policy_screens/terms_and_condition.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/account_widget.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureUserProfileLoaded());
  }

  Future<void> _ensureUserProfileLoaded() async {
    if (!mounted) return;
    final bloc = context.read<UserInformationBloc>();
    final s = bloc.state;
    if (s is UserInformationLoaded || s is UserInformationLoading) return;
    final token = await AuthService.getAccessToken();
    if (!mounted || token == null || token.isEmpty) return;
    bloc.add(UserInformationLoadDetails(accessToken: token));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return  Scaffold(
      body: Container(
        color: Color(0xFFF5F6FA),
        width: screenWidth,
        height: screenHeight,
        child: Column(
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
                        left: 20.0, right: 20, top: 30, bottom: 23),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(title: 'More',
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ]
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<UserInformationBloc, UserInformationState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfilePage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: CustomDecorations().baseBackgroundDecoration(
                              16.0, 1.0, Colors.white, const Color(0xFFE6E8E7)),
                          child: Row(
                            children: [
                              if (state is UserInformationLoading)
                                const SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Center(
                                    child: SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                )
                              else if (state is UserInformationLoaded)
                                ProfileUserAvatar(user: state.userData, size: 48)
                              else
                                ProfileUserAvatar(user: null, size: 48),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: state is UserInformationLoaded
                                          ? state.userData.displayName
                                          : state is UserInformationError
                                              ? 'Profile unavailable'
                                              : 'Loading…',
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0D0D0D),
                                      fontSize: 16,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                      title: state is UserInformationLoaded
                                          ? (state.userData.email ?? '—')
                                          : state is UserInformationError
                                              ? state.message
                                              : '',
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF606060),
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Color(0xFFE6E8E7)),
                    child: Column(
                      children: [
                        AccountPageHeader(
                          text: 'Account Setting',
                          image: 'assets/more/sett.svg',
                          route: AccountSettingPage(),
                          isMore: false,
                        ),
                        SizedBox(height: 20,),
                        AccountPageHeader(
                          text: 'Terms & Conditions',
                          image: 'assets/more/t&c.svg',
                          route: TermsAndConditionPage(),
                        ),
                        SizedBox(height: 20,),
                        const AccountPageHeader(
                          text: 'Privacy Policy',
                          image: 'assets/more/privacy.svg',
                          route: PrivacyPolicyPage(),
                        ),
                        SizedBox(height: 20,),
                        AccountPageHeader(
                          text: 'FAQ\'S',
                          image: 'assets/more/faq.svg',
                          route: FaqPage(),
                        ),
      
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Color(0xFFE6E8E7)),
                    child: Column(
                      children: [
                        const AccountPageHeader(
                          text: 'Logout',
                          image: 'assets/more/logout.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

