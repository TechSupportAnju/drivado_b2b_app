import 'package:drivado_b2b_app/models/booking_list_item.dart';
import 'package:drivado_b2b_app/models/booking_search_filter_payload.dart';
import 'package:equatable/equatable.dart';

abstract class BookingListState extends Equatable {
  const BookingListState();

  @override
  List<Object?> get props => [];
}

class BookingListInitial extends BookingListState {}

class BookingListLoading extends BookingListState {}

class BookingListLoaded extends BookingListState {
  final List<BookingListItem> items;
  final int totalCount;
  final int currentPage;
  final bool isLoadingMore;

  /// Whether another page may exist (from API total and/or full last page).
  final bool canLoadMore;

  /// When set, [BookingListLoadMoreRequested] / refresh continues with search API.
  final BookingSearchFilterPayload? activeSearch;

  const BookingListLoaded({
    required this.items,
    required this.totalCount,
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.canLoadMore = false,
    this.activeSearch,
  });

  /// Default page size hint when API omits total or total equals first page length.
  static const int kDefaultPageSize = 10;

  BookingListLoaded copyWith({
    List<BookingListItem>? items,
    int? totalCount,
    int? currentPage,
    bool? isLoadingMore,
    bool? canLoadMore,
    BookingSearchFilterPayload? activeSearch,
    bool clearActiveSearch = false,
  }) {
    return BookingListLoaded(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      activeSearch:
          clearActiveSearch ? null : (activeSearch ?? this.activeSearch),
    );
  }

  @override
  List<Object?> get props => [
    items,
    totalCount,
    currentPage,
    isLoadingMore,
    canLoadMore,
    activeSearch,
  ];
}

class BookingListFailure extends BookingListState {
  final String message;

  const BookingListFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// User profile missing fields needed for the API.
class BookingListMissingUserContext extends BookingListState {
  final String message;

  const BookingListMissingUserContext(this.message);

  @override
  List<Object?> get props => [message];
}
