import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String icon;
  final double height;
  final int? maxLine;
  final TextInputType? keyboardType;
  final double width;
  final String hintText;
  final TextEditingController controller;
  final Function onTap;
  final Function? onTapSuffix;
  final Function onChanged;
  final bool suffix;
  final bool readOnly;
  final bool astric;
  final bool isPassword;
  final bool error;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.height,
    this.keyboardType,
    this.maxLine = 1,
    required this.width,
    required this.onChanged,
    required this.onTap,
    this.onTapSuffix,
    required this.suffix,
    required this.readOnly,
    required this.astric,
    required this.isPassword,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveLabelColor =
    error ? (Colors.red) : (Color(0xff737373));

    return Container(
      height: height,
      width: width,
      decoration: CustomDecorations().baseBackgroundDecoration(
        10.0,
        1.0,
        Colors.white,
        error? (AppColors.secondary) : ( Color(0xFFE6E8E7)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          icon == 'null'? Container() : SvgPicture.asset(icon,  color: error? AppColors.secondary : const Color(0xFF747474)),
          icon == 'null' ? Container() : const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType ?? TextInputType.text,
              maxLines: maxLine ?? 1,
              minLines: maxLine ?? 1,
              readOnly: readOnly,
              autofocus: !readOnly,
              focusNode: readOnly ? AlwaysDisabledFocusNode() : null,
              controller: controller,
              cursorColor: Colors.black,
              obscureText: suffix ? isPassword : false,
              cursorHeight: 15,
              cursorWidth: 1.5,
              textAlignVertical: TextAlignVertical.top,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                alignLabelWithHint: maxLine == 1 ? false : true,
                suffixIconConstraints: const BoxConstraints().loosen(),
                suffixIcon: error
                    ? SvgPicture.asset('assets/auth/info-circle.svg')
                    : suffix
                    ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    onTapSuffix!();
                  },
                  child: SvgPicture.asset(
                      isPassword ? 'assets/auth/eyeHide.svg' : 'assets/auth/eye.svg'),
                )
                    : null,
                label: error
                    ? null
                    : Container(
                  transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      text: readOnly
                          ? hintText
                          : title,
                      style: GoogleFonts.plusJakartaSans(
                        color: effectiveLabelColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: astric ? ' *' : '',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isDense: true,
                border: InputBorder.none,
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: error
                      ? AppColors.secondary
                      : AppColors.textFieldTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                hintText: hintText,
              ),
              onTap: () => onTap(),
              onChanged: (val) => onChanged(val),
            ),
          ),
        ],
      ),
    );
  }
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
