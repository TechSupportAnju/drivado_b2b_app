import 'package:intl/intl.dart';

/// Single booking from GET `/v1/bookings?id=` — root key `bookingDetails`.
class BookingDetailData {
  final String bookingId;
  final String bookingStatus;
  final String paymentStatus;
  final String sourcePlace;
  final String destinationPlace;
  final String travelTime;
  final DateTime? travelDateLocal;
  final String duration;
  final double? travelDistanceKm;
  final String bookingTypeRaw;
  final String vehicleCategory;
  final String priceCurrency;
  final num priceAmount;
  final int passengerCount;
  final String paxName;
  final String paxEmail;
  final String paxPhoneDisplay;
  final String bookedBy;
  final DateTime? createdAt;
  final String referenceNumber;
  final String specialRequest;

  /// From `passengerDetails.flightNumber` when present.
  final String? flightNumber;

  /// Invoice ref for mail APIs (`invoiceNumber`, nested `invoice`, …).
  final String? invoiceNumber;

  /// Company on booking payload when present.
  final String? bookingCompanyName;

  /// Formatted emergency contacts line for voucher mail.
  final String emergencyContactMail;

  const BookingDetailData({
    required this.bookingId,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.sourcePlace,
    required this.destinationPlace,
    required this.travelTime,
    required this.travelDateLocal,
    required this.duration,
    required this.travelDistanceKm,
    required this.bookingTypeRaw,
    required this.vehicleCategory,
    required this.priceCurrency,
    required this.priceAmount,
    required this.passengerCount,
    required this.paxName,
    required this.paxEmail,
    required this.paxPhoneDisplay,
    required this.bookedBy,
    required this.createdAt,
    required this.referenceNumber,
    required this.specialRequest,
    this.flightNumber,
    this.invoiceNumber,
    this.bookingCompanyName,
    this.emergencyContactMail = '',
  });

  /// Shown when the booking has a flight number and a date to query (`travelDate` or `createdAt`).
  bool get canShowFlightStatus {
    final fn = flightNumber?.trim();
    if (fn == null || fn.isEmpty) return false;
    return effectiveFlightLookupDate != null;
  }

  DateTime? get effectiveFlightLookupDate => travelDateLocal ?? createdAt;

  static String _s(dynamic v) => v?.toString().trim() ?? '';

  static String _placeName(dynamic loc) {
    if (loc is Map) {
      var s = _s(loc['placename'] ?? loc['placeName']);
      s =
          s
              .replaceAll(RegExp(r',?\s*undefined', caseSensitive: false), '')
              .trim();
      if (s.endsWith(',')) s = s.substring(0, s.length - 1).trim();
      return s;
    }
    return '';
  }

  /// `Wed,` · `Mar 26, 2026` · time line from API.
  (String, String, String) get travelHeaderLabels {
    final t = travelTime.isNotEmpty ? travelTime : '—';
    final dt = travelDateLocal;
    if (dt == null) return ('—', '—', t);
    return (
      DateFormat('EEE,').format(dt),
      DateFormat('MMM d, y').format(dt),
      t,
    );
  }

  String get bookingTypeLabel {
    final u = bookingTypeRaw.toUpperCase();
    if (u == 'ONEWAY') return 'Oneway';
    if (u == 'HOURLY') return 'Hourly';
    if (u == 'RETURN' || u == 'ROUNDTRIP') return 'Return';
    return bookingTypeRaw.isEmpty ? '—' : bookingTypeRaw;
  }

  String get durationDistanceLine {
    if (travelDistanceKm != null) {
      final raw = travelDistanceKm!;
      final km =
          (raw - raw.round()).abs() < 1e-9
              ? '${raw.round()}'
              : raw.toStringAsFixed(1);
      if (duration.isNotEmpty) return '$km km | $duration';
      return '$km km';
    }
    return duration.isNotEmpty ? duration : '—';
  }

  String get priceLabel {
    final d = priceAmount.toDouble();
    if ((d - d.round()).abs() < 1e-9) {
      return '$priceCurrency ${d.round()}';
    }
    return '$priceCurrency $priceAmount';
  }

  String get createdDateLabel {
    final c = createdAt;
    if (c == null) return '—';
    return DateFormat('dd-MM-yyyy').format(c.toLocal());
  }

  String get passengerCountLabel => '$passengerCount Pax';

  /// Oneway / return / roundtrip show **Drop off**; hourly uses **Duration** (cancel dialog).
  bool get cancelDialogUseDropOffRow {
    final u = bookingTypeRaw.toUpperCase();
    if (u == 'HOURLY') return false;
    return u.isEmpty ||
        u == 'ONEWAY' ||
        u == 'RETURN' ||
        u == 'ROUNDTRIP';
  }

  /// e.g. `Mar 5, 2027 at 15:38` for cancel popup.
  String get cancelDialogPickupDateTimeLine {
    final dt = travelDateLocal;
    if (dt == null) {
      return travelTime.isNotEmpty ? travelTime : '—';
    }
    final d = DateFormat('MMM d, y').format(dt);
    final t = travelTime.isNotEmpty
        ? travelTime
        : DateFormat('HH:mm').format(dt);
    return '$d at $t';
  }

  static String _ordinalDay(int d) {
    if (d >= 11 && d <= 13) return '${d}th';
    switch (d % 10) {
      case 1:
        return '${d}st';
      case 2:
        return '${d}nd';
      case 3:
        return '${d}rd';
      default:
        return '${d}th';
    }
  }

  static String _emergencyContactLine(Map<String, dynamic>? px) {
    if (px == null) return '';
    final direct = _s(
      px['emergencyContact'] ??
          px['emergencyNumber'] ??
          px['emergencyPhone'] ??
          px['emergency_contact'],
    );
    if (direct.isNotEmpty) return direct;
    final list =
        px['emergencyContacts'] ??
        px['emergencyNumbers'] ??
        px['emergencyContactsList'];
    if (list is List) {
      final out = <String>[];
      for (final e in list) {
        if (e is Map) {
          final em = Map<String, dynamic>.from(e);
          final label = _s(
            em['label'] ?? em['country'] ?? em['region'] ?? em['name'],
          );
          final ph = _s(em['phone'] ?? em['number'] ?? em['mobile']);
          if (ph.isNotEmpty) {
            out.add(label.isEmpty ? ph : '$label: $ph');
          }
        } else if (e != null) {
          final t = e.toString().trim();
          if (t.isNotEmpty) out.add(t);
        }
      }
      if (out.isNotEmpty) return out.join(' ');
    }
    return '';
  }

  /// e.g. `5th Mar 2027 | 15:38` for document mails.
  String get documentTimeAndDateLine {
    final dt = travelDateLocal;
    final timePart =
        travelTime.isNotEmpty
            ? travelTime
            : (dt != null ? DateFormat('HH:mm').format(dt) : '');
    if (dt == null) {
      return timePart.isNotEmpty ? timePart : '—';
    }
    final dayOrd = _ordinalDay(dt.day);
    final monY = DateFormat('MMM y').format(dt);
    if (timePart.isEmpty) return '$dayOrd $monY';
    return '$dayOrd $monY | $timePart';
  }

  String get documentDistanceLabel {
    if (travelDistanceKm != null) {
      final raw = travelDistanceKm!;
      final km =
          (raw - raw.round()).abs() < 1e-9
              ? '${raw.round()}'
              : raw.toStringAsFixed(1);
      return '$km KM';
    }
    if (duration.isNotEmpty) return duration;
    return '';
  }

  String get documentFlightNo => flightNumber?.trim() ?? '';

  String get documentSpecialRequestRaw =>
      specialRequest == '—' ? '' : specialRequest;

  String get documentVehicleType =>
      vehicleCategory == '—' ? '' : vehicleCategory;

  String get documentPaxName => paxName == '—' ? '' : paxName;

  String get documentPaxEmail => paxEmail == '—' ? '' : paxEmail;

  String get documentMobNumber => paxPhoneDisplay == '—' ? '' : paxPhoneDisplay;

  String get documentInvoiceNumber {
    final inv = invoiceNumber?.trim();
    if (inv != null && inv.isNotEmpty) return inv;
    return bookingId == '—' ? '' : bookingId;
  }

  String get documentBookingStatusApi {
    if (bookingStatus == '—') return '';
    return bookingStatus.toUpperCase();
  }

  factory BookingDetailData.fromBookingDetailsMap(Map<String, dynamic> m) {
    final bookingId = _s(m['bookingId']);
    final id = _s(m['_id']);
    final ref = bookingId.isNotEmpty ? bookingId : id;

    final pickup = _placeName(m['source']);
    final drop = _placeName(m['destination']);
    final typeRaw = _s(m['bookingType']);

    DateTime? travelLocal;
    final td = _s(m['travelDate']);
    if (td.isNotEmpty) {
      try {
        travelLocal = DateTime.parse(td).toLocal();
      } catch (_) {}
    }

    double? dist;
    final tdKm = m['travelDistance'];
    if (tdKm is num) dist = tdKm.toDouble();

    String cur = 'USD';
    num amt = 0;
    final pd = m['priceDetails'];
    if (pd is Map) {
      final pm = Map<String, dynamic>.from(pd);
      cur = _s(pm['currency']).isNotEmpty ? _s(pm['currency']) : 'USD';
      final a = pm['amount'];
      if (a is num) amt = a;
    }

    String vehicle = '—';
    final vd = m['vehicleDetails'];
    if (vd is Map) {
      final vm = Map<String, dynamic>.from(vd);
      vehicle = _s(vm['categoryType'] ?? vm['vehicleName']);
    }

    int pax = 1;
    final pc = m['passenger'];
    if (pc is int) {
      pax = pc;
    } else if (pc is num) {
      pax = pc.toInt();
    }

    String invNo = _s(
      m['invoiceNumber'] ??
          m['invoiceNo'] ??
          m['invoiceRef'] ??
          m['invoice_id'] ??
          m['invoiceNumberRef'],
    );
    final invObj = m['invoice'];
    if (invNo.isEmpty && invObj is Map) {
      final im = Map<String, dynamic>.from(invObj);
      invNo = _s(im['invoiceNumber'] ?? im['number'] ?? im['id'] ?? im['ref']);
    }

    String bCompany = _s(m['companyName'] ?? m['company_name']);
    final cObj = m['company'];
    if (bCompany.isEmpty && cObj is Map) {
      final cm = Map<String, dynamic>.from(cObj);
      bCompany = _s(cm['companyName'] ?? cm['name']);
    }

    String paxName = '—';
    String paxEmail = '—';
    String phoneDisplay = '—';
    String refNum = '—';
    String special = '—';
    String? flightNo;
    String emergencyLine = '';
    final pxd = m['passengerDetails'];
    if (pxd is Map) {
      final px = Map<String, dynamic>.from(pxd);
      emergencyLine = _emergencyContactLine(px);
      final first = _s(px['firstName']);
      final last = _s(px['lastName']);
      final full = '$first $last'.trim();
      paxName = full.isNotEmpty ? full : _s(px['email']);
      paxEmail = _s(px['email']);
      final code = _s(px['code']);
      final phone = _s(px['phone']);
      phoneDisplay = [code, phone].where((e) => e.isNotEmpty).join(' ');
      if (phoneDisplay.isEmpty) phoneDisplay = '—';
      refNum = _s(px['referenceNumber']);
      if (refNum.isEmpty) refNum = '—';
      special = _s(px['specialRequest']);
      if (special.isEmpty) special = '—';
      final fn = _s(px['flightNumber']);
      flightNo = fn.isNotEmpty ? fn : null;
    }

    String bookedBy = _s(m['userName']);
    final user = m['user'];
    if (user is Map) {
      final um = Map<String, dynamic>.from(user);
      final em = _s(um['email']);
      if (em.isNotEmpty) bookedBy = em;
    }
    if (bookedBy.isEmpty) bookedBy = '—';

    DateTime? created;
    final ca = _s(m['createdAt']);
    if (ca.isNotEmpty) {
      try {
        created = DateTime.parse(ca).toLocal();
      } catch (_) {}
    }

    return BookingDetailData(
      bookingId: ref.isNotEmpty ? ref : '—',
      bookingStatus:
          _s(m['bookingStatus']).isNotEmpty ? _s(m['bookingStatus']) : '—',
      paymentStatus:
          _s(m['paymentStatus']).isNotEmpty ? _s(m['paymentStatus']) : '—',
      sourcePlace: pickup.isNotEmpty ? pickup : '—',
      destinationPlace: drop.isNotEmpty ? drop : '—',
      travelTime: _s(m['travelTime']),
      travelDateLocal: travelLocal,
      duration: _s(m['duration']),
      travelDistanceKm: dist,
      bookingTypeRaw: typeRaw,
      vehicleCategory: vehicle.isNotEmpty ? vehicle : '—',
      priceCurrency: cur,
      priceAmount: amt,
      passengerCount: pax < 1 ? 1 : pax,
      paxName: paxName,
      paxEmail: paxEmail.isNotEmpty ? paxEmail : '—',
      paxPhoneDisplay: phoneDisplay,
      bookedBy: bookedBy,
      createdAt: created,
      referenceNumber: refNum,
      specialRequest: special,
      flightNumber: flightNo,
      invoiceNumber: invNo.isNotEmpty ? invNo : null,
      bookingCompanyName: bCompany.isNotEmpty ? bCompany : null,
      emergencyContactMail: emergencyLine,
    );
  }
}
