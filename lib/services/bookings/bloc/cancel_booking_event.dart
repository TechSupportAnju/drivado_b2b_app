import 'package:equatable/equatable.dart';

abstract class CancelBookingEvent extends Equatable {
  const CancelBookingEvent();

  @override
  List<Object?> get props => [];
}

class CancelBookingRequested extends CancelBookingEvent {
  final String bookingId;

  const CancelBookingRequested({required this.bookingId});

  @override
  List<Object?> get props => [bookingId];
}

class CancelBookingReset extends CancelBookingEvent {
  const CancelBookingReset();
}
