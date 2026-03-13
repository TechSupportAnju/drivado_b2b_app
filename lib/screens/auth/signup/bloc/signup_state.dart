import 'package:drivado_b2b_app/screens/auth/auth_models/signup_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupResponseModel SignupResponse;

  const SignupSuccess(this.SignupResponse);

  @override
  List<Object?> get props => [SignupResponse];
}

class SignupFailure extends SignupState {
  final String error;

  const SignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}
