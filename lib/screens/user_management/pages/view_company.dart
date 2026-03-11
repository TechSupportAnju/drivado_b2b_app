import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/user_mangement.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/credit_limit_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_booking_summary_row.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_switch.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_add_button_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_list_tile_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/view_company_side_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCompanyPage extends StatefulWidget {
  const ViewCompanyPage({super.key});

  @override
  State<ViewCompanyPage> createState() => _ViewCompanyPageState();
}

class _ViewCompanyPageState extends State<ViewCompanyPage> {
  bool status = true;
  int isSelect = 0;
  List<String> filteredItems = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    filteredItems = allItems;
  }

  void _filterList(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                bottom: false,
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
                              child: SvgPicture.asset('assets/user_management/back.svg')),
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
                          Image.asset('assets/user_management/userPic.png', height: 40,),
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
                            CustomViewCompanyWidget(title: 'Profile', icon: 'assets/user_management/profileUnsel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 0;
                                });
                            }, isSelect: isSelect, index: 0,),
                            SizedBox(height: 25,),
                            CustomViewCompanyWidget(title: 'Users', icon: 'assets/user_management/userSel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 1;
                                });
                            }, isSelect: isSelect, index: 1,),
                            SizedBox(height: 25,),
                            CustomViewCompanyWidget(title: 'Companies', icon: 'assets/user_management/companyUnsel.svg',
                                onPress: () {
                                setState(() {
                                  isSelect = 2;
                                });
                            }, isSelect: isSelect, index: 2,),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 6,),
                    SizedBox(
                      width: screenSize.width - 67,
                      height: screenSize.height,
                      child: isSelect == 0
                      ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              decoration: CustomDecorations()
                                  .draggableSheetDecoration(
                                  12.0,0.0, 12.0, 0.0, 1.0,  Color(0xffffffff),
                                  Color(0xFFE6E8E7)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(title: 'Company Details', color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16),
                                      Spacer(),
                                      CustomSwitch(
                                        isText: true,
                                        value: status,
                                        onChanged: (value) {
                                          setState(() {
                                            status = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage('assets/logo.png'),
                                            fit: BoxFit.contain
                                          ),
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Color(0xFFE6E8E7), width: 1),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              title: 'Drivado transfers pvt ltd.',
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF0D0D0D),
                                              fontSize: 16),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              CustomText(
                                                  title: 'help@drivado.com',
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF606060),
                                                  fontSize: 12),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Column(
                                    children: [
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Website',
                                        desc: 'www.drivado.com',
                                        image: 'assets/user_management/website.svg',
                                      ),
                                      SizedBox(height:12),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Mob. number',
                                        desc: '+91 9876543210',
                                        image: 'assets/user_management/phone.svg',
                                      ),
                                      SizedBox(height:12),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'GST/VAT',
                                        desc: 'UNDEFINED',
                                        image: 'assets/user_management/gst.svg',
                                      ),
                                      SizedBox(height:12),
                                      CustomBookingSummaryDataRowWithIcon(
                                        title: 'Address',
                                        desc: 'Mezzanine Floor, The Travel Centre, Sheikh Zayed Road, PO Box 75142, Dubai, UAE',
                                        image: 'assets/user_management/address.svg',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                            CreditLimitWidget(title1: 'Total unpaid booking', title2: 'Available credit limit', value1: 'USD 462', value2: 'USD 462434'),
                            SizedBox(height: 10,),
                          ],
                        )
                      )
                      : Column(
                        children: [
                          Container(
                            decoration: CustomDecorations().draggableSheetDecoration(10.0, 0.0, 10.0, 0.0, 1.0,  Colors.white, Color(0xFFEDF1F3)),
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage('assets/user_management/userPic.png'),
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
                                        CustomText(
                                            title: 'Drivado transfers pvt ltd.',
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0D0D0D),
                                            fontSize: 16),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            CustomText(
                                                title: 'help@drivado.com',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF3A434C),
                                                fontSize: 12),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  height: 52,
                                  width: screenWidth ,
                                  decoration: CustomDecorations().draggableSheetDecoration(10.0, 0.0, 10.0, 0.0, 1.0,  Color(0xFFF5F6FA), Color(0xFFF5F6FA)),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      search.text.isEmpty ? SvgPicture.asset('assets/user_management/search.svg', height: 18,
                                          colorFilter: const ColorFilter.mode(
                                              Color(0xFF606060), BlendMode.srcIn)
                                      ) : Container(),
                                      SizedBox(width: search.text.isEmpty ? 10 : 0,),
                                      Expanded(
                                        child: TextField(
                                            controller: search,
                                            textAlignVertical: TextAlignVertical.center,
                                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF0D0D0D)),
                                            decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintStyle: GoogleFonts.plusJakartaSans(
                                                    color: Color(0xFF606060),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                                hintText: 'Search',
                                                suffixIconConstraints: const BoxConstraints(),
                                                suffixIcon: search.text.isNotEmpty ? GestureDetector(
                                                    behavior: HitTestBehavior.translucent,
                                                    onTap: () {
                                                      setState(() {
                                                        search.clear();
                                                      });
                                                    },
                                                    child: Icon(Icons.clear, color: Color(0xFF0D0D0D), size: 20,)) : null
                                            ),
                                            onChanged: (value) {
                                              if(isSelect == 1) {
                                                _filterList(value);
                                              } else {

                                              }
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: CustomDecorations().draggableSheetDecoration(10.0, 0.0, 10.0, 0.0, 1.0,  Colors.white, Color(0xFFEDF1F3)),
                                  child: ListView.separated(
                                      separatorBuilder: (context, pos) => const Divider(
                                        color: Color(0xFFEFF0F6),
                                      ),
                                      itemCount: filteredItems.length,
                                      padding: const EdgeInsets.only(top: 0),
                                      itemBuilder: (context, index) {
                                        return userCompanyListTileWidget(context,
                                            isSelect == 1 ? filteredItems[index] : 'Company ${++index}',
                                            isSelect);
                                      }
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 65,
                                  child: userCompanyAddButtonWidget(context, isSelect)
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

