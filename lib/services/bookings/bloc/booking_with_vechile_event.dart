abstract class BookingWithVechileEvent {}

class BookingWithVechileSubmitRequested extends BookingWithVechileEvent {
  final Map<String, dynamic> payload;
  final String? accessToken;

  BookingWithVechileSubmitRequested({
    required this.payload,
    this.accessToken,
  });
}

class BookingWithVechileReset extends BookingWithVechileEvent {}
