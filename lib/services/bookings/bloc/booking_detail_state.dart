import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookingDetailState extends Equatable {
  const BookingDetailState();

  @override
  List<Object?> get props => [];
}

class BookingDetailInitial extends BookingDetailState {}

class BookingDetailLoading extends BookingDetailState {}

class BookingDetailLoaded extends BookingDetailState {
  final BookingDetailData data;

  const BookingDetailLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class BookingDetailFailure extends BookingDetailState {
  final String message;

  const BookingDetailFailure(this.message);

  @override
  List<Object?> get props => [message];
}
