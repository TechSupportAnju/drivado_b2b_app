import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/add_user.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

/// Floating action-style button. [value] == 1 shows **Add user** only; add company is hidden app-wide.
Widget userCompanyAddButtonWidget(BuildContext context, int value) {
  if (value != 1) {
    return const SizedBox.shrink();
  }

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUserPage(isEdit: false),
        ),
      );
    },
    child: Card(
      color: Colors.transparent,
      shadowColor: AppColors.secondary.withOpacity(0.2),
      surfaceTintColor: AppColors.secondary.withOpacity(0.2),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: 42,
        decoration: CustomDecorations().baseBackgroundDecoration(
          50.0,
          0.0,
          AppColors.secondary,
          AppColors.secondary.withOpacity(0.4),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 17.5),
        child: const CustomText(
          title: 'Add user  +',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  );
}
