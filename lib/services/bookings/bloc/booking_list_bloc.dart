import 'dart:developer';

import 'package:drivado_b2b_app/models/booking_list_item.dart';
import 'package:drivado_b2b_app/models/user_info_model.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_query_params.dart';
import 'package:drivado_b2b_app/services/bookings/booking_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  final BookingListRepository repository;

  BookingListBloc({required this.repository}) : super(BookingListInitial()) {
    on<BookingListFetchRequested>(_onFetch);
    on<BookingListRefreshRequested>(_onRefresh);
    on<BookingListLoadMoreRequested>(_onLoadMore);
    on<BookingListReset>(_onReset);
  }

  void _onReset(BookingListReset event, Emitter<BookingListState> emit) {
    emit(BookingListInitial());
  }

  Future<void> _onFetch(
    BookingListFetchRequested event,
    Emitter<BookingListState> emit,
  ) async {
    log('BookingListBloc: BookingListFetchRequested');
    await _load(emit, event.userData, page: 1);
  }

  Future<void> _onRefresh(
    BookingListRefreshRequested event,
    Emitter<BookingListState> emit,
  ) async {
    await _load(emit, event.userData, page: 1);
  }

  Future<void> _onLoadMore(
    BookingListLoadMoreRequested event,
    Emitter<BookingListState> emit,
  ) async {
    final s = state;
    if (s is! BookingListLoaded) return;
    if (s.isLoadingMore || !s.canLoadMore) return;

    final params = BookingListQueryParams.tryFromUserData(event.userData);
    if (params == null) return;

    emit(s.copyWith(isLoadingMore: true));
    try {
      final nextPage = s.currentPage + 1;
      log('BookingListBloc: getAllBookingsV2 page=$nextPage (load more)');
      final result = await repository.getAllBookingsV2(
        page: nextPage,
        params: params,
      );

      if (result.items.isEmpty) {
        emit(s.copyWith(
          isLoadingMore: false,
          canLoadMore: false,
        ));
        return;
      }

      final merged = _mergeById(s.items, result.items);
      final totalCount = result.totalCount >= merged.length
          ? result.totalCount
          : (s.totalCount > merged.length ? s.totalCount : merged.length);

      final canLoadMore = _inferCanLoadMore(
        listLength: merged.length,
        totalCount: totalCount,
        lastPageSize: result.items.length,
      );

      emit(BookingListLoaded(
        items: merged,
        totalCount: totalCount,
        currentPage: nextPage,
        isLoadingMore: false,
        canLoadMore: canLoadMore,
      ));
      log('BookingListBloc: load more → ${merged.length} items total');
    } catch (e) {
      emit(s.copyWith(isLoadingMore: false));
      log('BookingListBloc: load more failed: $e');
    }
  }

  Future<void> _load(
    Emitter<BookingListState> emit,
    UserData userData, {
    required int page,
  }) async {
    final params = BookingListQueryParams.tryFromUserData(userData);
    if (params == null) {
      log(
        'BookingListBloc: getAllBookingsV2 NOT called — '
        '${BookingListQueryParams.missingSummary(userData)}',
      );
      emit(const BookingListMissingUserContext(
        'Missing booking permissions or company. Please refresh profile.',
      ));
      return;
    }

    emit(BookingListLoading());
    try {
      log('BookingListBloc: calling getAllBookingsV2 page=$page');

      final result = await repository.getAllBookingsV2(
        page: page,
        params: params,
      );

      log('BookingListBloc: loaded ${result.items.length} items');

      final canLoadMore = _inferCanLoadMore(
        listLength: result.items.length,
        totalCount: result.totalCount,
        lastPageSize: result.items.length,
      );

      emit(BookingListLoaded(
        items: result.items,
        totalCount: result.totalCount,
        currentPage: page,
        isLoadingMore: false,
        canLoadMore: canLoadMore,
      ));
    } catch (e) {
      emit(BookingListFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}

List<BookingListItem> _mergeById(
  List<BookingListItem> existing,
  List<BookingListItem> page,
) {
  final seen = existing.map((e) => e.id).toSet();
  final out = List<BookingListItem>.from(existing);
  for (final e in page) {
    if (seen.add(e.id)) out.add(e);
  }
  return out;
}

/// More pages when API reports a higher total, or last page was "full" (try next until empty).
bool _inferCanLoadMore({
  required int listLength,
  required int totalCount,
  required int lastPageSize,
}) {
  if (lastPageSize == 0) return false;
  if (listLength < totalCount) return true;
  return lastPageSize >= BookingListLoaded.kDefaultPageSize;
}
