import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonHeader extends StatelessWidget implements PreferredSizeWidget {
  const CommonHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(230);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF190C0C),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 31),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("assets/home/profile_icon.svg"),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: const [
                    CustomText(title: "Hello, Sumit", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14, maxLine: 1, 
                    overflow: TextOverflow.ellipsis, height: 1.4,),
                    CustomText(title: "test@drivado.com", color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, maxLine: 1,
                    overflow: TextOverflow.ellipsis, height: 1.4),
                  ],
                ),
              ),
              notificationWidget()
            ],
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchBarWidget(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchFilterPage(),
                    ),
                  );
                },
                child: FilterBooking(),
              )
            ],
          ),
        const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    title: "All Booking",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 38,
                    decoration: BoxDecoration(
                      color: const Color(0XFF352828),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Center(
                      child: CustomText(
                        title: "250",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    title: "Download report",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: const Color(0XFF352828),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/booking/download_icon.svg",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}