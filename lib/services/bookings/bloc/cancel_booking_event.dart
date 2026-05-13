import 'package:equatable/equatable.dart';

abstract class CancelBookingEvent extends Equatable {
  const CancelBookingEvent();

  @override
  List<Object?> get props => [];
}

class CancelBookingRequested extends CancelBookingEvent {
  final String bookingId;
  /// Logged-in user `_id` (from profile) for `/v1/user/updateUser?id=`.
  final String? profileUserId;
  /// Company `_id` (from profile) for `/v1/company/updateCompany?id=`.
  final String? companyId;
  /// Sent as `availableLimit`; defaults used in repository when null.
  final int? companyAvailableLimit;

  const CancelBookingRequested({
    required this.bookingId,
    this.profileUserId,
    this.companyId,
    this.companyAvailableLimit,
  });

  @override
  List<Object?> get props => [
        bookingId,
        profileUserId,
        companyId,
        companyAvailableLimit,
      ];
}

class CancelBookingReset extends CancelBookingEvent {
  const CancelBookingReset();
}
