import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shown when the users/companies management list has no rows.
class ManagementListEmptyPlaceholder extends StatelessWidget {
  const ManagementListEmptyPlaceholder({
    super.key,
    required this.isUsers,
    required this.isSearchMismatch,
  });

  final bool isUsers;
  final bool isSearchMismatch;

  static const Color _muted = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    final icon = isUsers
        ? 'assets/user_management/manageUser.svg'
        : 'assets/user_management/company.svg';
    final title = !isSearchMismatch
        ? (isUsers ? 'No users yet' : 'No companies yet')
        : (isUsers
            ? 'No users match your search.'
            : 'No companies match your search.');

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              height: 48,
              width: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            CustomText(
              title: title,
              color: _muted,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              textAlign: TextAlign.center,
              maxLine: 3,
            ),
          ],
        ),
      ),
    );
  }
}
