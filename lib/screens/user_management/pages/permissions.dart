import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_radio.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  var radioList = ['Disable', 'Enable', 'Read Only'];
  var innerRadioList = ['Enable', 'Disable'];
  var innerSecondRadioList = ['Branch Level', 'Child Company'];
  List title = ['New Booking', 'Flat Rates', 'Manage Booking', 'Affiliate', 'Regions', 'Flat Regions', 'General Settings', 'User Management', 'Vehicle Types', 'Image Uploader', 'API Docs'];
  List image = ['assets/Permissions/booking.svg', 'assets/Permissions/flatRates.svg', 'assets/Permissions/manageBooking.svg', 'assets/Permissions/affiliate.svg', 'assets/Permissions/regions.svg', 'assets/Permissions/flatRegions.svg', 'assets/Permissions/setting.svg', 'assets/Permissions/userManagement.svg', 'assets/Permissions/vehicleType.svg', 'assets/Permissions/imgUploader.svg', 'assets/Permissions/apiDocs.svg'];
  var selectedItemNew = 0;

  bool isNewBooking = false;
  bool isManageBooking = false;
  bool isUserManagement = false;


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff190C0C),
          centerTitle: true,
          leading:GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SvgPicture.asset('assets/back.svg'),
              )),
          title:  const CustomText(title: 'Permissions', color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 20),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.only(top: 14.0, bottom: 14),
            itemCount: title.length + 1,
            itemBuilder: (context, index) {
            return index == title.length
                ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                                height: 48,
                                width: screenWidth,
                                alignment: Alignment.center,
                                decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, AppColors.secondary, AppColors.secondary),
                                child: CustomText(title: 'Update', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
              child: Container(
                decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, AppColors.strokeColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Row(
                         children: [
                           SvgPicture.asset('${image[index]}'),
                           const SizedBox(width: 8,),
                           CustomText(title: '${title[index]}', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 14),
                           const Spacer(),
                           index== 0 || index == 2 || index == 7
                               ? GestureDetector(
                                 onTap: () {
                                   if(index == 0) {
                                     setState(() {
                                       isNewBooking = !isNewBooking;
                                     });
                                   } else if(index == 2) {
                                     setState(() {
                                       isManageBooking = !isManageBooking;
                                     });
                                   } else if(index == 7) {
                                     setState(() {
                                       isUserManagement = !isUserManagement;
                                     });
                                   }
                                 },
                                 child: SvgPicture.asset('assets/Permissions/expand.svg')) : Container(),
                         ],
                       ),
                     ),
                     Container(
                       height: 34,
                       width: screenWidth,
                       decoration: ShapeDecoration(
                         color: Color(0xFFF2EDED),
                         shape: SmoothRectangleBorder(
                           side: BorderSide(color: Color(0xFFF2EDED)),
                           borderRadius: SmoothBorderRadius.only(
                             bottomLeft: SmoothRadius(cornerRadius: 7.0, cornerSmoothing: 1.0),
                             bottomRight: SmoothRadius(cornerRadius: 7.0, cornerSmoothing: 1.0),
                           ),
                         ),
                       ),
                       alignment: Alignment.centerLeft,
                       child: RadioGroup(
                           scrollDirection: Axis.horizontal,
                           items: radioList,
                           selectedItem: selectedItemNew,
                           onChanged: (value) {
                             selectedItemNew = index;
                           },
                           labelBuilder: (ctx, index) {
                             return CustomText(
                               title: radioList[index],
                               fontWeight: FontWeight.w500,
                               fontSize: 12,
                               color: Color(0xFF606060),
                             );
                           },
                           shrinkWrap: true,
                       ),
                     ),
                    isNewBooking && index == 0
                        ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                          children: [
                            Row(
                            children: [
                              CustomText(title: 'Perform Search', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 10),
                              Spacer(),
                              SizedBox(
                                height: 20,
                                child: RadioGroup(
                                  scrollDirection: Axis.horizontal,
                                  items: innerRadioList,
                                  selectedItem: selectedItemNew,
                                  onChanged: (value) {
                                    selectedItemNew = index;
                                  },
                                  labelBuilder: (ctx, index) {
                                    return CustomText(
                                      title: innerRadioList[index],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF606060),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                            SizedBox(height: 16,),
                            Row(
                            children: [
                              CustomText(title: 'Make Booking', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 10),
                              Spacer(),
                              SizedBox(
                                height: 20,
                                child: RadioGroup(
                                  scrollDirection: Axis.horizontal,
                                  items: innerRadioList,
                                  selectedItem: selectedItemNew,
                                  onChanged: (value) {
                                    selectedItemNew = index;
                                  },
                                  labelBuilder: (ctx, index) {
                                    return CustomText(
                                      title: innerRadioList[index],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF606060),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                            SizedBox(height: 16,),
                            Row(
                            children: [
                              CustomText(title: 'Requested Booking', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 10),
                              Spacer(),
                              SizedBox(
                                height: 20,
                                child: RadioGroup(
                                  scrollDirection: Axis.horizontal,
                                  items: innerRadioList,
                                  selectedItem: selectedItemNew,
                                  onChanged: (value) {
                                    selectedItemNew = index;
                                  },
                                  labelBuilder: (ctx, index) {
                                    return CustomText(
                                      title: innerRadioList[index],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF606060),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                          ],
                          ),
                        )
                        : isManageBooking && index == 2
                        ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(title: 'View Booking', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 10),
                              SizedBox(
                                height: 60,
                                width: 110,
                                child: RadioGroup(
                                  isSpace: false,
                                  scrollDirection: Axis.vertical,
                                  items: innerRadioList,
                                  selectedItem: selectedItemNew,
                                  onChanged: (value) {
                                    selectedItemNew = index;
                                  },
                                  labelBuilder: (ctx, index) {
                                    return CustomText(
                                      title: innerRadioList[index],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF606060),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  width: 195,
                                  child: RadioGroup(
                                    isSpace: false,
                                    scrollDirection: Axis.vertical,
                                    items: innerSecondRadioList,
                                    selectedItem: selectedItemNew,
                                    onChanged: (value) {
                                      selectedItemNew = index;
                                    },
                                    labelBuilder: (ctx, index) {
                                      return CustomText(
                                        title: innerSecondRadioList[index],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFF606060),
                                      );
                                    },
                                    shrinkWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) : Container()
                  ],
                ),
              ),
            );
          }
        )
    );
  }

}

