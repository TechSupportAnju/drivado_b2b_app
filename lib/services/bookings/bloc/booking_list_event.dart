import 'package:drivado_b2b_app/models/booking_search_filter_payload.dart';
import 'package:drivado_b2b_app/models/user_info_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookingListEvent extends Equatable {
  const BookingListEvent();

  @override
  List<Object?> get props => [];
}

/// Load first page using [UserData] (permissions, company, role, userName).
class BookingListFetchRequested extends BookingListEvent {
  final UserData userData;

  const BookingListFetchRequested({required this.userData});

  @override
  List<Object?> get props => [userData];
}

/// Refresh current query (same as initial fetch).
class BookingListRefreshRequested extends BookingListEvent {
  final UserData userData;

  const BookingListRefreshRequested({required this.userData});

  @override
  List<Object?> get props => [userData];
}

/// Append next page (infinite scroll).
class BookingListLoadMoreRequested extends BookingListEvent {
  final UserData userData;

  const BookingListLoadMoreRequested({required this.userData});

  @override
  List<Object?> get props => [userData];
}

/// Clears list state (e.g. after logout) so another account never sees cached rows.
class BookingListReset extends BookingListEvent {
  const BookingListReset();
}

/// Filtered list via GET `bookingWithsearch` (page 1).
class BookingListSearchRequested extends BookingListEvent {
  final UserData userData;
  final BookingSearchFilterPayload filter;

  const BookingListSearchRequested({
    required this.userData,
    required this.filter,
  });

  @override
  List<Object?> get props => [userData, filter];
}
