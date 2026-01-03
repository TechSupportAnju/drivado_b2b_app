import 'package:drivado_b2b_app/screens/bookings/booking_list_page.dart';
import 'package:drivado_b2b_app/screens/home/home_screens/home_page.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_navigation_bar.dart';
import 'package:drivado_b2b_app/screens/manage/manage.dart';
import 'package:drivado_b2b_app/screens/more/more.dart';
import 'package:flutter/material.dart';

class RootShell extends StatefulWidget {
  final int? bottomBarIndex;

  const RootShell({super.key, this.bottomBarIndex});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int bottomBarIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    BookingListPage(),
    Manage(),
    More(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.bottomBarIndex != null) {
      bottomBarIndex = widget.bottomBarIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: IndexedStack(
        index: bottomBarIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {},
        child: Container(
          height: 58,
          width: 58,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFFFB4156),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 23,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNav(
        activeIndex: bottomBarIndex,
        onTap: (index) {
          setState(() {
            bottomBarIndex = index;
          });
        },
      ),
    );
  }
}
