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
  });

  static String _s(dynamic v) => v?.toString().trim() ?? '';

  static String _placeName(dynamic loc) {
    if (loc is Map) {
      var s = _s(loc['placename'] ?? loc['placeName']);
      s = s.replaceAll(RegExp(r',?\s*undefined', caseSensitive: false), '').trim();
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
      final km = (raw - raw.round()).abs() < 1e-9
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

  String get passengerCountLabel =>
      '$passengerCount Pax';

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

    String paxName = '—';
    String paxEmail = '—';
    String phoneDisplay = '—';
    String refNum = '—';
    String special = '—';
    final pxd = m['passengerDetails'];
    if (pxd is Map) {
      final px = Map<String, dynamic>.from(pxd);
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
      bookingStatus: _s(m['bookingStatus']).isNotEmpty ? _s(m['bookingStatus']) : '—',
      paymentStatus: _s(m['paymentStatus']).isNotEmpty ? _s(m['paymentStatus']) : '—',
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
    );
  }
}
