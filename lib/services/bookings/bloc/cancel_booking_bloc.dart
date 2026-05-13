import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/cancel_booking_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/cancel_booking_state.dart';
import 'package:drivado_b2b_app/services/bookings/cancel_booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelBookingBloc extends Bloc<CancelBookingEvent, CancelBookingState> {
  final CancelBookingRepository repository;

  CancelBookingBloc({required this.repository}) : super(CancelBookingInitial()) {
    on<CancelBookingRequested>(_onCancel);
    on<CancelBookingReset>(_onReset);
  }

  void _onReset(CancelBookingReset event, Emitter<CancelBookingState> emit) {
    emit(CancelBookingInitial());
  }

  Future<void> _onCancel(
    CancelBookingRequested event,
    Emitter<CancelBookingState> emit,
  ) async {
    emit(CancelBookingLoading());
    try {
      final token = await AuthService.getAccessToken();
      if (token == null || token.trim().isEmpty) {
        emit(const CancelBookingFailure('Please log in again.'));
        return;
      }
      await repository.cancelBooking(
        bookingId: event.bookingId,
        accessToken: token.trim(),
        profileUserId: event.profileUserId,
        companyId: event.companyId,
        companyAvailableLimit: event.companyAvailableLimit,
      );
      emit(CancelBookingSuccess());
    } catch (e) {
      emit(CancelBookingFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
