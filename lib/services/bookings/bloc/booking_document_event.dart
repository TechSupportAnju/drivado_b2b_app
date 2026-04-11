import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/models/booking_document_mail_kind.dart';
import 'package:equatable/equatable.dart';

abstract class BookingDocumentEvent extends Equatable {
  const BookingDocumentEvent();

  @override
  List<Object?> get props => [];
}

class BookingDocumentSendRequested extends BookingDocumentEvent {
  final BookingDocumentMailKind kind;
  final String email;
  final BookingDetailData detail;

  /// Logged-in company name (invoice); falls back to [BookingDetailData.bookingCompanyName].
  final String companyName;

  const BookingDocumentSendRequested({
    required this.kind,
    required this.email,
    required this.detail,
    required this.companyName,
  });

  @override
  List<Object?> get props => [kind, email, detail, companyName];
}

class BookingDocumentReset extends BookingDocumentEvent {
  const BookingDocumentReset();
}
