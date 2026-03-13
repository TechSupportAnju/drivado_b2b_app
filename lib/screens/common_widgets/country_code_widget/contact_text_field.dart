import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'country_code_dialog_widget.dart';

class ContactTextField extends StatefulWidget {
  final isContactValidator, controller, isTapContactName;
  final Function onChanged, onTap;
  const ContactTextField({super.key, required this.isContactValidator, required this.controller, required this.isTapContactName, required this.onChanged, required this.onTap});

  @override
  _ContactTextFieldState createState() => _ContactTextFieldState();
}

class _ContactTextFieldState extends State<ContactTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          side: BorderSide(
              color: widget.isContactValidator
                  ? AppColors.secondary
                  : Color(0xffE6E8E7)),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 10,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        cursorHeight: 15,
        cursorWidth: 1.5,
        keyboardType: TextInputType.number,
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600, fontSize: 14),
        decoration: InputDecoration(
            prefixIcon: !widget.isTapContactName?
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(
                    context),
              ],
            ) : null,
            prefix: widget.isTapContactName?
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                _countryCodePicker(
                    context), // Positioned country code picker
              ],
            ) : null,
            label: Container(
              transform: Matrix4.translationValues(0.0, -1.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: 'Contact number',
                    style: GoogleFonts.plusJakartaSans(
                        color: widget.isContactValidator ? AppColors.secondary : AppColors.textFieldTextColor,
                        fontWeight: FontWeight.w400),
                    children: const [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          )
                      )
                    ]
                ),
              ),
            ),
            isDense: true,
            border: InputBorder.none,
            hintStyle: GoogleFonts.plusJakartaSans(
                color: widget.isContactValidator ? AppColors.secondary : AppColors.textFieldTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 13),
            hintText: 'Enter your contact number'),
        onChanged: (val) {
                  widget.onChanged();
        },
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }


  Widget _countryCodePicker(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _showDropdown(context),
      child: SizedBox(
        width: countryCode.length > 4
            ? 69
            : countryCode.length > 3
            ? 60
            : 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            countryCode.isEmpty
                ? LoadingAnimationWidget.threeArchedCircle(
                color: Colors.white,
                size: 30
            )
                : CustomText(
                title: countryCode,
                color: Color(0xFF6A6A6A),
                fontSize: 14,
                fontWeight: FontWeight.w600),
            const SizedBox(width: 5),
            const Icon(Icons.expand_more_sharp,
                color: Color(0xff949494), size: 20),
          ],
        ),
      ),
    );
  }
}
void _showDropdown(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CountryCodeDialogWidget();
    },
  );
}

