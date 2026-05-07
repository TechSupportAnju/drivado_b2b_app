abstract class PassengerCreateAndBookingEvent {}

class PassengerCreateAndBookingSubmitRequested
    extends PassengerCreateAndBookingEvent {
  final Map<String, dynamic> payload;
  final String? accessToken;

  PassengerCreateAndBookingSubmitRequested({
    required this.payload,
    this.accessToken,
  });
}

class PassengerCreateAndBookingReset extends PassengerCreateAndBookingEvent {}
