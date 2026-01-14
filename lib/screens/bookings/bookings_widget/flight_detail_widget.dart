import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlightDetailWidget extends StatefulWidget {
  const FlightDetailWidget({super.key});

  @override
  State<FlightDetailWidget> createState() => _FlightDetailWidgetState();
}
bool isFlightTap = false;
class _FlightDetailWidgetState extends State<FlightDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              isFlightTap = !isFlightTap;
            });
          },
          child: isFlightTap? 
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.38,
                      child: Row(
                        children: [
                          const CustomText(
                            title: 'ETA',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          const Spacer(),
                          SvgPicture.asset('assets/arrival.svg', height: 15),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.38,
                      child: const Row(
                        children: [
                          CustomText(
                            title: '10-05-2024 9:15 AM',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        CustomText(
                          title: 'On Time',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        CustomText(
                          title:  'Terminal No. 04',
                          fontSize: MediaQuery.of(context).size.height * 0.013,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.38,
                      child: const Row(
                        children: [
                          CustomText(
                            title: 'STA',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.38,
                      child: Row(
                        children: [
                          CustomText(
                            title: '10-05-2024 9:15 AM',
                            fontSize: MediaQuery.of(context).size.height * 0.013,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                          const Spacer(),
                          SvgPicture.asset('assets/departure.svg', height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                const Column(
                  children: [
                    CustomText(
                      title: 'DOH',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    DottedLine(
                      direction: Axis.vertical,
                      lineLength: 75,
                      lineThickness: 1.5,
                      dashLength: 3.0,
                      dashColor: Colors.transparent,
                      dashRadius: 0.0,
                      dashGapLength: 3.0,
                      dashGapColor: Colors.black,
                      dashGapRadius: 0.0,
                    ),
                    CustomText(
                      title: 'IND',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          )
          : Container(
            // width: MediaQuery.of(context).size.width * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 38,
            alignment: Alignment.center,
            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Colors.grey),
            child: Row(
              children: [
                SvgPicture.asset('assets/flight.svg'),
                const SizedBox(width: 4,),
                const CustomText(title: 'Flight Status', color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
              ],
            ),
          ),
        ),
        isFlightTap ? Container(): const SizedBox(height: 35,)
      ],
    );
  }
}