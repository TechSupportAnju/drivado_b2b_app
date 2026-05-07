import 'package:drivado_b2b_app/services/bookings/search_vehicle_repository.dart';

abstract class SearchVehicleEvent {}

class SearchVehicleRequested extends SearchVehicleEvent {
  final SearchVehicleRequest request;

  SearchVehicleRequested(this.request);
}
