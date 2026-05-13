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

  BookingSearchFilterPayload copyWith({
    BookingFilterDateRangeKind? dateRangeKind,
    String? dateFrom,
    bool clearDateFrom = false,
    String? dateTo,
    bool clearDateTo = false,
    String? bookingId,
    bool clearBookingId = false,
    String? companyName,
    bool clearCompanyName = false,
    String? userNameQuery,
    bool clearUserNameQuery = false,
    String? customerName,
    bool clearCustomerName = false,
    String? passengerNumber,
    bool clearPassengerNumber = false,
    String? driverName,
    bool clearDriverName = false,
    String? driverNumber,
    bool clearDriverNumber = false,
    String? quoteBy,
    bool clearQuoteBy = false,
    List<String>? bookingStatuses,
  }) {
    return BookingSearchFilterPayload(
      dateRangeKind: dateRangeKind ?? this.dateRangeKind,
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      bookingId: clearBookingId ? null : (bookingId ?? this.bookingId),
      companyName: clearCompanyName ? null : (companyName ?? this.companyName),
      userNameQuery:
          clearUserNameQuery ? null : (userNameQuery ?? this.userNameQuery),
      customerName:
          clearCustomerName ? null : (customerName ?? this.customerName),
      passengerNumber:
          clearPassengerNumber ? null : (passengerNumber ?? this.passengerNumber),
      driverName: clearDriverName ? null : (driverName ?? this.driverName),
      driverNumber: clearDriverNumber ? null : (driverNumber ?? this.driverNumber),
      quoteBy: clearQuoteBy ? null : (quoteBy ?? this.quoteBy),
      bookingStatuses: bookingStatuses ?? this.bookingStatuses,
    );
  }

  bool get hasAnyActiveFilters {
    bool hasText(String? value) => value != null && value.trim().isNotEmpty;
    return hasText(dateFrom) ||
        hasText(dateTo) ||
        hasText(bookingId) ||
        hasText(companyName) ||
        hasText(userNameQuery) ||
        hasText(customerName) ||
        hasText(passengerNumber) ||
        hasText(driverName) ||
        hasText(driverNumber) ||
        hasText(quoteBy) ||
        bookingStatuses.isNotEmpty;
  }

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
