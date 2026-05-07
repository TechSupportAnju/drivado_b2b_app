import 'dart:convert';
import 'package:drivado_b2b_app/models/place_suggestion/place_suggestion.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<PlaceSuggestion>> fetchPlaces(String query) async {
  final baseUrl = dotenv.env['BASE_URL'] ?? 'https://testapi.drivado.com/api';
  final uri = Uri.parse(
    '$baseUrl/v2/booking/autocomplete',
  ).replace(queryParameters: {'input': query.trim()});
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data is List) {
      return data
          .map<PlaceSuggestion>((item) => PlaceSuggestion.fromJson(item))
          .toList();
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    throw Exception('Failed to fetch places');
  }
}

class PlaceDetailsDateTime {
  final String dateText;
  final String timeText;
  final String coordinateText;

  const PlaceDetailsDateTime({
    required this.dateText,
    required this.timeText,
    required this.coordinateText,
  });
}

Future<PlaceDetailsDateTime?> fetchPlaceDetailsDateTime({
  required String placeId,
  required String description,
  bool? isPickup,
}) async {
  final baseUrl = dotenv.env['BASE_URL'] ?? 'https://testapi.drivado.com/api';
  final q = <String, String>{
    'place_id': placeId.trim(),
    'description': description.trim(),
  };
  if (isPickup != null) {
    q['isPickup'] = isPickup.toString();
  }
  final uri = Uri.parse('$baseUrl/v2/booking/placeDetails').replace(
    queryParameters: q,
  );

  final response = await http.get(uri);
  if (response.statusCode != 200) return null;

  dynamic decoded;
  try {
    decoded = json.decode(response.body);
  } catch (_) {
    return null;
  }

  final allMaps = <Map<String, dynamic>>[];
  void collect(dynamic value) {
    if (value is Map) {
      final m = Map<String, dynamic>.from(value);
      allMaps.add(m);
      for (final v in m.values) {
        collect(v);
      }
    } else if (value is List) {
      for (final e in value) {
        collect(e);
      }
    }
  }

  collect(decoded);

  String pick(List<String> keys) {
    for (final m in allMaps) {
      for (final key in keys) {
        final v = m[key];
        if (v != null && v.toString().trim().isNotEmpty) {
          return v.toString().trim();
        }
      }
    }
    return '';
  }

  String dateRaw = pick([
    'pickupDate',
    'travelDate',
    'date',
    'localDate',
    'pickup_date',
  ]);
  String timeRaw = pick([
    'pickupTime',
    'travelTime',
    'time',
    'localTime',
    'pickup_time',
  ]);

  final dateTimeRaw = pick([
    'pickupDateTime',
    'dateTime',
    'pickup_datetime',
    'datetime',
    'localDateTime',
  ]);

  if (dateTimeRaw.isNotEmpty) {
    final dt = DateTime.tryParse(dateTimeRaw);
    if (dt != null) {
      dateRaw = DateFormat('dd-MMM-yyyy').format(dt.toLocal());
      timeRaw = DateFormat('HH:mm').format(dt.toLocal());
    }
  }

  if (dateRaw.isNotEmpty && dateRaw.contains('T')) {
    final dt = DateTime.tryParse(dateRaw);
    if (dt != null) {
      dateRaw = DateFormat('dd-MMM-yyyy').format(dt.toLocal());
    }
  } else if (dateRaw.isNotEmpty) {
    final dt = DateTime.tryParse(dateRaw);
    if (dt != null) {
      dateRaw = DateFormat('dd-MMM-yyyy').format(dt);
    }
  }

  if (timeRaw.isNotEmpty && timeRaw.contains('T')) {
    final dt = DateTime.tryParse(timeRaw);
    if (dt != null) {
      timeRaw = DateFormat('HH:mm').format(dt.toLocal());
    }
  } else if (timeRaw.contains(':')) {
    final parts = timeRaw.split(':');
    if (parts.length >= 2) {
      timeRaw = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    }
  }

  String latRaw = pick([
    'lat',
    'latitude',
    'pickupLat',
    'pickupLatitude',
    'originLat',
    'originLatitude',
  ]);
  String lngRaw = pick([
    'lng',
    'lon',
    'longitude',
    'pickupLng',
    'pickupLongitude',
    'originLng',
    'originLongitude',
  ]);

  final locationText = pick(['location', 'coordinates', 'latlng']);
  if ((latRaw.isEmpty || lngRaw.isEmpty) && locationText.contains(',')) {
    final parts = locationText.split(',');
    if (parts.length >= 2) {
      latRaw = parts[0].trim();
      lngRaw = parts[1].trim();
    }
  }
  final coordinateText =
      latRaw.isNotEmpty && lngRaw.isNotEmpty ? '$latRaw,$lngRaw' : '';

  if (dateRaw.isEmpty && timeRaw.isEmpty && coordinateText.isEmpty) {
    return null;
  }
  return PlaceDetailsDateTime(
    dateText: dateRaw,
    timeText: timeRaw,
    coordinateText: coordinateText,
  );
}

class RouteDistanceDetails {
  final double km;
  final String duration;

  const RouteDistanceDetails({
    required this.km,
    required this.duration,
  });
}

Future<RouteDistanceDetails?> fetchDistanceDetails({
  required String origin,
  required String destination,
}) async {
  final baseUrl = dotenv.env['BASE_URL'] ?? 'https://testapi.drivado.com/api';
  final uri = Uri.parse('$baseUrl/v2/booking/checkDistance').replace(
    queryParameters: {
      'origin': origin.trim(),
      'destination': destination.trim(),
    },
  );

  final response = await http.get(uri);
  if (response.statusCode != 200) return null;

  dynamic decoded;
  try {
    decoded = json.decode(response.body);
  } catch (_) {
    return null;
  }

  if (decoded is! Map) return null;

  final map = Map<String, dynamic>.from(decoded);
  final rawKm = map['km'];
  final rawDuration = map['duration'];

  final km =
      rawKm is num
          ? rawKm.toDouble()
          : double.tryParse(rawKm?.toString().trim() ?? '');
  if (km == null) return null;

  return RouteDistanceDetails(
    km: km,
    duration: rawDuration?.toString().trim() ?? '',
  );
}
