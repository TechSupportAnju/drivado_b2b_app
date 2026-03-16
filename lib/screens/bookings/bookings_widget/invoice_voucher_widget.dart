import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
enum SelectedOption {
  invoice,
  voucher,
  driverDetails,
}
class CustomCheckRadio extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CustomCheckRadio({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0XFF606060),
            width: 1.5,
          ),
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              ) : null,
      ),
    );
  }
}


class InvoiceVoucherWidget extends StatelessWidget {
  final String title;
  final String image;
  final String footerText;
  final SelectedOption value;
  final SelectedOption? groupValue;
  final ValueChanged<SelectedOption> onChanged;

  const InvoiceVoucherWidget({
    super.key,
    required this.title,
    required this.image,
    required this.footerText,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        decoration: CustomDecorationsCards().baseBackgroundShadow(
          radius: 12,
          smooth: 1,
          color: Colors.white,
          borderColor: isSelected ? Color(0x7F606060) : Color(0x7F606060),
          width: 0.8,
          boxShadowColor: const Color(0XFF474747).withOpacity(0.1),
          blurRadius: 15,
          y: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(image),
                  CustomCheckRadio(
                    isSelected: isSelected,
                    onTap: () => onChanged(value),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomText(
                title: title,
                fontSize: 16,
                color: const Color(0XFF0D0D0D),
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0XFFF5F6FA),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Center(
                child: CustomText(
                  title: footerText,
                  fontSize: 12,
                  color: const Color(0XFF0D0D0D),
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverDetailsWidget extends StatelessWidget {
  final SelectedOption value;
  final SelectedOption? groupValue;
  final ValueChanged<SelectedOption> onChanged;

  const DriverDetailsWidget({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0x7F606060) : Color(0x7F606060),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.person_outline),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Driver Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            CustomCheckRadio(
              isSelected: isSelected,
              onTap: () => onChanged(value),
            ),
          ],
        ),
      ),
    );
  }
}


