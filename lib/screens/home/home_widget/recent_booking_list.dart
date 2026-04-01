import 'package:drivado_b2b_app/models/booking_list_item.dart';
import 'package:drivado_b2b_app/screens/bookings/booking_detail_page.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_event.dart';
import 'package:drivado_b2b_app/services/bookings/booking_detail_repository.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/status_widget.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

Color _bookingStatusColor(String status) {
  final s = status.toLowerCase();
  if (s.contains('confirm')) return const Color(0xFF28A745);
  if (s.contains('cancel')) return const Color(0xFFDC3545);
  if (s.contains('pending') || s.contains('assign')) {
    return const Color(0xFFFFC107);
  }
  return const Color(0xFF606060);
}

class RecentBookingList extends StatelessWidget {
  static const int kMaxItems = 10;

  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const RecentBookingList({
    super.key,
    this.padding,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListBloc, BookingListState>(
      builder: (context, state) {
        if (state is BookingListLoading || state is BookingListInitial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
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

        if (state is BookingListFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomText(
              title: state.message,
              color: const Color(0xFF606060),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          );
        }

        if (state is BookingListMissingUserContext) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomText(
              title: state.message,
              color: const Color(0xFF606060),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          );
        }

        if (state is! BookingListLoaded) {
          return const SizedBox.shrink();
        }

        final recent = state.items.length > kMaxItems
            ? state.items.sublist(0, kMaxItems)
            : state.items;

        if (recent.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CustomText(
              title: 'No recent bookings',
              color: Color(0xFF606060),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding ?? EdgeInsets.zero,
          itemCount: recent.length,
          itemBuilder: (context, index) {
            final item = recent[index];
            return _RecentBookingRow(item: item);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        );
      },
    );
  }
}

class _RecentBookingRow extends StatelessWidget {
  final BookingListItem item;

  const _RecentBookingRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final statusColor = _bookingStatusColor(item.status);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          final id = item.bookingRef.trim();
          if (id.isEmpty || id == '—') return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => BookingDetailBloc(
                  repository: BookingDetailRepository(),
                )..add(BookingDetailLoadRequested(bookingId: id)),
                child: BookingDetailPage(bookingId: id),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: CustomDecorationsCards().baseBackgroundShadow(
            radius: 8,
            smooth: 1,
            color: Colors.white,
            width: 0.50,
            borderColor: const Color(0xFFE6E8E7),
            blurRadius: 10,
            boxShadowColor: Colors.transparent,
            x: 0,
            y: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: CustomDecorations().baseBackgroundDecoration(
                        8.0,
                        1.0,
                        const Color(0x0CFB4156),
                        Colors.transparent,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/home/calendar_icon.svg',
                          color: const Color(0xFFFB4156),
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: item.bookingRef,
                            color: const Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            height: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/home/calendar_icon.svg',
                                color: const Color(0xFF606060),
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: CustomText(
                                  title: item.dateLabel,
                                  color: const Color(0xFF606060),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusWidget(
                    text: item.status,
                    backgroundColor: statusColor.withOpacity(0.1),
                    textColor: statusColor,
                    borderColor: statusColor.withOpacity(0.5),
                    borderWidth: 0.5,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/home/arrow_icon.svg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
