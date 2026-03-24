import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/appbar_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_state.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  void _tryLoadMore(BuildContext context) {
    final bloc = context.read<BookingListBloc>();
    final s = bloc.state;
    if (s is! BookingListLoaded) return;
    if (!s.canLoadMore || s.isLoadingMore) return;
    final u = context.read<UserInformationBloc>().state;
    if (u is UserInformationLoaded) {
      bloc.add(BookingListLoadMoreRequested(userData: u.userData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: CommonAppBar(
          bottomHeight: 120,
          bottomWidget: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SearchBarWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchFilterPage(),
                          ),
                        );
                      },
                      child: const FilterBooking(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CustomText(
                          title: 'All Booking',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        const SizedBox(width: 10),
                        BlocBuilder<BookingListBloc, BookingListState>(
                          buildWhen: (p, c) =>
                              c is BookingListLoaded ||
                              c is BookingListLoading ||
                              c is BookingListInitial,
                          builder: (context, state) {
                            final String label;
                            if (state is BookingListLoaded) {
                              label = '${state.totalCount}';
                            } else if (state is BookingListLoading) {
                              label = '…';
                            } else {
                              label = '0';
                            }
                            return Container(
                              height: 20,
                              constraints: const BoxConstraints(minWidth: 38),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF352828),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Center(
                                child: CustomText(
                                  title: label,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const CustomText(
                          title: 'Download report',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: const Color(0xFF352828),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              'assets/booking/download_icon.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        body: BlocBuilder<BookingListBloc, BookingListState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state is BookingListFailure)
                  Material(
                    color: const Color(0xFFFFF3CD),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              title: state.message,
                              color: const Color(0xFF856404),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              maxLine: 3,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final u =
                                  context.read<UserInformationBloc>().state;
                              if (u is UserInformationLoaded) {
                                context.read<BookingListBloc>().add(
                                      BookingListRefreshRequested(
                                        userData: u.userData,
                                      ),
                                    );
                              }
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state is BookingListMissingUserContext)
                  Material(
                    color: const Color(0xFFF8D7DA),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: CustomText(
                        title: state.message,
                        color: const Color(0xFF721C24),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        maxLine: 4,
                      ),
                    ),
                  ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification n) {
                      final m = n.metrics;
                      if (!m.hasPixels || m.maxScrollExtent <= 0) {
                        return false;
                      }
                      if (n is ScrollUpdateNotification ||
                          n is OverscrollNotification) {
                        if (m.pixels >= m.maxScrollExtent - 320) {
                          _tryLoadMore(context);
                        }
                      }
                      return false;
                    },
                    child: BookingCardWidget(
                      bookings: state is BookingListLoaded
                          ? state.items
                          : const [],
                      isLoading: state is BookingListLoading ||
                          state is BookingListInitial,
                      isLoadingMore: state is BookingListLoaded &&
                          state.isLoadingMore,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}
