import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/models/booking_document_mail_kind.dart';

/// POST JSON bodies for `voucherMail`, `invoiceMail`, `driverdetailMail`.
class BookingDocumentMailBody {
  BookingDocumentMailBody._();

  static String _userSelect(BookingDocumentMailKind kind) => switch (kind) {
    BookingDocumentMailKind.voucher => 'voucher',
    BookingDocumentMailKind.invoice => 'invoice',
    BookingDocumentMailKind.driverDetails => 'driverdetail',
  };

  static Map<String, dynamic> build({
    required BookingDocumentMailKind kind,
    required String email,
    required BookingDetailData detail,
    required String companyName,
  }) {
    final legacy = <String, dynamic>{
      'bookingId': detail.bookingId,
      'email': email,
      'userselectvalue': _userSelect(kind),
    };

    switch (kind) {
      case BookingDocumentMailKind.invoice:
        return {
          ...legacy,
          'company_name': companyName,
          'invoice_number': detail.documentInvoiceNumber,
          'booking_id': detail.bookingId,
          'from': detail.sourcePlace,
          'to': detail.destinationPlace,
          'booking_price_unit': detail.priceCurrency,
          'booking_price_currency': detail.priceAmount,
        };
      case BookingDocumentMailKind.voucher:
        return {
          ...legacy,
          'booking_id': detail.bookingId,
          'from': detail.sourcePlace,
          'to': detail.destinationPlace,
          'timeAndDate': detail.documentTimeAndDateLine,
          'bookingType': detail.bookingTypeLabel,
          'bookingStatus': detail.documentBookingStatusApi,
          'distance': detail.documentDistanceLabel,
          'flt_no': detail.documentFlightNo,
          'sp_req': detail.documentSpecialRequestRaw,
          'vehicleType': detail.documentVehicleType,
          'passengerName': detail.documentPaxName,
          'pax_email': detail.documentPaxEmail,
          'mob_number': detail.documentMobNumber,
          'pax': detail.passengerCount,
          'emergency_number': detail.emergencyContactMail,
        };
      case BookingDocumentMailKind.driverDetails:
        return {
          ...legacy,
          'bookingId': detail.bookingId,
          'from': detail.sourcePlace,
          'to': detail.destinationPlace,
          'timeAndDate': detail.documentTimeAndDateLine,
          'bookingType': detail.bookingTypeLabel,
        };
    }
  }
}
