import 'package:equatable/equatable.dart';

abstract class BookingDocumentState extends Equatable {
  const BookingDocumentState();

  @override
  List<Object?> get props => [];
}

class BookingDocumentInitial extends BookingDocumentState {}

class BookingDocumentSending extends BookingDocumentState {}

class BookingDocumentSuccess extends BookingDocumentState {}

class BookingDocumentFailure extends BookingDocumentState {
  final String message;

  const BookingDocumentFailure(this.message);

  @override
  List<Object?> get props => [message];
}
