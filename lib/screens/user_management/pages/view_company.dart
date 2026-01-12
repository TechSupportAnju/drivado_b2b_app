import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_booking_summary_row.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/view_company_side_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_company.dart';

class ViewCompanyPage extends StatefulWidget {
  const ViewCompanyPage({super.key});

  @override
  State<ViewCompanyPage> createState() => _ViewCompanyPageState();
}

class _ViewCompanyPageState extends State<ViewCompanyPage> {
  bool status = true;

  int isSelect = 0;

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
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff190C0C),
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/back.svg')),
                          Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: CustomText(textAlign: TextAlign.right,
                                          title: 'Hello Sumit', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                                ],
                              ),
                              SizedBox(height: 3,),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child:CustomText(textAlign: TextAlign.right,
                                      title: 'test@drivado.com', color: Color(0xFFAEB1C1), fontWeight: FontWeight.w500, fontSize: 14)),
                            ],
                          ),
                          SizedBox(width: 16,),
                          Image.asset('assets/userPic.png', height: 40,),
                        ]
                    )
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: screenSize.height,
                      decoration: CustomDecorations()
                          .baseBackgroundDecoration(
                          10.0, 1.0,  Color(0xffffffff),
                          Color(0xFFEDF1F3)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            CustomViewCompanyWidget(title: 'Profile', icon: 'assets/profileUnsel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 0;
                                });
                            }, isSelect: isSelect, index: 0,),
                            SizedBox(height: 25,),
                            CustomViewCompanyWidget(title: 'Users', icon: 'assets/userSel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 1;
                                });
                            }, isSelect: isSelect, index: 1,),
                            SizedBox(height: 25,),
                            CustomViewCompanyWidget(title: 'Companies', icon: 'assets/companyUnsel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 2;
                                });
                            }, isSelect: isSelect, index: 2,),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: screenSize.width - 70,
                      height: screenSize.height,
                      child: isSelect == 0
                      ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              decoration: CustomDecorations()
                                  .baseBackgroundDecoration(
                                  10.0, 1.0,  Color(0xffffffff),
                                  Color(0xFFEDF1F3)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(title: 'Company Details', color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 16),
                                      Spacer(),
                                      CustomSwitch(
                                        isText: true,
                                        value: status,
                                        onChanged: (value) {
                                          print("VALUE : $value");
                                          setState(() {
                                            status = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  // isAdmin
                                  //     ? Container(
                                  //   height: 40,
                                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                                  //   decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
                                  //   child: Row(
                                  //     children: [
                                  //       const CustomText(title: 'Meet & Greet', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w500, fontSize: 12),
                                  //       Spacer(),
                                  //       CustomText(title: 'With', color: status ? AppColors.secondary : AppColors.userManagementswitchTextColor, fontWeight: status ? FontWeight.w600 : FontWeight.w500, fontSize: 10),
                                  //       SizedBox(width: 5),
                                  //       CustomSwitch(
                                  //         // activeColor: Colors.pinkAccent,
                                  //         value: status,
                                  //         onChanged: (value) {
                                  //           print("VALUE : $value");
                                  //           setState(() {
                                  //             status = value;
                                  //           });
                                  //         }, isText: false,
                                  //       ),
                                  //       SizedBox(width: 5),
                                  //       CustomText(title: 'Without', color: !status ? AppColors.secondary : AppColors.userManagementswitchTextColor, fontWeight: !status ? FontWeight.w600 : FontWeight.w500, fontSize: 10),
                                  //     ],
                                  //   ),
                                  // ) : Container(),
                                  // isAdmin
                                  //     ? SizedBox(height: 8,): Container(),
                                  // isAdmin
                                  //     ? GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddCompanyPage(isEdit: true,)));
                                  //     },
                                  //       child: Container(
                                  //                                           height: 51,
                                  //                                           width: screenWidth,
                                  //                                           padding: EdgeInsets.symmetric(horizontal: 15),
                                  //                                           decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
                                  //                                           child: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         SvgPicture.asset('assets/editComp.svg'),
                                  //         SizedBox(height: 5),
                                  //         const CustomText(title: 'Edit Company', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w500, fontSize: 10),
                                  //       ],
                                  //                                           ),
                                  //                                         ),
                                  //     ) : Container(),
                                  // const SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage('assets/userPic.png'),
                                          ),
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.white, width: 1.5),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // AccountInfoWidget(
                                          //     text: 'Drivado transfers pvt ltd.',
                                          //     style: GoogleFonts.plusJakartaSans(
                                          //       fontWeight: FontWeight.w600,
                                          //       color: AppColors.accountUserNameColor,
                                          //       fontSize: 16,
                                          //     )),
                                          const SizedBox(height: 3),
                                          Container(
                                            // width: screenWidth /1.5,
                                            child: Row(
                                              children: [
                                                CustomText(
                                                    title: 'help@drivado.com',
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF3A434C),
                                                    fontSize: 12),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Column(
                                    children: [
                                      SizedBox(height:10),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Website :',
                                        desc: 'www.drivado.com',
                                        image: 'assets/website.svg',
                                      ),
                                      SizedBox(height:10),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Mob. number :',
                                        desc: '+91 9876543210',
                                        image: 'assets/phone.svg',
                                      ),
                                      SizedBox(height:10),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'GST/VAT :',
                                        desc: 'UNDEFINED',
                                        image: 'assets/gst.svg',
                                      ),
                                      SizedBox(height:10),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Address :',
                                        desc: 'Mezzanine Floor, The Travel Centre, Sheikh Zayed Road, PO Box 75142, Dubai, UAE',
                                        image: 'assets/address.svg',
                                      ),
                                    ],
                                  ),
                                  // isAdmin
                                  //     ? Column(
                                  //       children: [
                                  //         const SizedBox(height: 15,),
                                  //         Row(
                                  //          children: [
                                  //         Expanded(
                                  //           flex: 1,
                                  //           child: Container(
                                  //               height: 40,
                                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                                  //               decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
                                  //               child: Column(
                                  //                   mainAxisAlignment: MainAxisAlignment.center,
                                  //                   children: [
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: 'User Markup', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w600, fontSize: 8),
                                  //                       ],
                                  //                     ),
                                  //                     SizedBox(height: 4),
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: '0%', color: AppColors.secondary, fontWeight: FontWeight.w500, fontSize: 12),
                                  //                       ],
                                  //                     ),
                                  //                   ]
                                  //               )
                                  //           ),
                                  //         ),
                                  //         const SizedBox(width: 8,),
                                  //         Expanded(
                                  //           flex: 1,
                                  //           child: Container(
                                  //               height: 40,
                                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                                  //               decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
                                  //               child: Column(
                                  //                   mainAxisAlignment: MainAxisAlignment.center,
                                  //                   children: [
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: 'User Discount', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w600, fontSize: 8),
                                  //                       ],
                                  //                     ),
                                  //                     SizedBox(height: 4),
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: '0%', color: AppColors.bookingCardGreenColor, fontWeight: FontWeight.w500, fontSize: 12),
                                  //                       ],
                                  //                     ),
                                  //                   ]
                                  //               )
                                  //           ),
                                  //         ),
                                  //                                             ],
                                  //                                           ),
                                  //         const SizedBox(height: 8,),
                                  //         Row(
                                  //          children: [
                                  //         Expanded(
                                  //           flex: 1,
                                  //           child: Container(
                                  //               height: 40,
                                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                                  //               decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
                                  //               child: Column(
                                  //                   mainAxisAlignment: MainAxisAlignment.center,
                                  //                   children: [
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: 'Company total credit limit', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w600, fontSize: 8),
                                  //                       ],
                                  //                     ),
                                  //                     SizedBox(height: 4),
                                  //                     Row(
                                  //                       children: [
                                  //                         const CustomText(title: 'USD 1,30,000', color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w600, fontSize: 12),
                                  //                       ],
                                  //                     ),
                                  //                   ]
                                  //               )
                                  //           ),
                                  //         ),
                                  //        ],
                                  //         ),
                                  //       ],
                                  //     ) : Container(),
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              decoration: CustomDecorations()
                                  .baseBackgroundDecoration(
                                  10.0, 1.0,  Color(0xffffffff),
                                  Color(0xFFEDF1F3)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                          title: 'Credit Limit',
                                          color: Color(0xFF6B7280),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      CustomText(title: 'Total unpaid booking',
                                          color: Color(0xFF6B7280),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      Spacer(),
                                      CustomText(title: 'USD 462',
                                          color: AppColors.textFieldLabelTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      CustomText(title: 'Available credit limit',
                                          color: Color(0xFF6B7280),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      Spacer(),
                                      CustomText(title: 'USD 462434',
                                          color: AppColors.textFieldLabelTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        )
                      )
                          : Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/userPic.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                ),
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // AccountInfoWidget(
                                  //     text: 'Drivado transfers pvt ltd.',
                                  //     style: GoogleFonts.plusJakartaSans(
                                  //       fontWeight: FontWeight.w600,
                                  //       color: AppColors.accountUserNameColor,
                                  //       fontSize: 16,
                                  //     )),
                                  const SizedBox(height: 3),
                                  Container(
                                    // width: screenWidth /1.5,
                                    child: Row(
                                      children: [
                                        CustomText(
                                            title: 'help@drivado.com',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF3A434C),
                                            fontSize: 12),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 52,
                            width: screenWidth ,
                            decoration: CustomDecorations().draggableSheetDecoration(10.0, 0.0, 10.0, 0.0, 1.0,  Colors.white, Color(0xFFEDF1F3)),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIconConstraints: const BoxConstraints().loosen(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                                  child: SvgPicture.asset('assets/search.svg', height: 18,
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xFFC0C0C0), BlendMode.srcIn)
                                  ),
                                ),
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    color: Color(0xFFC0C0C0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                hintText: 'Search',
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 15.0, vertical: 15),
                                  decoration: CustomDecorations()
                                      .baseBackgroundDecoration(
                                      10.0, 1.0,  Color(0xffffffff),
                                      Colors.transparent),
                                  child: ListView.separated(
                                      separatorBuilder: (context, pos) => const Divider(
                                        color: Color(0xFFEFF0F6),
                                      ),
                                      itemCount: 15,
                                      padding: const EdgeInsets.only(top: 8),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            if(isSelect == 1) {
                                              // context.push('/viewUser');
                                            } else {
                                              // context.push('/viewCompany');
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 5,),
                                                SvgPicture.asset(isSelect == 1 ? 'assets/ManageUser.svg' : 'assets/Company.svg'),
                                                const SizedBox(width: 10,),
                                                CustomText(title: isSelect == 1 ? 'Users ${++index}' : 'Company ${++index}' , color: AppColors.textFieldLabelTextColor, fontWeight: FontWeight.w500, fontSize: 12),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 35,
                                  child: GestureDetector(
                                    onTap: () {
                                      if(isSelect == 1) {
                                        // context.push('/addUser');
                                      } else {

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
                                        child: CustomText(title: '${isSelect == 1 ? 'Add user' : 'Add company'}  +', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final bool isText;
  final ValueChanged<bool> onChanged;

  CustomSwitch({Key? key, required this.value, required this.isText, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Row(
            children: [
              widget.isText
              ? CustomText(title: !widget.value ? 'Deactivate' : 'Activate', color: Color(0xFF8B8B94), fontWeight: FontWeight.w500, fontSize: 10)
              : Container(),
              widget.isText
                  ? SizedBox(width: 5,)
                  : SizedBox(width: 0,),
              Container(
                width: 36.0,
                height: 20.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: _circleAnimation!.value == Alignment.centerLeft
                      ? Color(0xFF00E041)
                      : Color(0xFFAEAEB2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    alignment:
                    widget.value ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft ) : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight),
                    child: Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}