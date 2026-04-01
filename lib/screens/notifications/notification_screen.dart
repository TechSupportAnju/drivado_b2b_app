import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppNotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeLabel;

  const AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const Color _pageBg = Color(0xFFF5F6FA);
  static const Color _headerBg = Color(0xFF190C0C);
  final List<AppNotificationItem> _items = [
    const AppNotificationItem(
      id: '1',
      title: 'Booking Confirmation',
      message:
          'Your chauffeur is confirmed! Get ready for a smooth and comfortable ride with Drivado. Sit back and relax—we’ll handle the journey.',
      timeLabel: '1 min ago',
    ),
    const AppNotificationItem(
      id: '1',
      title: 'Booking Confirmation',
      message:
          'Your chauffeur is confirmed! Get ready for a smooth and comfortable ride with Drivado. Sit back and relax—we’ll handle the journey.',
      timeLabel: '1 min ago',
    ),
  ];

  void _markAllRead() {
    // Hook for API / local read state when backend is ready.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _headerBg,
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Color(0xff190C0C),
        centerTitle: true,
        leading:GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset('assets/user_management/back.svg'),
            )),
        title:  const CustomText(title: 'Notifications', color: Color(0xffffffff), fontWeight: FontWeight.w500, fontSize: 20),
      ),
      body: Container(
        // color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = _items[index];
            return _FigmaNotificationCard(
              title: item.title,
              message: item.message,
              timeLabel: item.timeLabel,
            );
          },
        ),
      ),
    );
  }
}

class _FigmaNotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String timeLabel;

  const _FigmaNotificationCard({
    required this.title,
    required this.message,
    required this.timeLabel,
  });

  static const Color _bulletColor = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Colors.white),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 6),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: _bulletColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomText(title: title, height: 1.3, fontSize: 14, fontWeight: FontWeight.w500, color: _bulletColor,),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomText(title: message, height: 1.4 ,fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF606060),),
                  ],
                ),
              ),
              SvgPicture.asset('assets/more-circle.svg')
            ],
          ),
          const SizedBox(height: 8),
          CustomText(title: timeLabel,height: 1.3, fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF606060),),
        ],
      ),
    );
  }
}
