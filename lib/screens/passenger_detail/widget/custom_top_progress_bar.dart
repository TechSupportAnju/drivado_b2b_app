import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTopProgressBar extends StatelessWidget {
  final int tabCount;
  final bool isActive;
  const CustomTopProgressBar(
      {super.key, required this.tabCount, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isActive
                ? Image.asset('assets/check.png', height: 16,)
                :  tabCount == 0
                ? const Icon(Icons.circle , size: 20, color:  AppColors.secondary )
                :Image.asset('assets/check.png', height: 16,),
            isActive
                ? customDottedLineBlack(context)
                : tabCount == 0
                ? customDottedLine(context)
                : customDottedLineBlack(context),
            isActive
                ? const Icon(Icons.circle, size: 20, color: AppColors.secondary,)
                : tabCount == 0
                ? const Icon(Icons.circle, size: 20, color: Color(0xFFD9D9D9),)
                : Image.asset('assets/check.png', height: 16,),
            tabCount == 2
                ? customDottedLineBlack(context)
                : customDottedLine(context),
            tabCount == 2
                ? Image.asset('assets/check.png', height: 16,)
                : const Icon(Icons.circle, size: 20, color: Color(0xFFD9D9D9),),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Container(
             alignment: Alignment.centerLeft,
                child: const CustomText(title: 'Basic Information', color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
            Spacer(),
            Container(
              alignment: Alignment.center,
                child: CustomText(title: 'Booking Summary', color: tabCount == 0 ? Color(0xffADADAD) : Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
            Spacer(),
            Container(
                alignment: Alignment.centerLeft,
                child: CustomText(title: 'Booking Payment', color: tabCount == 2 ? Colors.black : Color(0xffADADAD) , fontWeight: FontWeight.w600, fontSize: 10)),
          ],
        ),
      ],
    );
  }

  Widget customDottedLine(context) => DottedLine(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    lineLength: MediaQuery.of(context).size.width >=650 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.3,
    lineThickness: 1.0,
    dashLength: 4.0,
    dashColor: Color(0xFFD9D9D9),
    dashRadius: 20.0,
    dashGapLength: 4.0,
    dashGapColor: Colors.transparent,
    dashGapRadius: 0.0,
  );

  Widget customDottedLineBlack(context)  => DottedLine(
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    lineLength: MediaQuery.of(context).size.width >=650 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.3,
    lineThickness: 1.0,
    dashLength: 4.0,
    dashColor: Colors.black,
    dashRadius: 20.0,
    dashGapLength: 4.0,
    dashGapColor: Colors.transparent,
    dashGapRadius: 0.0,
  );
}