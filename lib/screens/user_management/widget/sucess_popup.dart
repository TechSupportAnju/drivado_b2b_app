import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_user.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/single_user_repository.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// [label] — e.g. email (add user) or company name (add company).
/// If [userId] is set, "Know more" opens [ViewUserPage] with API load (after popping this route).
/// Otherwise it pops the dialog and the underlying screen (e.g. add form).
void showSucessDialog(
  BuildContext context,
  String label, {
  String? userId,
  bool isCompany = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, newState) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            decoration: CustomDecorations().baseBackgroundDecoration(
                16.0, 1.0, Colors.white, Colors.transparent),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 8,
                        child: Center(
                          child: SvgPicture.asset(
                              'assets/user_management/addUserPopupCheck.svg'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                  'assets/user_management/closeAddUser.svg'),
                            ),
                            const SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const CustomText(
                      title: 'Congratulations!',
                      textAlign: TextAlign.center,
                      color: Color(0xFF101828),
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                  const SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: isCompany ? 'Company ' : 'User ',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: label,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' added successfully!',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF344054),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () async {
                      final nav = Navigator.of(context);
                      final id = userId?.trim() ?? '';
                      nav.pop();
                      if (id.isEmpty) {
                        nav.pop();
                        return;
                      }
                      nav.pop();
                      final token = await AuthService.getAccessToken() ?? '';
                      if (!context.mounted) return;
                      nav.push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => SingleUserBloc(
                              repository: SingleUserRepository(),
                            )..add(
                                SingleUserFetchRequested(
                                  userId: id,
                                  accessToken: token,
                                ),
                              ),
                            child: ViewUserPage(userId: id),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 44,
                      decoration: CustomDecorations().baseBackgroundDecoration(
                          10.0,
                          1.0,
                          AppColors.secondary,
                          Colors.transparent),
                      alignment: Alignment.center,
                      child: const CustomText(
                        title: 'Know more',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
