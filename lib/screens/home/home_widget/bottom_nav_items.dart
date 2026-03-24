import 'dart:async';
import 'dart:developer';

import 'package:drivado_b2b_app/screens/bookings/booking_list_page.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/screens/home/home_screens/home_page.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_navigation_bar.dart';
import 'package:drivado_b2b_app/screens/more/more.dart';
import 'package:drivado_b2b_app/screens/user_management/pages/user_mangement.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    UserMangementPage(),
    MorePage(),
    CreateBookingPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.bottomBarIndex != null) {
      bottomBarIndex = widget.bottomBarIndex!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProfileThenRequestBookings());
  }

  /// Loads user profile, then dispatches [BookingListFetchRequested] once it is ready.
  /// Uses [UserInformationBloc.stream] after [add] so we never miss [UserInformationLoaded].
  Future<void> _loadProfileThenRequestBookings() async {
    if (!mounted) return;
    final userBloc = context.read<UserInformationBloc>();
    final bookingBloc = context.read<BookingListBloc>();

    final accessToken = await AuthService.getAccessToken();
    if (!mounted || accessToken == null || accessToken.isEmpty) {
      log('RootShell: no access token — bookings not requested');
      return;
    }

    userBloc.add(UserInformationLoadDetails(accessToken: accessToken));
    log('RootShell: UserInformationLoadDetails dispatched');

    try {
      final terminal = await userBloc.stream
          .where(
            (s) => s is UserInformationLoaded || s is UserInformationError,
          )
          .first
          .timeout(const Duration(seconds: 90));
      if (!mounted) return;
      if (terminal is UserInformationLoaded) {
        log('RootShell: profile ready → BookingListFetchRequested');
        bookingBloc.add(
          BookingListFetchRequested(userData: terminal.userData),
        );
      } else if (terminal is UserInformationError) {
        log('RootShell: profile failed — ${terminal.message}');
      }
    } on TimeoutException {
      log('RootShell: timeout waiting for user profile (90s)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body:  bottomBarIndex == 4
          ? CreateBookingPage()
          : IndexedStack(
        index: bottomBarIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          setState(() {
            bottomBarIndex = 4;
          });
        },
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
      bottomNavigationBar:
      CustomBottomNav(
        activeIndex: bottomBarIndex > 3 ? -1 : bottomBarIndex,
        onTap: (index) {
          setState(() {
            bottomBarIndex = index;
          });
        },
      ),
    );
  }
}
