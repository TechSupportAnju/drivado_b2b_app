import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/screens/create_booking/select_location.dart';
import 'package:flutter/material.dart';

class OnewayWidget extends StatefulWidget {
  const OnewayWidget({super.key});

  @override
  State<OnewayWidget> createState() => _OnewayWidgetState();
}

class _OnewayWidgetState extends State<OnewayWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 128,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 21,
            right: 21,
            top: 2,
            child: CustomTextField(
              readOnly: true,
              title: 'From',
              hintText: 'Enter your pickup location',
              icon: 'assets/create_booking/location_icon.svg',
              astric: true,
              controller: fromController,
              height: 52.0,
              width: MediaQuery.of(context,).size.width / 1.13,
              onTap: () async {
                isSelectPickup = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                    const SelectLocationPage(
                      isOneway: true,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              onChanged: (val) async {
              },
              suffix: false, isPassword: false,
            ),
          ),
          Positioned(
            top: 74,
            left: 21,
            right: 21,
            bottom: 2,
            child: CustomTextField(
              readOnly: true,
              title: 'To',
              hintText: 'Enter your drop off location',
              icon: 'assets/create_booking/location_icon.svg',
              astric: true,
              controller: toController,
              height: 52.0,
              width: MediaQuery.of(context,).size.width / 1.13,
              onTap: () {
                isSelectPickup = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                    const SelectLocationPage(
                      isOneway: true,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              onChanged: (val) {
              },
              suffix: false, isPassword: false,
            ),
          ),
        ],
      ),
    );
  }
}