import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/flight_data_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/flight_data_state.dart';
import 'package:drivado_b2b_app/services/bookings/flight_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightDataBloc extends Bloc<FlightDataEvent, FlightDataState> {
  final FlightDataRepository repository;

  FlightDataBloc({required this.repository}) : super(const FlightDataInitial()) {
    on<FlightDataRequested>(_onRequested);
    on<FlightDataReset>(_onReset);
  }

  void _onReset(FlightDataReset event, Emitter<FlightDataState> emit) {
    emit(const FlightDataInitial());
  }

  String? _apiErrorMessage(Map<String, dynamic> map) {
    final err = map['error'];
    if (err is Map) {
      final m = err['errorMessage'] ?? err['message'];
      if (m != null && m.toString().trim().isNotEmpty) {
        return m.toString().trim();
      }
    }
    if (map['success'] == false) {
      final m = map['message'];
      if (m != null && m.toString().trim().isNotEmpty) {
        return m.toString().trim();
      }
    }
    return null;
  }

  Future<void> _onRequested(
    FlightDataRequested event,
    Emitter<FlightDataState> emit,
  ) async {
    emit(const FlightDataLoading());
    try {
      final token = await AuthService.getAccessToken();
      if (token == null || token.trim().isEmpty) {
        emit(const FlightDataFailure('Please log in again.'));
        return;
      }

      final map = await repository.getFlightData(
        flightNumber: event.flightNumber,
        dateLocal: event.lookupDateLocal,
        accessToken: token.trim(),
      );

      final errMsg = _apiErrorMessage(Map<String, dynamic>.from(map));
      if (errMsg != null) {
        emit(FlightDataFailure(errMsg));
        return;
      }

      emit(FlightDataLoaded(map));
    } catch (e) {
      emit(FlightDataFailure(e.toString()));
    }
  }
}
