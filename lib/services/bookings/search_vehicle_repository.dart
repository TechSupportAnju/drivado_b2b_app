import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchVehicleRequest {
  final String date;
  final String km;
  final String userId;
  final String time;
  final String sourceLatLng;
  final String destinationLatLng;
  final String currency;

  const SearchVehicleRequest({
    required this.date,
    required this.km,
    required this.userId,
    required this.time,
    required this.sourceLatLng,
    required this.destinationLatLng,
    required this.currency,
  });

  Map<String, String> toQueryParameters() {
    return {
      'date': date,
      'km': km,
      'userId': userId,
      'time': time,
      'sourceLatLng': sourceLatLng,
      'destinationLatLng': destinationLatLng,
      'currency': currency,
    };
  }
}

class SearchVehicleResult {
  final List<Map<String, dynamic>> vehicles;
  final String bookingSearchId;

  const SearchVehicleResult({
    required this.vehicles,
    required this.bookingSearchId,
  });
}

class SearchVehicleRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<SearchVehicleResult> showVehicleWithPrice(
    SearchVehicleRequest request,
  ) async {
    final uri = Uri.parse('$baseUrl/v1/vehicles/showVehicleWithPrice').replace(
      queryParameters: request.toQueryParameters(),
    );

    log('showVehicleWithPrice -> GET $uri');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to search vehicles (${response.statusCode})',
      );
    }

    final dynamic decoded = json.decode(response.body);
    final vehicles = _extractVehicles(decoded);
    final bookingSearchId = _extractSearchId(decoded);

    if (vehicles.isEmpty) {
      throw Exception('No vehicles found for the selected route.');
    }

    return SearchVehicleResult(
      vehicles: vehicles,
      bookingSearchId: bookingSearchId,
    );
  }

  List<Map<String, dynamic>> _extractVehicles(dynamic decoded) {
    if (decoded is List) {
      return decoded
          .whereType<Map>()
          .map((e) => _normalizeVehicleMap(Map<String, dynamic>.from(e)))
          .toList();
    }

    if (decoded is! Map) return const [];

    final root = Map<String, dynamic>.from(decoded);
    final directList = _firstVehicleList(root);
    if (directList.isNotEmpty) return directList;

    final collected = <Map<String, dynamic>>[];

    void walk(dynamic value) {
      if (value is List) {
        for (final item in value) {
          walk(item);
        }
        return;
      }
      if (value is Map) {
        final map = Map<String, dynamic>.from(value);
        if (_looksLikeVehicleMap(map)) {
          collected.add(_normalizeVehicleMap(map));
          return;
        }
        for (final entry in map.entries) {
          if (_vehicleListKeys.contains(entry.key) && entry.value is List) {
            collected.addAll(
              (entry.value as List)
                  .whereType<Map>()
                  .map((e) => _normalizeVehicleMap(Map<String, dynamic>.from(e))),
            );
          } else {
            walk(entry.value);
          }
        }
      }
    }

    walk(root);
    return collected;
  }

  List<Map<String, dynamic>> _firstVehicleList(Map<String, dynamic> root) {
    for (final key in _vehicleListKeys) {
      final value = root[key];
      if (value is List) {
        return value
            .whereType<Map>()
            .map((e) => _normalizeVehicleMap(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    return const [];
  }

  String _extractSearchId(dynamic decoded) {
    if (decoded is! Map) return '';

    final queue = <dynamic>[decoded];
    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      if (current is Map) {
        final map = Map<String, dynamic>.from(current);
        for (final key in const ['searchId', 'searchID', 'search_id', 'bookingSearchId']) {
          final value = map[key];
          if (value != null && value.toString().trim().isNotEmpty) {
            return value.toString().trim();
          }
        }
        queue.addAll(map.values);
      } else if (current is List) {
        queue.addAll(current);
      }
    }
    return '';
  }

  bool _looksLikeVehicleMap(Map<String, dynamic> map) {
    const interestingKeys = {
      'vehicleType',
      'vehicleName',
      'passengerCount',
      'luggageCount',
      'price',
      'image',
      'unit',
    };
    return map.keys.any(interestingKeys.contains);
  }

  Map<String, dynamic> _normalizeVehicleMap(Map<String, dynamic> raw) {
    final normalized = Map<String, dynamic>.from(raw);

    normalized['id'] = _pick(raw, const ['id', '_id', 'vehicleId']);
    normalized['vehicleId'] = _pick(raw, const ['vehicleId', 'id', '_id']);
    normalized['vehicleName'] = _pick(raw, const ['vehicleName', 'name', 'title']);
    normalized['vehicleType'] =
        _pick(raw, const ['vehicleType', 'vehicleClass', 'type', 'category']) ??
        normalized['vehicleName'] ??
        'Vehicle';
    normalized['description'] = _pick(
          raw,
          const ['description', 'vehicleDescription', 'details', 'about'],
        ) ??
        '';
    normalized['price'] = _pick(
          raw,
          const ['price', 'totalPrice', 'amount', 'fare', 'estimatedPrice'],
        ) ??
        '';
    normalized['image'] = _pick(
          raw,
          const ['image', 'vehicleImage', 'imageUrl', 'icon', 'photo'],
        ) ??
        '';
    normalized['unit'] = _pick(
          raw,
          const ['unit', 'currency', 'currencyCode', 'currencySymbol'],
        ) ??
        '';
    normalized['passengerCount'] = _pick(
          raw,
          const ['passengerCount', 'passengeCount', 'maxPassengers'],
        ) ??
        '';
    normalized['luggageCount'] = _pick(
          raw,
          const ['luggageCount', 'maxLuggage', 'bagCount'],
        ) ??
        '';
    normalized['distanceKm'] = _pick(
          raw,
          const ['distanceKm', 'distance', 'km'],
        ) ??
        '';
    normalized['duration'] = _pick(
          raw,
          const ['duration', 'durationInSeconds', 'travelTime'],
        ) ??
        '';

    return normalized;
  }

  String? _pick(Map<String, dynamic> raw, List<String> keys) {
    for (final key in keys) {
      final value = raw[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }
    return null;
  }
}

const Set<String> _vehicleListKeys = {
  'vehicles',
  'vehicleList',
  'vehicleWithPrice',
  'vehiclesWithPrice',
  'data',
  'result',
};
