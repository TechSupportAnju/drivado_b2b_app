import 'package:drivado_b2b_app/models/single_company_management_models.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_company.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_user.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/single_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [value] 1 = user row, 2 = company row (matches [AnimatedToggleManagement]).
/// For company rows, pass [company]. For user rows, pass [userId] for the API.
Widget userCompanyListTileWidget(
  BuildContext context,
  String title,
  int value, {
  ManagedChildCompany? company,
  String? userId,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () async {
      if (value == 1) {
        final id = userId?.trim() ?? '';
        if (id.isEmpty) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Missing user id.')),
            );
          }
          return;
        }
        final token = await AuthService.getAccessToken() ?? '';
        if (!context.mounted) return;
        Navigator.push(
          context,
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
      } else if (company != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCompanyPage(company: company),
          ),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            value == 1
                ? 'assets/user_management/manageUser.svg'
                : 'assets/user_management/company.svg',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              title: title,
              color: const Color(0xff0D0D0D),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
