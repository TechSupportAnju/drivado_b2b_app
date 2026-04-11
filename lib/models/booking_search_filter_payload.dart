import 'package:drivado_b2b_app/services/bookings/booking_list_query_params.dart';
import 'package:equatable/equatable.dart';

/// Which date pair maps to the API (`createdDate*` vs `travel*`).
enum BookingFilterDateRangeKind { bookingCreated, travel }

/// Optional filters for GET `/v1/bookings/bookingWithsearch`.
/// Only non-empty values are sent as query parameters.
class BookingSearchFilterPayload extends Equatable {
  final BookingFilterDateRangeKind dateRangeKind;
  final String? dateFrom;
  final String? dateTo;
  final String? bookingId;
  final String? companyName;
  final String? userNameQuery;
  final String? customerName;
  final String? passengerNumber;
  final String? driverName;
  final String? driverNumber;
  final String? quoteBy;
  final List<String> bookingStatuses;

  const BookingSearchFilterPayload({
    required this.dateRangeKind,
    this.dateFrom,
    this.dateTo,
    this.bookingId,
    this.companyName,
    this.userNameQuery,
    this.customerName,
    this.passengerNumber,
    this.driverName,
    this.driverNumber,
    this.quoteBy,
    this.bookingStatuses = const [],
  });

  Map<String, String> toQueryMap({
    required BookingListQueryParams context,
    required int page,
  }) {
    final m = <String, String>{
      'page': '$page',
      'viewBookingPermisision': context.viewBookingPermission,
      'companyId': context.companyId,
      'userRole': context.userRole,
      'userName': context.userName,
    };

    void put(String key, String? value) {
      final t = value?.trim();
      if (t != null && t.isNotEmpty) {
        m[key] = t;
      }
    }

    if (dateRangeKind == BookingFilterDateRangeKind.bookingCreated) {
      put('createdDateStart', dateFrom);
      put('createdDateEnd', dateTo);
    } else {
      put('travelStartDate', dateFrom);
      put('travelEndDate', dateTo);
    }

    put('bookingId', bookingId);
    put('companyName', companyName);
    put('userNameQuery', userNameQuery);
    put('customerName', customerName);
    put('passengerNumber', passengerNumber);
    put('driverName', driverName);
    put('driverNumber', driverNumber);
    put('quoteby', quoteBy);

    if (bookingStatuses.isNotEmpty) {
      m['bookingStatus'] = bookingStatuses.join(',');
    }

    return m;
  }

  @override
  List<Object?> get props => [
    dateRangeKind,
    dateFrom,
    dateTo,
    bookingId,
    companyName,
    userNameQuery,
    customerName,
    passengerNumber,
    driverName,
    driverNumber,
    quoteBy,
    bookingStatuses,
  ];
}
