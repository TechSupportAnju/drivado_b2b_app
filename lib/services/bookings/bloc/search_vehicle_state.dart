abstract class SearchVehicleState {}

class SearchVehicleInitial extends SearchVehicleState {}

class SearchVehicleLoading extends SearchVehicleState {}

class SearchVehicleLoaded extends SearchVehicleState {
  final List<Map<String, dynamic>> vehicles;
  final String bookingSearchId;

  SearchVehicleLoaded({
    required this.vehicles,
    required this.bookingSearchId,
  });
}

class SearchVehicleFailure extends SearchVehicleState {
  final String message;

  SearchVehicleFailure(this.message);
}
