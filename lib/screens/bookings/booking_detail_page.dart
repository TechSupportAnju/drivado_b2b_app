import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_cancel_card.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_id.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_type_widget.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/cancel_booking_dialog.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/cancellation_policy_widget.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/custom_booking_box.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/flight_detail_widget.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_state.dart';
import 'package:drivado_b2b_app/utils/booking_cancel_visibility.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailPage extends StatefulWidget {
  final String bookingId;

  const BookingDetailPage({super.key, required this.bookingId});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  /// Same email used at login (prefs); booking “Booked by” often aligns with this, not necessarily [UserData.email]).
  String? _sessionLoginEmail;

  @override
  void initState() {
    super.initState();
    AuthService.getEmail().then((e) {
      if (!mounted) return;
      final t = e?.trim();
      setState(() {
        _sessionLoginEmail = (t != null && t.isNotEmpty) ? t : null;
      });
    });
  }

  void _showBookingSummaryMoreSheet(BuildContext pageContext, BookingDetailData detail) {
    showModalBottomSheet<void>(
      context: pageContext,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isScrollControlled: true,
      builder: (sheetContext) {

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 24,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E8E7),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(sheetContext);
                    showCancelBookingDialog(pageContext, detail: detail);
                  },
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 12, 20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/booking_detail/cancel_icon.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: CustomText(
                            title: 'Cancel booking',
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xFF190C0C),
        leadingWidth: 60,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              'assets/booking_detail/back_icon.svg',
              height: 40,
              width: 40,
            ),
          ),
        ),
        title: const CustomText(
          title: 'Booking Summary',
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 1.2,
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<UserInformationBloc, UserInformationState>(
            builder: (context, userState) {
              return BlocBuilder<BookingDetailBloc, BookingDetailState>(
                buildWhen: (prev, next) =>
                    next is BookingDetailLoaded ||
                    next is BookingDetailLoading ||
                    next is BookingDetailFailure ||
                    next is BookingDetailInitial,
                builder: (context, bdState) {
                  if (bdState is! BookingDetailLoaded) {
                    return const SizedBox.shrink();
                  }
                  if (!canShowCancelBookingForDetail(
                        userState,
                        bdState.data,
                        prefsLoginEmail: _sessionLoginEmail,
                      )) {
                    return const SizedBox.shrink();
                  }
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      final st = context.read<BookingDetailBloc>().state;
                      if (st is! BookingDetailLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Booking details are still loading.'),
                          ),
                        );
                        return;
                      }
                      _showBookingSummaryMoreSheet(context, st.data);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF352828),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/booking_detail/dot_icon.svg',
                            height: 28,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<BookingDetailBloc, BookingDetailState>(
          builder: (context, state) {
            if (state is BookingDetailLoading || state is BookingDetailInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFB4156)),
              );
            }
            if (state is BookingDetailFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: state.message,
                        color: const Color(0xFF606060),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          context.read<BookingDetailBloc>().add(
                                BookingDetailLoadRequested(
                                  bookingId: widget.bookingId,
                                ),
                              );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is BookingDetailLoaded) {
              return _DetailScrollView(detail: state.data);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DetailScrollView extends StatelessWidget {
  final BookingDetailData detail;

  const _DetailScrollView({required this.detail});

  int _calculateNumberOfLines(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.computeLineMetrics().length;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lineStyle =
        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 10);
    final sourceLines =
        _calculateNumberOfLines(detail.sourcePlace, lineStyle, screenWidth * 0.7);
    final destLines =
        _calculateNumberOfLines(detail.destinationPlace, lineStyle, screenWidth * 0.7);
    final totalLength = sourceLines + destLines;
    final (dayPrefix, dateLine, timeLarge) = detail.travelHeaderLabels;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            if (!detail.isBookingStatusCancelled) ...[
              BookingIdWidget(
                bookingId: detail.bookingId,
                status: detail.bookingStatus,
                paymentStatus: detail.paymentStatus,
                detail: detail,
              ),
            ] else ...[
              BookingCancelledCard(
                cancellationFee: detail.cancellationFees,
              ) ],
         const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                decoration: CustomDecorations().baseBackgroundDecoration(
                  10.0,
                  1.0,
                  Colors.white,
                  const Color(0xFFE6E8E7),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      // height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    child: CustomText(
                                      title: dayPrefix,
                                      color: const Color(0xFF606060),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(
                                    child: CustomText(
                                      title: dateLine,
                                      color: const Color(0xFF606060),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(
                                    child: CustomText(
                                      title: timeLarge,
                                      color: const Color(0xFF606060),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 36,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (detail.canShowFlightStatus)
                            FlightDetailWidget(
                              flightNumber: detail.flightNumber!.trim(),
                              lookupDate: detail.effectiveFlightLookupDate!,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        CustomText(
                          title: 'Vehicle Type',
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.7,
                        ),
                        Spacer(),
                        CustomText(
                          title: 'Price',
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.7,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            title: detail.vehicleCategory.toUpperCase(),
                            color: const Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1,
                          ),
                        ),
                        CustomText(
                          title: detail.priceLabel,
                          color: const Color(0xFFFB4156),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/booking_detail/source_detail_icon.svg',
                                colorFilter: const ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(height: 1,),
                              Dash(
                                direction: Axis.vertical,
                                length: totalLength < 2
                                    ? 40
                                    : totalLength < 3
                                        ? 50
                                        : 70,
                                dashLength: 5,
                                dashThickness: 1.2,
                                dashColor: Colors.grey,
                              ),
                              SizedBox(height: 1,),
                              SvgPicture.asset(
                                'assets/booking_detail/dest_detail_icon.svg',
                                colorFilter: const ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: detail.sourcePlace,
                                height: 1.4,
                                color: const Color(0xFF0D0D0D),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              const SizedBox(height: 17),
                              Row(
                                children: [
                                  BookingTypeWidget(
                                    bookingType: detail.bookingTypeLabel,
                                  ),
                                  const SizedBox(width: 5),
                                  BookingDurationWidget(
                                    bookingDuration: detail.durationDistanceLine,
                                    textColor: const Color(0xFF0D0D0D),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    height: 1,
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 22,
                                    decoration: CustomDecorations()
                                        .baseBackgroundDecoration(
                                      20.0,
                                      0.0,
                                      const Color(0xFFF5F6FA),
                                      Colors.transparent,
                                    ),
                                    padding:
                                        const EdgeInsets.only(left: 8, right: 8, top: 0.8),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/booking_detail/navigate_icon.svg'),
                                        const SizedBox(width: 1),
                                        const CustomText(
                                          title: 'Navigate',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 17),
                              CustomText(
                                title: detail.destinationPlace,
                                height: 1.4,
                                color: const Color(0xFF0D0D0D),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        CustomBookingSummaryDataRowWithIcon(
                          title: 'Pax Name:',
                          desc: detail.paxName,
                          image: 'assets/booking_detail/pax_icon.svg',
                        ),
                        const SizedBox(height: 12),
                        CustomBookingSummaryDataRowWithIcon(
                          title: 'Mob. number:',
                          desc: detail.paxPhoneDisplay,
                          image: 'assets/booking_detail/contact_icon.svg',
                        ),
                        const SizedBox(height: 12),
                        CustomBookingSummaryDataRowWithIcon(
                          title: 'Email ID:',
                          desc: detail.paxEmail,
                          image: 'assets/booking_detail/email_icon.svg',
                        ),
                        const SizedBox(height: 12),
                        CustomBookingSummaryDataRowWithIcon(
                          title: 'Passenger count:',
                          desc: detail.passengerCountLabel,
                          image: 'assets/booking_detail/pax_count_icon.svg',
                        ),
                        const SizedBox(height: 12),
                        const CustomBookingSummaryDataRowWithIcon(
                          title: 'Chauffeur name: ',
                          desc: '—',
                          image: 'assets/booking_detail/pax_icon.svg',
                        ),
                        const SizedBox(height: 12),
                        const CustomBookingSummaryDataRowWithIcon(
                          title: 'Chauffeur number:',
                          desc: '—',
                          image: 'assets/booking_detail/contact_icon.svg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 11.3,
                  right: 15,
                  top: 10,
                ),
                decoration: CustomDecorations().baseBackgroundDecoration(
                  10.0,
                  1.0,
                  Colors.white,
                  const Color(0xFFE6E8E7),
                ),
                alignment: Alignment.center,
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    dense: true,
                    minTileHeight: 5,
                    iconColor: const Color(0xFF0D0D0D),
                    collapsedIconColor: const Color(0xFF0D0D0D),
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    title: const CustomText(
                      title: 'Additional Details',
                      color: Color(0xFF0D0D0D),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1,
                    ),
                    children: <Widget>[
                      const SizedBox(height: 12),
                      CustomBookingSummaryDataRowWithIcon(
                        title: 'Booked by:',
                        desc: detail.bookedBy,
                        image: 'assets/booking_detail/booked_by_icon.svg',
                      ),
                      const SizedBox(height: 12),
                      CustomBookingSummaryDataRowWithIcon(
                        title: 'Created date:',
                        desc: detail.createdDateLabel,
                        image: 'assets/booking_detail/created_date_icon.svg',
                      ),
                      const SizedBox(height: 12),
                      CustomBookingSummaryDataRowWithIcon(
                        title: 'Ref. number:',
                        desc: detail.referenceNumber,
                        image: 'assets/booking_detail/email_icon.svg',
                      ),
                      const SizedBox(height: 12),
                      CustomBookingSummaryDataRowWithIcon(
                        title: 'Spl. request:',
                        desc: detail.specialRequest,
                        image: 'assets/booking_detail/special_request_icon.svg',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (detail.isBookingStatusCancelled) ...[
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: CancellationPolicyWidget(),
                ),
              ),
              const SizedBox(height: 24),
            ],
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
