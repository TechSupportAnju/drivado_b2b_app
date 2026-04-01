import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_detail_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final BookingDetailRepository repository;

  BookingDetailBloc({required this.repository}) : super(BookingDetailInitial()) {
    on<BookingDetailLoadRequested>(_onLoad);
  }

  Future<void> _onLoad(
    BookingDetailLoadRequested event,
    Emitter<BookingDetailState> emit,
  ) async {
    emit(BookingDetailLoading());
    try {
      final data = await repository.getBookingDetail(event.bookingId);
      emit(BookingDetailLoaded(data));
    } catch (e) {
      emit(BookingDetailFailure(e.toString()));
    }
  }
}
