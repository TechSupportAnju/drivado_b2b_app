import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/constant/constant.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/screens/create_booking/select_location.dart';
import 'package:flutter/material.dart';

class HourlyWidget extends StatefulWidget {
  const HourlyWidget({super.key});

  @override
  State<HourlyWidget> createState() => _HourlyWidgetState();
}

class _HourlyWidgetState extends State<HourlyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 0,
      ),
      child: Column(
        children: [
          CustomTextField(
              readOnly: true,
              title: 'From',
              hintText: 'Enter your pickup location',
              icon: 'assets/create_booking/location_icon.svg',
              controller: hourlyFromController,
              height: 52.0,
              astric: true,
              width: MediaQuery.of(context).size.width,
              onTap: () {
                isSelectPickup = true;
                Navigator.push(context,
                  MaterialPageRoute( builder:
                        (context) =>
                            const SelectLocationPage(
                              isOneway: false,),
                  ),
                ).then((_) async {
                  durationController.clear();
                  setState(() {});
                });
              },
              onChanged: (val) {},
              suffix: false, isPassword: false,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            readOnly: true,
            title: 'Duration',
            hintText: 'Select Duration',
            icon: 'assets/create_booking/hourly_duration.svg',
            controller: durationController,
            astric: true,
            height: 52.0,
            width: MediaQuery.of(context).size.width,
            onTap: () {
              showGeneralDialog(
                useRootNavigator: false,
                context: context,
                barrierDismissible: true,
                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    child: PopScope(
                      canPop: true,
                      onPopInvokedWithResult: (bool didPop, Object? result) async {
                        setState(() {});
                      },
                      child: StatefulBuilder(
                        builder: (context, newState) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0),
                            child: Container(
                              height: 300,
                              decoration: CustomDecorations().baseBackgroundDecoration(
                                  15.0, 1.0, Colors.white, Colors.transparent),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child:  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20, top: 15, bottom: 5),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            title: 'Select Duration',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_up_sharp,
                                            color: Color(0xFFF7FAFF),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Color(0xFFF2F2F2),
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(top: 10),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        final text = '3 Hour / 60 Km';
                                        return GestureDetector(
                                          onTap: () {
                                            durationController.text = text;
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child:
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                durationController.text = text;
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Row(
                                                        children: [
                                                          CustomText(
                                                            title: text,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Color(0xFFF7FAFF),
                                                      thickness: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  final curve = Curves.easeInOut.transform(animation.value);
                  return Transform.scale(
                    scale: curve,
                    child: child,
                  );
                },
              );
            },
            onChanged: (val) {},
            suffix: true, isPassword: false, isExpand: true,
          )
        ],
      ),
    );
  }
}