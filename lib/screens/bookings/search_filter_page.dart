import 'package:drivado_b2b_app/screens/bookings/bookings_widget/property_filter_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
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
      appBar: AppBar(
        backgroundColor: Color(0XFF190C0C),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset("assets/booking_detail/back_icon.svg"),
          ),
        ),
        title: CustomText(title: "Property Filter", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 20, height: 2.4),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomText(title: "Reset all", color: Color(0XFFFB4156), fontWeight: FontWeight.w500, fontSize: 14, height: 2.0),
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
                  unselectedLabelColor: Colors.black,
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
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PropertyFilterWidget(),
                    Center(
                      child: CustomText(
                        title: 'Travel Date',
                        color: Color(0XFF606060),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}