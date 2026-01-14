import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_switch.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/table_data_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewUserPage extends StatefulWidget {
  const ViewUserPage({super.key});

  @override
  State<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  bool status = true;
  TextEditingController search = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController discount = TextEditingController();

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
                              Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child:CustomText(textAlign: TextAlign.right,
                                      title: 'test@drivado.com', color: Color(0xFFAEB1C1), fontWeight: FontWeight.w500, fontSize: 14)),
                            ],
                          ),
                          SizedBox(width: 16,),
                          SvgPicture.asset('assets/user_management/userPic.svg', height: 40,),
                        ]
                    )
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Color(0xffffffff), Color(0xFFE6E8E7)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const CustomText(title: 'User Details', color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16),
                                  Spacer(),
                                  CustomSwitch(
                                    value: status,
                                    onChanged: (value) {
                                      setState(() {
                                        status = value;
                                      });
                                    }, isText: true,
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
                                        image: AssetImage('assets/user_management/userPic.png'),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Color(0xFF0D0D0D), width: 1),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          title: 'Sumit Modi',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF0D0D0D),
                                          fontSize: 16
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          CustomText(
                                              title: 'User',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF434557),
                                              fontSize: 12
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              SizedBox(
                                width: screenWidth,
                                child: Row(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerTheme: const DividerThemeData(
                                          thickness: 0,
                                          space: 0,
                                        ),
                                        dataTableTheme: const DataTableThemeData(
                                          dividerThickness: 0,
                                        ),
                                      ),
                                      child: DataTable(
                                        horizontalMargin: 0.0,
                                        dividerThickness: 0.0,
                                        headingRowHeight: 25,
                                        dataRowMinHeight: 25,
                                        dataRowMaxHeight: 25,
                                        columnSpacing: 5,
                                        border: TableBorder.all(color: Colors.transparent),
                                        columns: [
                                          DataColumn(label:
                                          CustomDataTableRow(
                                            title: 'Email ID',
                                            color: Color(0xFF606060),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            image: 'assets/user_management/email.svg',)
                                          ),
                                          DataColumn(label:
                                          SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 20,),
                                                  CustomText(
                                                      title: 'tech@drivado.com',
                                                      color: Color(0xFF0D0D0D),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12),
                                                ],
                                              ))
                                          ),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(
                                                CustomDataTableRow(
                                                  title: 'Mob. number',
                                                  color: Color(0xFF606060),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  image: 'assets/user_management/phone.svg',)
                                            ),
                                            DataCell(
                                                SizedBox(
                                                    width: screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        CustomText(
                                                            title: '+91 9876543210',
                                                            color: Color(0xFF0D0D0D),
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12),
                                                      ],
                                                    ))
                                            ),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(
                                                CustomDataTableRow(
                                                  title: 'Language',
                                                  color: Color(0xFF606060),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  image: 'assets/user_management/langAccount.svg',)),
                                            DataCell(
                                                SizedBox(
                                                    width: screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        CustomText(
                                                            title: 'English',
                                                            color: Color(0xFF0D0D0D),
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 12),
                                                      ],
                                                    ))
                                            ),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(
                                                CustomDataTableRow(
                                                  title: 'Currency',
                                                  color: Color(0xFF606060),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  image: 'assets/user_management/currAccount.svg',)),
                                            DataCell(
                                                Container(
                                                    width: screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(width: 20,),
                                                        CustomText(
                                                            title: 'USD',
                                                            color: Color(0xFF0D0D0D),
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 12),
                                                      ],
                                                    ))
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          decoration: CustomDecorations()
                              .baseBackgroundDecoration(
                              12.0, 1.0, Color(0xffffffff),Color(0xFFE6E8E7)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                      title: 'Credit Limit',
                                      color: Color(0xFF0D0D0D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  CustomText(title: 'Total unpaid booking',
                                      color: Color(0xFF606060),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                  Spacer(),
                                  CustomText(title: 'USD 462',
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  CustomText(title: 'Available credit limit',
                                      color: Color(0xFF606060),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                  Spacer(),
                                  CustomText(title: 'USD 462434',
                                      color: Color(0xFF0D0D0D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
