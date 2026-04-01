import 'package:equatable/equatable.dart';

abstract class BookingDetailEvent extends Equatable {
  const BookingDetailEvent();

  @override
  List<Object?> get props => [];
}

class BookingDetailLoadRequested extends BookingDetailEvent {
  final String bookingId;

  const BookingDetailLoadRequested({required this.bookingId});

  @override
  List<Object?> get props => [bookingId];
}
