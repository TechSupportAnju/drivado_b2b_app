import 'dart:io';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_card_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/search_bar_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_header_widget_test.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_csv_notification_service.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_query_params.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_repository.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  bool _exportingCsv = false;

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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
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
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFilterPage()));
                            },
                            child: Container(
                              height: 48,
                              width: screenWidth/1.35,
                              decoration: CustomDecorations().baseBackgroundDecoration(
                                10.0,
                                1.0,
                                Colors.white,
                                Colors.transparent,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                               SvgPicture.asset(
                                    'assets/user_management/search.svg',
                                    height: 18,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFF606060),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      // controller: search,
                                      textAlignVertical: TextAlignVertical.center,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0xFF0D0D0D),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF606060),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'Search & Filter',
                                      ),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFilterPage()));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                            final filtered =
                                state is BookingListLoaded &&
                                    state.activeSearch != null;
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
                                if (filtered) ...[
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      final u =
                                          context.read<UserInformationBloc>().state;
                                      if (u is UserInformationLoaded) {
                                        context.read<BookingListBloc>().add(
                                          BookingListFetchRequested(
                                            userData: u.userData,
                                          ),
                                        );
                                      }
                                    },
                                    child: const CustomText(
                                      title: 'Clear filters',
                                      color: Color(0xFFFB4156),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                        InkWell(
                          onTap: _exportingCsv ? null : _downloadCsvReport,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: Row(
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
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF352828),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:
                                  _exportingCsv
                                      ? const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      'assets/booking/download_icon.svg',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
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
