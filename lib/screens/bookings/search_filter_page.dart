import 'dart:developer';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/property_filter_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/constant/constant.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({super.key});
  @override
  State<SearchFilterPage> createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0XFF190C0C),
        leadingWidth: 60,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset("assets/booking_detail/back_icon.svg"),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CustomText(title: "Property Filter", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 20, height: 2.4),
        ),
        toolbarHeight: 75,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              fromDateController.clear();
              toDateController.clear();
              bookingIdController.clear();
              companyNameController.clear();
              usernameController.clear();
              isConfirmedSelected = false;
              isCompletedSelected = false;
              isCancelledSelected = false;
              isNoShowSelected = false;
              isOnRequestSelected = false;
              isPobSelected = false;
              log("pressed");
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset("assets/booking_detail/reset_icon.svg")
              //CustomText(title: "Reset all", color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 14, height: 2.0),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title: "Date range", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16, height: 1.4),
              SizedBox(height: 16),
              Container(
                decoration: CustomDecorations().baseBackgroundDecoration(55.0, 1.0, Colors.white, Colors.transparent),
                child: TabBar(
                  
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      45.0,
                    ),
                    color: Color(0XFFFB4156)
                  ),
                  
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF606060),
                  tabs: [
                    Tab(
                      text: 'Booking Date',
                    ),
                    Tab(
                      text: 'Travel Date',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SizedBox(
                 height: 38,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      PropertyFilterWidget(),
                      PropertyFilterWidget()
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      //  bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: CustomButtons(
      //       isIcon: false,
      //       title: 'Search',
      //       color: Colors.white,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 16,
      //       onTap: () {
      //         FocusScope.of(context).unfocus(); 
      //         // Navigator.pushAndRemoveUntil(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => RootShell(bottomBarIndex: 1)),
      //         // );
      //         Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => RootShell(bottomBarIndex: 1)),
      //         (Route<dynamic> route) => false,
      //       );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}