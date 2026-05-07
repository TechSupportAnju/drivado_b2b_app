import 'package:drivado_b2b_app/services/bookings/bloc/booking_with_vechile_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_with_vechile_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_with_vechile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingWithVechileBloc
    extends Bloc<BookingWithVechileEvent, BookingWithVechileState> {
  final BookingWithVechileRepository repository;

  BookingWithVechileBloc({required this.repository})
      : super(BookingWithVechileInitial()) {
    on<BookingWithVechileSubmitRequested>(_onSubmitRequested);
    on<BookingWithVechileReset>((event, emit) => emit(BookingWithVechileInitial()));
  }

  Future<void> _onSubmitRequested(
    BookingWithVechileSubmitRequested event,
    Emitter<BookingWithVechileState> emit,
  ) async {
    emit(BookingWithVechileLoading());
    try {
      final response = await repository.createBooking(
        payload: event.payload,
        accessToken: event.accessToken,
      );
      emit(BookingWithVechileSuccess(response));
    } catch (e) {
      emit(BookingWithVechileFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
