import 'package:equatable/equatable.dart';

abstract class SingleCompanyEvent extends Equatable {
  const SingleCompanyEvent();

  @override
  List<Object?> get props => [];
}

/// Loads company for [id] (company id from profile, or user id as fallback).
class SingleCompanyFetchRequested extends SingleCompanyEvent {
  final String id;
  final String accessToken;

  const SingleCompanyFetchRequested({
    required this.id,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [id, accessToken];
}

class SingleCompanyReset extends SingleCompanyEvent {
  const SingleCompanyReset();
}
