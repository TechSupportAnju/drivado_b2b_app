import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/more/widgets/profile_user_avatar.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/credit_limit_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_booking_summary_row.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static String _dash(String? s) {
    final t = s?.trim() ?? '';
    return t.isEmpty ? '—' : t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Spacer(),
                    const CustomText(
                        title: 'Profile',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserInformationBloc, UserInformationState>(
              builder: (context, state) {
                if (state is UserInformationLoading ||
                    state is UserInformationInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserInformationError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: state.message,
                            color: const Color(0xFF606060),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () async {
                              final token = await AuthService.getAccessToken();
                              if (!context.mounted ||
                                  token == null ||
                                  token.isEmpty) {
                                return;
                              }
                              context.read<UserInformationBloc>().add(
                                    UserInformationLoadDetails(
                                        accessToken: token),
                                  );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is! UserInformationLoaded) {
                  return const SizedBox.shrink();
                }
                final u = state.userData;
                final company = u.company;
                final cur = company?.currency?.trim();
                final prefix =
                    (cur != null && cur.isNotEmpty) ? cur : 'USD';
                final unpaid = u.unpaidBooking;
                final available = company?.availableLimit;
                final unpaidLabel =
                    unpaid != null ? '$prefix $unpaid' : '—';
                final availLabel = available != null
                    ? '$prefix $available'
                    : '—';

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 16),
                        padding: const EdgeInsets.all(12.0),
                        decoration:
                            CustomDecorationsCards().baseBackgroundShadow(
                                radius: 12.0,
                                smooth: 1.0,
                                color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 132,
                              decoration: CustomDecorationsCards()
                                  .baseBackgroundShadow(
                                      radius: 12.0,
                                      smooth: 1.0,
                                      color: const Color(0xFFF5F6FA)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProfileUserAvatar(user: u, size: 80),
                                  const SizedBox(height: 8),
                                  CustomText(
                                      title: u.displayName,
                                      color: const Color(0xFF0D0D0D),
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
                                  desc: _dash(u.email),
                                  image: 'assets/more/profile/mail.svg',
                                ),
                                const SizedBox(height: 12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Mob. number',
                                  desc: _dash(u.mobile),
                                  image: 'assets/more/profile/call.svg',
                                ),
                                const SizedBox(height: 12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Language',
                                  desc: _dash(u.language),
                                  image: 'assets/more/profile/lang.svg',
                                ),
                                const SizedBox(height: 12),
                                CustomBookingSummaryDataRowWithIcon(
                                  title: 'Currency',
                                  desc: _dash(company?.currency),
                                  image: 'assets/more/profile/currency.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: CreditLimitWidget(
                          title1: 'Total unpaid booking',
                          title2: 'Available credit limit',
                          value1: unpaidLabel,
                          value2: availLabel,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
