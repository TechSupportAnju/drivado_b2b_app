import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/add_company.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/add_user.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

userCompanyAddButtonWidget(context, value){
  return  GestureDetector(
    onTap: () {
      if(value == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserPage(isEdit: false)));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddCompanyPage(isEdit: false,)));
      }
    },
    child: Card(
      color: Colors.transparent,
      shadowColor: AppColors.secondary.withOpacity(0.4),
      surfaceTintColor: AppColors.secondary.withOpacity(0.4),
      elevation: 14.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: 42,
        decoration: CustomDecorations().baseBackgroundDecoration(50.0, 0.0, AppColors.secondary, AppColors.secondary.withOpacity(0.4)),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 17.5),
        child: CustomText(title: '${value == 1 ? 'Add user' : 'Add company'}  +', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
}