import 'package:drivado_b2b_app/models/booking_list_item.dart';
import 'package:drivado_b2b_app/screens/bookings/booking_detail_page.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_event.dart';
import 'package:drivado_b2b_app/services/bookings/booking_detail_repository.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_type_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';

class BookingCardWidget extends StatelessWidget {
  final List<BookingListItem> bookings;
  final bool isLoading;
  final bool isLoadingMore;

  const BookingCardWidget({
    super.key,
    this.bookings = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
  });

  static Color _statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('confirm')) return const Color(0xFF28A745);
    if (s.contains('cancel')) return const Color(0xFFDC3545);
    if (s.contains('pending') || s.contains('assign'))
      return const Color(0xFFFFC107);
    return const Color(0xFF606060);
  }

  static void _openBookingDetail(BuildContext context, BookingListItem item) {
    final id = item.bookingRef.trim();
    if (id.isEmpty || id == '—') return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create:
                  (_) =>
                      BookingDetailBloc(repository: BookingDetailRepository())
                        ..add(BookingDetailLoadRequested(bookingId: id)),
              child: BookingDetailPage(bookingId: id),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontScale = screenWidth / 375;

    if (isLoading && bookings.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFB4156)),
      );
    }

    if (bookings.isEmpty) {
      return const Center(
        child: CustomText(
          title: 'No bookings found',
          color: Color(0xFF606060),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      );
    }

    final bottomInset =
        MediaQuery.paddingOf(context).bottom + kBottomNavigationBarHeight + 56;

    final tail = isLoadingMore ? 1 : 0;
    return ListView.separated(
      itemCount: bookings.length + tail,
      padding: EdgeInsets.only(top: 16, bottom: bottomInset),
      itemBuilder: (context, index) {
        if (index >= bookings.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Color(0xFFFB4156),
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        }
        final item = bookings[index];
        final statusColor = _statusColor(item.status);

        return Padding(
          padding: const EdgeInsets.only(left: 19, right: 19),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openBookingDetail(context, item),
            child: Container(
              width: screenWidth - 38,
              decoration: CustomDecorationsCards().baseBackgroundShadow(
                radius: 12,
                smooth: 1,
                color: const Color(0xFFFFFFFF),
                blurRadius: 4,
                x: 0,
                y: 0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/booking/pax_icon.svg'),
                              const SizedBox(width: 6),
                              Expanded(
                                child: CustomText(
                                  title: item.paxName,
                                  color: const Color(0xFF0D0D0D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StatusWidget(
                          text: item.status,
                          textColor: statusColor,
                          borderColor: statusColor.withOpacity(0.5),
                          borderWidth: 0.5,
                          backgroundColor: statusColor.withOpacity(0.1),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: const DottedLine(
                      direction: Axis.horizontal,
                      lineThickness: 1.0,
                      dashColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: item.bookingRef,
                              color: const Color(0xFFFB4156),
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              height: 1,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              title: item.dateLabel,
                              color: const Color(0xFFFB4156),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              height: 1,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              title: item.timeLabel,
                              color: const Color(0xFF606060),
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.6,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/booking/source_icon.svg',
                                  ),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: Transform.translate(
                                      offset: const Offset(0, 4),
                                      child: CustomText(
                                        title: item.pickup,
                                        color: const Color(0xFF606060),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10 * fontScale,
                                        height: 1.4,
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5 * fontScale),
                              child: DottedLine(
                                direction: Axis.vertical,
                                lineLength: 25 * fontScale,
                                lineThickness: 1 * fontScale,
                                dashLength: 3.0 * fontScale,
                                dashColor: const Color(0xFF585858),
                                dashRadius: 0.0,
                                dashGapLength: 2.0 * fontScale,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.6,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/booking/destination_icon.svg',
                                  ),
                                  const SizedBox(width: 9),
                                  Expanded(
                                    child: CustomText(
                                      title: item.dropoff,
                                      color: const Color(0xFF606060),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      height: 1.4,
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BookingTypeWidget(
                                    bookingType: item.bookingType,
                                    textColor: const Color(0xFFFB4156),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1,
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    // constraints: const BoxConstraints(maxWidth: 140),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F6FA),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        title: item.durationLabel,
                                        color: const Color(0xFFFB4156),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        height: 1,
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        child: SvgPicture.asset('assets/booking/card.svg'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/booking/driver_icon.svg',
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: CustomText(
                                    title: item.driverName,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1,
                                    maxLine: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/booking/driver_contact_icon.svg',
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: CustomText(
                                    title: item.driverPhone,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1,
                                    maxLine: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: CustomText(
                            textAlign: TextAlign.center,
                            title: item.vehicleLabel,
                            color: const Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w700,
                            fontSize: 12 * fontScale,
                            height: 1,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                       height: 25, width: 1, color: Colors.black,
                      ),

                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: CustomText(
                            textAlign: TextAlign.center,
                            title: item.priceLabel,
                            color: const Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w700,
                            fontSize: 12 * fontScale,
                            height: 1,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,)
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
