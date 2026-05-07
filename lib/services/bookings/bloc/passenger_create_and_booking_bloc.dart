import 'package:drivado_b2b_app/services/bookings/bloc/passenger_create_and_booking_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/passenger_create_and_booking_state.dart';
import 'package:drivado_b2b_app/services/bookings/passenger_create_and_booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerCreateAndBookingBloc
    extends Bloc<PassengerCreateAndBookingEvent, PassengerCreateAndBookingState> {
  final PassengerCreateAndBookingRepository repository;

  PassengerCreateAndBookingBloc({required this.repository})
      : super(PassengerCreateAndBookingInitial()) {
    on<PassengerCreateAndBookingSubmitRequested>(_onSubmitRequested);
    on<PassengerCreateAndBookingReset>(
      (event, emit) => emit(PassengerCreateAndBookingInitial()),
    );
  }

  Future<void> _onSubmitRequested(
    PassengerCreateAndBookingSubmitRequested event,
    Emitter<PassengerCreateAndBookingState> emit,
  ) async {
    emit(PassengerCreateAndBookingLoading());
    try {
      final response = await repository.createPassengerAndAttachBooking(
        payload: event.payload,
        accessToken: event.accessToken,
      );
      emit(PassengerCreateAndBookingSuccess(response));
    } catch (e) {
      emit(
        PassengerCreateAndBookingFailure(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
