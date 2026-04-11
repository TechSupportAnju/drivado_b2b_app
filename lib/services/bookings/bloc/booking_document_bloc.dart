import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_document_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_document_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_document_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDocumentBloc extends Bloc<BookingDocumentEvent, BookingDocumentState> {
  final BookingDocumentRepository repository;

  BookingDocumentBloc({required this.repository}) : super(BookingDocumentInitial()) {
    on<BookingDocumentSendRequested>(_onSend);
    on<BookingDocumentReset>(_onReset);
  }

  void _onReset(BookingDocumentReset event, Emitter<BookingDocumentState> emit) {
    emit(BookingDocumentInitial());
  }

  Future<void> _onSend(
    BookingDocumentSendRequested event,
    Emitter<BookingDocumentState> emit,
  ) async {
    emit(BookingDocumentSending());
    try {
      final token = await AuthService.getAccessToken();
      if (token == null || token.trim().isEmpty) {
        emit(const BookingDocumentFailure('Please log in again.'));
        return;
      }

      await repository.sendDocumentMail(
        kind: event.kind,
        detail: event.detail,
        email: event.email,
        accessToken: token.trim(),
        companyName: event.companyName,
      );

      emit(BookingDocumentSuccess());
    } catch (e) {
      emit(BookingDocumentFailure(e.toString()));
    }
  }
}
