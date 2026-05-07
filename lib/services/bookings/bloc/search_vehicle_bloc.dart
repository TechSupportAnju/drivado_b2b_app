import 'package:drivado_b2b_app/services/bookings/bloc/search_vehicle_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/search_vehicle_state.dart';
import 'package:drivado_b2b_app/services/bookings/search_vehicle_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVehicleBloc extends Bloc<SearchVehicleEvent, SearchVehicleState> {
  final SearchVehicleRepository repository;

  SearchVehicleBloc({required this.repository}) : super(SearchVehicleInitial()) {
    on<SearchVehicleRequested>(_onSearchRequested);
  }

  Future<void> _onSearchRequested(
    SearchVehicleRequested event,
    Emitter<SearchVehicleState> emit,
  ) async {
    emit(SearchVehicleLoading());
    try {
      final result = await repository.showVehicleWithPrice(event.request);
      emit(
        SearchVehicleLoaded(
          vehicles: result.vehicles,
          bookingSearchId: result.bookingSearchId,
        ),
      );
    } catch (e) {
      emit(SearchVehicleFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
