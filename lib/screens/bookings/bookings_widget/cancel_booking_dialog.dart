import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/cancel_booking_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/cancel_booking_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/cancel_booking_state.dart';
import 'package:drivado_b2b_app/services/bookings/cancel_booking_repository.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Opens cancel confirmation; on success closes dialog and the [parentContext] route (detail page).
void showCancelBookingDialog(
  BuildContext parentContext, {
  required BookingDetailData detail,
}) {
  showDialog<void>(
    context: parentContext,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider(
        create: (_) => CancelBookingBloc(
          repository: CancelBookingRepository(),
        ),
        child: BlocConsumer<CancelBookingBloc, CancelBookingState>(
          listenWhen: (p, c) =>
              c is CancelBookingSuccess || c is CancelBookingFailure,
          listener: (context, state) {
            if (state is CancelBookingSuccess) {
              Navigator.of(dialogContext).pop();
              final profileState =
                  parentContext.read<UserInformationBloc>().state;
              if (profileState is UserInformationLoaded) {
                parentContext.read<BookingListBloc>().add(
                      BookingListRefreshRequested(
                        userData: profileState.userData,
                      ),
                    );
              }
              ScaffoldMessenger.of(parentContext).showSnackBar(
                const SnackBar(content: Text('Booking cancelled.')),
              );
              Navigator.of(parentContext).pop();
            } else if (state is CancelBookingFailure) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final loading = state is CancelBookingLoading;
            final bookingId = detail.bookingId;
            final source = detail.sourcePlace;
            final dest = detail.destinationPlace;
            final time = detail.cancelDialogPickupDateTimeLine;
            final amount = detail.priceLabel;
            final duration = detail.duration.isNotEmpty ? detail.duration : '—';
            final isDropOffRow = detail.cancelDialogUseDropOffRow;

            final maxH = MediaQuery.of(dialogContext).size.height * 0.88;

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxH),
                child: Container(
                  width: MediaQuery.of(dialogContext).size.width,
                  decoration: CustomDecorations().baseBackgroundDecoration(
                    16.0,
                    1.0,
                    AppColors.adminUserMangBgColor,
                    Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 56,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                title: 'Cancel Booking',
                                color: AppColors.manageBookingbokkedByTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              GestureDetector(
                                onTap: loading
                                    ? null
                                    : () => Navigator.of(dialogContext).pop(),
                                child: SvgPicture.asset(
                                  'assets/more/close-circle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: CustomDecorations()
                                .baseBackgroundDecoration(
                              16.0,
                              1.0,
                              Colors.white,
                              Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: CustomDecorations()
                                      .baseBackgroundDecoration(
                                    8.0,
                                    1.0,
                                    AppColors.adminUserMangBgColor,
                                    AppColors.adminUserMangBgColor,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Row(
                                        children: [
                                          CustomText(
                                            title: 'Booking Details',
                                            color: AppColors
                                                .manageBookingAdminbookedbyTitleTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Divider(
                                        color: AppColors.manageBookingbokkedByTextColor,
                                        thickness: 0.5,
                                      ),
                                      const SizedBox(height: 12),
                                      BookingCancelPopupWidget(
                                        text: 'Booking Id',
                                        desc: bookingId,
                                      ),
                                      const SizedBox(height: 12),
                                      BookingCancelPopupWidget(
                                        text: 'Pickup',
                                        desc: source,
                                      ),
                                      const SizedBox(height: 12),
                                      BookingCancelPopupWidget(
                                        text: isDropOffRow
                                            ? 'Drop off'
                                            : 'Duration',
                                        desc: isDropOffRow ? dest : duration,
                                      ),
                                      const SizedBox(height: 12),
                                      BookingCancelPopupWidget(
                                        text: 'Pickup date & time',
                                        desc: time,
                                      ),
                                      const SizedBox(height: 12),
                                      BookingCancelPopupWidget(
                                        text: 'Total Amount',
                                        desc: amount,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const CancellationPolicyWidget(),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: loading
                                            ? null
                                            : () =>
                                                Navigator.of(dialogContext).pop(),
                                        child: Container(
                                          height: 44,
                                          decoration: CustomDecorations()
                                              .baseBackgroundDecoration(
                                            8.0,
                                            1.0,
                                            AppColors.secondary,
                                            AppColors.secondary,
                                          ),
                                          alignment: Alignment.center,
                                          child: const CustomText(
                                            title: 'Keep, booking',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: InkWell(
                                        onTap: loading
                                            ? null
                                            : () {
                                                context
                                                    .read<CancelBookingBloc>()
                                                    .add(
                                                      CancelBookingRequested(
                                                        bookingId: bookingId,
                                                      ),
                                                    );
                                              },
                                        child: Container(
                                          height: 44,
                                          decoration: CustomDecorations()
                                              .baseBackgroundDecoration(
                                            8.0,
                                            1.0,
                                            Colors.white,
                                            AppColors
                                                .manageBookingbokkedByTextColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: loading
                                              ? Center(
                                                  child: LoadingAnimationWidget
                                                      .threeArchedCircle(
                                                    color: AppColors
                                                        .manageBookingbokkedByTextColor,
                                                    size: 30,
                                                  ),
                                                )
                                              : const CustomText(
                                                  title: 'Yes, Cancel',
                                                  color: AppColors
                                                      .manageBookingbokkedByTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class BookingCancelPopupWidget extends StatelessWidget {
  final String text;
  final String desc;

  const BookingCancelPopupWidget({
    super.key,
    required this.text,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: CustomText(
            title: text,
            overflow: TextOverflow.ellipsis,
            maxLine: 3,
            height: 1.4,
            textAlign: TextAlign.start,
            color: AppColors.manageBookingbokkedByTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomText(
            title: desc,
            overflow: TextOverflow.ellipsis,
            maxLine: 4,
            height: 1.4,
            textAlign: TextAlign.end,
            color: AppColors.manageBookingAdminbookedbyTitleTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class CancellationPolicyWidget extends StatelessWidget {
  const CancellationPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: CustomDecorations().baseBackgroundDecoration(
        8.0,
        1.0,
        AppColors.adminUserMangBgColor,
        AppColors.adminUserMangBgColor,
      ),
      child: const CustomText(
        title:
            'Cancellation may be subject to the provider’s policy and fees. '
            'Refunds (if any) are processed per your agreement with Drivado.',
        color: AppColors.manageBookingbokkedByTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.4,
        maxLine: 6,
      ),
    );
  }
}
