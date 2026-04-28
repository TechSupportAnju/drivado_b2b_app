import 'package:equatable/equatable.dart';

abstract class CancelBookingState extends Equatable {
  const CancelBookingState();

  @override
  List<Object?> get props => [];
}

class CancelBookingInitial extends CancelBookingState {}

class CancelBookingLoading extends CancelBookingState {}

class CancelBookingSuccess extends CancelBookingState {}

class CancelBookingFailure extends CancelBookingState {
  final String message;

  const CancelBookingFailure(this.message);

  @override
  List<Object?> get props => [message];
}
