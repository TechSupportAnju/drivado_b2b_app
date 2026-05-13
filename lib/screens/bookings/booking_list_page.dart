import 'dart:io';
import 'package:drivado_b2b_app/models/booking_search_filter_payload.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_header_widget_test.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/constant/constant.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_csv_notification_service.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_query_params.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_repository.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  bool _exportingCsv = false;

  List<_FilterChipData> _activeFilterChips(BookingSearchFilterPayload filter) {
    final chips = <_FilterChipData>[];
    void addChip(_FilterChipType type, String? value) {
      final v = value?.trim();
      if (v == null || v.isEmpty) return;
      chips.add(_FilterChipData(type: type, label: v));
    }

    final dateFrom = filter.dateFrom?.trim();
    final dateTo = filter.dateTo?.trim();
    if ((dateFrom?.isNotEmpty ?? false) || (dateTo?.isNotEmpty ?? false)) {
      final from = (dateFrom?.isNotEmpty ?? false) ? dateFrom! : '-';
      final to = (dateTo?.isNotEmpty ?? false) ? dateTo! : '-';
      chips.add(
        _FilterChipData(
          type: _FilterChipType.dateRange,
          label: '$from to $to',
        ),
      );
    }

    addChip(_FilterChipType.bookingId, filter.bookingId);
    addChip(_FilterChipType.companyName, filter.companyName);
    addChip(_FilterChipType.userNameQuery, filter.userNameQuery);
    addChip(_FilterChipType.customerName, filter.customerName);
    addChip(_FilterChipType.passengerNumber, filter.passengerNumber);
    addChip(_FilterChipType.driverName, filter.driverName);
    addChip(_FilterChipType.driverNumber, filter.driverNumber);
    addChip(_FilterChipType.quoteBy, filter.quoteBy);
    for (final status in filter.bookingStatuses) {
      chips.add(
        _FilterChipData(
          type: _FilterChipType.bookingStatus,
          label: status,
          statusValue: status,
        ),
      );
    }
    return chips;
  }

  int _activeFilterCount(BookingSearchFilterPayload filter) {
    int count = 0;
    bool hasText(String? value) => value != null && value.trim().isNotEmpty;
    if (hasText(filter.dateFrom) || hasText(filter.dateTo)) count++;
    if (hasText(filter.bookingId)) count++;
    if (hasText(filter.companyName)) count++;
    if (hasText(filter.userNameQuery)) count++;
    if (hasText(filter.customerName)) count++;
    if (hasText(filter.passengerNumber)) count++;
    if (hasText(filter.driverName)) count++;
    if (hasText(filter.driverNumber)) count++;
    if (hasText(filter.quoteBy)) count++;
    count += filter.bookingStatuses.length;
    return count;
  }

  void _removeSelectedFilterChip(
    BuildContext context, {
    required BookingSearchFilterPayload currentFilter,
    required _FilterChipData chip,
  }) {
    final u = context.read<UserInformationBloc>().state;
    if (u is! UserInformationLoaded) return;

    BookingSearchFilterPayload nextFilter = currentFilter;
    switch (chip.type) {
      case _FilterChipType.dateRange:
        fromDateController.clear();
        toDateController.clear();
        nextFilter = currentFilter.copyWith(
          clearDateFrom: true,
          clearDateTo: true,
        );
        break;
      case _FilterChipType.bookingId:
        bookingIdController.clear();
        nextFilter = currentFilter.copyWith(clearBookingId: true);
        break;
      case _FilterChipType.companyName:
        companyNameController.clear();
        nextFilter = currentFilter.copyWith(clearCompanyName: true);
        break;
      case _FilterChipType.userNameQuery:
        usernameController.clear();
        nextFilter = currentFilter.copyWith(clearUserNameQuery: true);
        break;
      case _FilterChipType.customerName:
        passengerNameController.clear();
        nextFilter = currentFilter.copyWith(clearCustomerName: true);
        break;
      case _FilterChipType.passengerNumber:
        passengerNumberController.clear();
        nextFilter = currentFilter.copyWith(clearPassengerNumber: true);
        break;
      case _FilterChipType.driverName:
        driverNameController.clear();
        nextFilter = currentFilter.copyWith(clearDriverName: true);
        break;
      case _FilterChipType.driverNumber:
        driverNumberController.clear();
        nextFilter = currentFilter.copyWith(clearDriverNumber: true);
        break;
      case _FilterChipType.quoteBy:
        quoteByController.clear();
        nextFilter = currentFilter.copyWith(clearQuoteBy: true);
        break;
      case _FilterChipType.bookingStatus:
        final removed = chip.statusValue;
        final updated = List<String>.from(currentFilter.bookingStatuses)
          ..removeWhere((e) => e == removed);
        isConfirmedSelected = updated.contains('CONFIRMED');
        isCompletedSelected = updated.contains('COMPLETED');
        isCancelledSelected = updated.contains('CANCELLED');
        isNoShowSelected = updated.contains('NO_SHOW');
        isOnRequestSelected = updated.contains('ON_REQUEST');
        isPobSelected = updated.contains('POB');
        nextFilter = currentFilter.copyWith(bookingStatuses: updated);
        break;
    }

    if (!nextFilter.hasAnyActiveFilters) {
      context.read<BookingListBloc>().add(
        BookingListFetchRequested(userData: u.userData),
      );
      return;
    }

    context.read<BookingListBloc>().add(
      BookingListSearchRequested(userData: u.userData, filter: nextFilter),
    );
  }

  Future<void> _downloadCsvReport() async {
    if (_exportingCsv) return;

    final messenger = ScaffoldMessenger.of(context);
    final u = context.read<UserInformationBloc>().state;
    if (u is! UserInformationLoaded) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Profile not loaded yet. Please wait and try again.'),
        ),
      );
      return;
    }

    final params = BookingListQueryParams.tryFromUserData(u.userData);
    if (params == null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Cannot export bookings. ${BookingListQueryParams.missingSummary(u.userData)}',
            maxLines: 6,
          ),
        ),
      );
      return;
    }

    setState(() => _exportingCsv = true);
    try {
      if (kIsWeb) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'CSV download is not available on web from this screen.',
            ),
          ),
        );
        return;
      }

      final repo = BookingListRepository();
      final bytes = await repo.downloadBookingCsvReport(params);
      final targetDir =
          await getDownloadsDirectory() ??
          await getApplicationDocumentsDirectory();
      final name =
          'drivado_bookings_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
      final file = File('${targetDir.path}/$name');
      await file.writeAsBytes(bytes);

      if (!mounted) return;

      await BookingCsvNotificationService.showCsvSaved(
        filePath: file.path,
        fileName: name,
      );

      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Report saved. Tap the notification to open the file.'),
          duration: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Could not download report: $e')),
      );
    } finally {
      if (mounted) setState(() => _exportingCsv = false);
    }
  }

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
      backgroundColor: Color(0xFFF5F6FA),
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: Column(
        children: [
          Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xff190C0C),
          ), child: Column(
                children: [
                  CommonHeaderTest(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child: GestureDetector(
                        //     behavior: HitTestBehavior.translucent,
                        //     onTap: () {
                        //       Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFilterPage()));
                        //     },
                        //     child: Container(
                        //       height: 48,
                        //       width: screenWidth/1.35,
                        //       decoration: CustomDecorations().baseBackgroundDecoration(
                        //         10.0,
                        //         1.0,
                        //         Colors.white,
                        //         Colors.transparent,
                        //       ),
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 16,
                        //         vertical: 10,
                        //       ),
                        //       child: Row(
                        //         children: [
                        //        SvgPicture.asset(
                        //             'assets/user_management/search.svg',
                        //             height: 18,
                        //             colorFilter: const ColorFilter.mode(
                        //               Color(0xFF606060),
                        //               BlendMode.srcIn,
                        //             ),
                        //           ),
                        //           SizedBox(width: 10),
                        //           Expanded(
                        //             child: TextField(
                        //               readOnly: true,
                        //               // controller: search,
                        //               textAlignVertical: TextAlignVertical.center,
                        //               style: GoogleFonts.plusJakartaSans(
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 16,
                        //                 color: const Color(0xFF0D0D0D),
                        //               ),
                        //               decoration: InputDecoration(
                        //                 contentPadding: EdgeInsets.zero,
                        //                 isDense: true,
                        //                 border: InputBorder.none,
                        //                 hintStyle: GoogleFonts.plusJakartaSans(
                        //                   color: const Color(0xFF606060),
                        //                   fontWeight: FontWeight.w400,
                        //                   fontSize: 16,
                        //                 ),
                        //                 hintText: 'Search & Filter',
                        //               ),
                        //               onTap: () {
                        //                 Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFilterPage()));
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        BlocBuilder<BookingListBloc, BookingListState>(
                          buildWhen:
                              (p, c) =>
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
                            return Row(
                              children: [
                                const CustomText(
                                  title: 'All Booking',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 20,
                                  constraints: const BoxConstraints(minWidth: 38),
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(width: 24,),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchFilterPage(),
                              ),
                            );
                          },
                          child: BlocBuilder<BookingListBloc, BookingListState>(
                            buildWhen: (p, c) => c is BookingListLoaded || c is BookingListInitial || c is BookingListLoading,
                            builder: (context, state) {
                              final activeFilterCount = state is BookingListLoaded &&
                                      state.activeSearch != null
                                  ? _activeFilterCount(state.activeSearch!)
                                  : 0;
                              return FilterBooking(
                                activeFilterCount: activeFilterCount,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: InkWell(
                      onTap: _exportingCsv ? null : _downloadCsvReport,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.secondary, AppColors.secondary),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _exportingCsv
                                ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                )
                                : SvgPicture.asset(
                                  'assets/booking/download_icon.svg',
                                ),
                            const SizedBox(width: 4),
                            const CustomText(
                              title: 'Download report',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
          ),
          BlocBuilder<BookingListBloc, BookingListState>(
            buildWhen: (p, c) => c is BookingListLoaded || c is BookingListLoading,
            builder: (context, state) {
              if (state is! BookingListLoaded || state.activeSearch == null) {
                return const SizedBox.shrink();
              }
              final chips = _activeFilterChips(state.activeSearch!);
              if (chips.isEmpty) return const SizedBox.shrink();
              return Container(
                width: double.infinity,
                color: const Color(0xFFF5F6FA),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: chips
                        .map(
                          (chip) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              height: 36,
                              child: InputChip(
                                label: Text(
                                  chip.label,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onDeleted: () => _removeSelectedFilterChip(
                                  context,
                                  currentFilter: state.activeSearch!,
                                  chip: chip,
                                ),
                                deleteIcon: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<BookingListBloc, BookingListState>(
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
                                  final u = context
                                      .read<UserInformationBloc>()
                                      .state;
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
          ),
        ],
      ),
    );
  }
}

enum _FilterChipType {
  dateRange,
  bookingId,
  companyName,
  userNameQuery,
  customerName,
  passengerNumber,
  driverName,
  driverNumber,
  quoteBy,
  bookingStatus,
}

class _FilterChipData {
  final _FilterChipType type;
  final String label;
  final String? statusValue;

  const _FilterChipData({
    required this.type,
    required this.label,
    this.statusValue,
  });
}
