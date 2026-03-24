import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
import 'package:drivado_b2b_app/screens/auth/login/repositories/login_repository.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

showLogoutPopup(context) {
  return  showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(12),
        contentPadding: const EdgeInsets.only(top: 8, left: 45, right: 45, bottom: 16),
        backgroundColor:  Colors.white,
        shape:  SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12,
            cornerSmoothing: 1.0,
          ),
        ),
        title: Column(
          children: [
            SvgPicture.asset('assets/more/logoutpopUp.svg', height: 48,),
            SizedBox(height: 16,),
            CustomText(
                title: 'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF0D0D0D),
                fontWeight: FontWeight.w600),
          ],
        ),
        content: CustomText(
            title: 'You will be signed out of your account. Don’t worry, your booking history and saved details will stay safe.',
            textAlign: TextAlign.center,
            fontSize: 12,
            height: 1.4,
            color: Color(0xFF606060),
            fontWeight: FontWeight.w400),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 42,
                      decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.secondary, AppColors.secondary),
                      alignment: Alignment.center,
                      child: CustomText(title: 'Keep, logged in',
                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      final bookingBloc = context.read<BookingListBloc>();
                      final userBloc = context.read<UserInformationBloc>();
                      final companyBloc = context.read<SingleCompanyBloc>();
                      final token = await AuthService.getAccessToken();
                      await LoginRepository().logout(token);
                      await AuthService.logout();
                      bookingBloc.add(const BookingListReset());
                      userBloc.add(const UserInformationReset());
                      companyBloc.add(const SingleCompanyReset());
                      if (!context.mounted) return;
                      navigator.pop();
                      navigator.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: Container(
                        height: 42,
                        decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, Color(0xFF606060)),
                        alignment: Alignment.center,
                        child: CustomText(title: 'Yes, Logout', color: Color(0xFF606060), fontSize: 14, fontWeight: FontWeight.w500)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}