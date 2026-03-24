import 'package:intl/intl.dart';

/// Row model for manage-booking list — mapped from `getAllBookingV2` `paginatedResults` items.
class BookingListItem {
  final String id;
  final String paxName;
  final String status;
  final String bookingRef;
  final String dateLabel;
  final String timeLabel;
  final String pickup;
  final String dropoff;
  final String bookingType;
  final String durationLabel;
  final String driverName;
  final String driverPhone;
  final String vehicleLabel;
  final String priceLabel;

  const BookingListItem({
    required this.id,
    required this.paxName,
    required this.status,
    required this.bookingRef,
    required this.dateLabel,
    required this.timeLabel,
    required this.pickup,
    required this.dropoff,
    required this.bookingType,
    required this.durationLabel,
    required this.driverName,
    required this.driverPhone,
    required this.vehicleLabel,
    required this.priceLabel,
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

  static String _formatTravelDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat('EEE, MMM d').format(dt);
    } catch (_) {
      final parts = iso.split('T');
      return parts.isNotEmpty ? parts.first : iso;
    }
  }

  static String _paxName(Map<String, dynamic> json) {
    final pd = json['passengerDetails'];
    if (pd is Map) {
      final m = Map<String, dynamic>.from(pd);
      final first = _s(m['firstName']);
      final last = _s(m['lastName']);
      final full = '$first $last'.trim();
      if (full.isNotEmpty) return full;
    }
    return _s(json['bookingFor']);
  }

  static String _bookingTypeLabel(String raw) {
    final u = raw.toUpperCase();
    if (u == 'ONEWAY') return 'Oneway';
    if (u == 'HOURLY') return 'Hourly';
    if (u == 'RETURN' || u == 'ROUNDTRIP') return 'Return';
    return raw.isEmpty ? '—' : raw;
  }

  static String _priceLabel(Map<String, dynamic> json) {
    final pd = json['priceDetails'];
    if (pd is Map) {
      final m = Map<String, dynamic>.from(pd);
      final cur = _s(m['currency']);
      final amt = m['amount'];
      if (amt != null) {
        final n = amt is num ? amt.toString() : _s(amt);
        if (cur.isNotEmpty) return '$cur $n';
        return n;
      }
    }
    return '—';
  }

  static String _vehicleLabel(Map<String, dynamic> json) {
    final vd = json['vehicleDetails'];
    if (vd is Map) {
      final m = Map<String, dynamic>.from(vd);
      return _s(m['categoryType'] ?? m['vehicleName']);
    }
    return '—';
  }

  static String _formatKm(num n) {
    final d = n.toDouble();
    if ((d - d.round()).abs() < 1e-9) return '${d.round()}';
    return d.toStringAsFixed(1);
  }

  static String _durationLine(Map<String, dynamic> json) {
    final dur = _s(json['duration']);
    final dist = json['travelDistance'];
    if (dist is num) {
      final km = _formatKm(dist);
      if (dur.isNotEmpty) return '$km km | $dur';
      return '$km km';
    }
    return dur.isNotEmpty ? dur : '—';
  }

  /// One element from `allBookingDetails[].paginatedResults[]`.
  factory BookingListItem.fromJson(Map<String, dynamic> json) {
    final id = _s(json['_id']);
    final bookingId = _s(json['bookingId']);
    final ref = bookingId.isNotEmpty ? bookingId : id;

    final pickup = _placeName(json['source']);
    final dropRaw = _placeName(json['destination']);
    final typeRaw = _s(json['bookingType']);
    final dropoff = dropRaw.isNotEmpty
        ? dropRaw
        : (typeRaw.toUpperCase() == 'HOURLY' ? 'Hourly service' : '—');

    final pax = _paxName(json);
    final status = _s(json['bookingStatus']);

    final travelDate = _s(json['travelDate']);
    final dateLabel = travelDate.isNotEmpty
        ? _formatTravelDate(travelDate)
        : '—';
    final timeLabel = _s(json['travelTime']);

    return BookingListItem(
      id: id.isNotEmpty ? id : ref,
      paxName: pax.isNotEmpty ? pax : '—',
      status: status.isNotEmpty ? status : '—',
      bookingRef: ref.isNotEmpty ? ref : '—',
      dateLabel: dateLabel,
      timeLabel: timeLabel.isNotEmpty ? timeLabel : '—',
      pickup: pickup.isNotEmpty ? pickup : '—',
      dropoff: dropoff,
      bookingType: _bookingTypeLabel(typeRaw),
      durationLabel: _durationLine(json),
      driverName: 'Not Found',
      driverPhone: 'Not Found',
      vehicleLabel: _vehicleLabel(json),
      priceLabel: _priceLabel(json),
    );
  }
}
