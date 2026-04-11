import 'package:equatable/equatable.dart';

abstract class FlightDataState extends Equatable {
  const FlightDataState();

  @override
  List<Object?> get props => [];
}

class FlightDataInitial extends FlightDataState {
  const FlightDataInitial();
}

class FlightDataLoading extends FlightDataState {
  const FlightDataLoading();
}

class FlightDataLoaded extends FlightDataState {
  final Map<String, dynamic> data;

  const FlightDataLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class FlightDataFailure extends FlightDataState {
  final String message;

  const FlightDataFailure(this.message);

  @override
  List<Object?> get props => [message];
}
