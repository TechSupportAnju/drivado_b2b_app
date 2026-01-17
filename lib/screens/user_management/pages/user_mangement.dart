import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_company.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/view_user.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/animated_toggle.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_add_button_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_list_tile_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_company.dart';
import 'add_user.dart';

class UserMangementPage extends StatefulWidget {
  const UserMangementPage({super.key});

  @override
  State<UserMangementPage> createState() => _UserMangementPageState();
}
List<String> allItems = ['Sayan', 'Sumit', 'Anju', 'Shakshi', 'Hrusikesh', 'Tapas Daa', 'Abhishek' 'Rahul', 'Debodatta', 'Nilanjan', 'Devansh', 'Tripty', 'Debjyoti'];

class _UserMangementPageState extends State<UserMangementPage> {
  int toggleValue = 0;
  TextEditingController search = TextEditingController();
  List<String> filteredItems = [];

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
      backgroundColor: Color(0xffF5F6FA),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            decoration: const BoxDecoration(
                color: Color(0xff190C0C),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/user_management/userPic.svg',),
                        const SizedBox(width: 16,),
                        Column(
                          children: [
                           SizedBox(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: const CustomText(title: 'Hello Sumit', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                            const SizedBox(height: 3,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/2,
                                child: const CustomText(title: 'test@drivado.com', color: Color(0xFFAEB1C1), fontWeight: FontWeight.w500, fontSize: 14)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Color(0XFF352828),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/home/notification_icon.svg',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      height: 52,
                      width: screenWidth,
                      decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Colors.transparent),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                if(toggleValue == 0) {
                                  _filterList(value);
                                } else {

                                }
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 11.5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AnimatedToggleManagement(
              values: const ['Users', 'Companies'],
              onToggleCallback: (value) {
                setState(() {
                  toggleValue = value;
                  search.clear();
                  filteredItems = allItems;
                });
              },
            ),
          ),
          const SizedBox(height: 11.5,),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  ListView.separated(
                      separatorBuilder: (context, pos) => const Divider(
                        color: Color(0xFFEFF0F6),
                      ),
                      itemCount: filteredItems.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 45),
                      itemBuilder: (context, index) {
                        return userCompanyListTileWidget(context, toggleValue == 0 ? filteredItems[index] : 'Company ${++index}', toggleValue);
                      }
                  ),
                  Positioned(
                    right: 10,
                    bottom: 120,
                    child: userCompanyAddButtonWidget(context, toggleValue),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
