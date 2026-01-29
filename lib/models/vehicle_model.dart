import 'dart:convert';

class NewOnewayVehicleWithPrice {
  final String id;
  final String vehicleName;
  final String vehicleType;
  final String description;
  final double price;
  final String image;
  final String vehicleId;
  final String unit;
  final int passengerCount;
  final int luggageCount;
  final double? priceInUSD;
  final String? currencyInUSD;

  NewOnewayVehicleWithPrice({
    required this.id,
    required this.vehicleName,
    required this.vehicleType,
    required this.description,
    required this.price,
    required this.image,
    required this.vehicleId,
    required this.unit,
    required this.passengerCount,
    required this.luggageCount,
    this.priceInUSD,
    this.currencyInUSD,
  });

  factory NewOnewayVehicleWithPrice.fromJson(Map<String, dynamic> json) {
    return NewOnewayVehicleWithPrice(
      id: _asString(json['id']),
      vehicleName: _asString(json['vehicleName']),
      vehicleType: _asString(json['vehicleType']),
      description: _asString(json['description']),
      price: _asDouble(json['price']),
      image: _asString(json['image']),
      vehicleId: _asString(json['vehicleId']),
      unit: _asString(json['unit']),
      passengerCount:
      _asInt(json['passengeCount'] ?? json['passengerCount']),
      luggageCount: _asInt(json['luggageCount']),
      priceInUSD: json.containsKey('priceInUSD')
          ? _asDouble(json['priceInUSD'], fallback: 0.0)
          : null,
      currencyInUSD: json['currencyInUSD']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'vehicleName': vehicleName,
    'vehicleType': vehicleType,
    'description': description,
    'price': price,
    'image': image,
    'vehicleId': vehicleId,
    'unit': unit,
    'passengerCount': passengerCount,
    'luggageCount': luggageCount,
    'priceInUSD': priceInUSD,
    'currencyInUSD': currencyInUSD,
  };
}



double _asDouble(dynamic v, {double fallback = 0.0}) {
  if (v == null) return fallback;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? fallback;
  return fallback;
}

int _asInt(dynamic v, {int fallback = 0}) {
  if (v == null) return fallback;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

String _asString(dynamic v, {String fallback = ''}) {
  if (v == null) return fallback;
  return v.toString();
}

double? _extractKm(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  if (v is String) {
    final m = RegExp(r'([0-9]+(?:\.[0-9]+)?)').firstMatch(v);
    return (m != null) ? double.tryParse(m.group(1)!) : null;
  }
  return null;
}
