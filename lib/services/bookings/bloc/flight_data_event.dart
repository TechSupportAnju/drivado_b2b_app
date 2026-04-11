import 'package:equatable/equatable.dart';

abstract class FlightDataEvent extends Equatable {
  const FlightDataEvent();

  @override
  List<Object?> get props => [];
}

class FlightDataRequested extends FlightDataEvent {
  final String flightNumber;
  final DateTime lookupDateLocal;

  const FlightDataRequested({
    required this.flightNumber,
    required this.lookupDateLocal,
  });

  @override
  List<Object?> get props => [flightNumber, lookupDateLocal];
}

class FlightDataReset extends FlightDataEvent {
  const FlightDataReset();
}
