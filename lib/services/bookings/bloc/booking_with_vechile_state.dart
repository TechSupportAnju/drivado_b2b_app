abstract class BookingWithVechileState {}

class BookingWithVechileInitial extends BookingWithVechileState {}

class BookingWithVechileLoading extends BookingWithVechileState {}

class BookingWithVechileSuccess extends BookingWithVechileState {
  final Map<String, dynamic> response;

  BookingWithVechileSuccess(this.response);
}

class BookingWithVechileFailure extends BookingWithVechileState {
  final String message;

  BookingWithVechileFailure(this.message);
}
