import 'package:drivado_b2b_app/models/single_company_management_models.dart';
import 'package:drivado_b2b_app/models/single_company_response.dart';
import 'package:equatable/equatable.dart';

abstract class SingleCompanyState extends Equatable {
  const SingleCompanyState();

  @override
  List<Object?> get props => [];
}

class SingleCompanyInitial extends SingleCompanyState {}

class SingleCompanyLoading extends SingleCompanyState {}

class SingleCompanyLoaded extends SingleCompanyState {
  final SingleCompanyResponse response;
  final SingleCompanyManagementPayload management;

  const SingleCompanyLoaded({
    required this.response,
    required this.management,
  });

  @override
  List<Object?> get props => [response.success, response.message, management];
}

class SingleCompanyFailure extends SingleCompanyState {
  final String message;

  const SingleCompanyFailure(this.message);

  @override
  List<Object?> get props => [message];
}
