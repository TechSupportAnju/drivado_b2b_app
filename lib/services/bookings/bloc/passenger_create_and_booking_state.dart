abstract class PassengerCreateAndBookingState {}

class PassengerCreateAndBookingInitial extends PassengerCreateAndBookingState {}

class PassengerCreateAndBookingLoading extends PassengerCreateAndBookingState {}

class PassengerCreateAndBookingSuccess extends PassengerCreateAndBookingState {
  final Map<String, dynamic> response;

  PassengerCreateAndBookingSuccess(this.response);
}

class PassengerCreateAndBookingFailure extends PassengerCreateAndBookingState {
  final String message;

  PassengerCreateAndBookingFailure(this.message);
}
