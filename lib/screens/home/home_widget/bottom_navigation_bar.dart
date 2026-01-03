import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  static const Color activeColor = Color(0XFFFB4156); 
  static const Color inactiveColor = Color(0XFF606060);

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 4,
      activeIndex: activeIndex,
      gapLocation: GapLocation.center,
      blurEffect: true,
      notchSmoothness: NotchSmoothness.softEdge,
    
      shadow: BoxShadow(
        color: Color(0XFF000000).withOpacity(0.25),
        blurRadius: 18,
        
      ),
      onTap: (index) => onTap(index),
      tabBuilder: (index, isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _icon(index, isActive),
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isActive ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
            CustomText(
              title: _label(index),
                fontSize: isActive? 10 : 10,
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive? FontWeight.w700 : FontWeight.w500,
                height: 2.0,
                letterSpacing: 0.1,
            ),
          ],
        );
      },
    );
  }

  String _icon(int index, bool isActive) {
    switch (index) {
      case 0:
        return isActive
            ? 'assets/home/home_active_icon.svg'
            : 'assets/home/home_inactive_icon.svg';
      case 1:
        return isActive
            ? 'assets/home/bookings_active_icon.svg'
            : 'assets/home/bookings_inactive_icon.svg';
      case 2:
        return isActive
            ? 'assets/home/manage_booking_active_icon.svg'
            : 'assets/home/manage_booking_active_icon.svg';
      case 3:
      default:
        return isActive
            ? 'assets/home/profile_active_icon.svg'
            : 'assets/home/profile_inactive_icon.svg';
    }
  }

  String _label(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Booking';
      case 2:
        return 'Manage';
      case 3:
      default:
        return 'More';
    }
  }
}
