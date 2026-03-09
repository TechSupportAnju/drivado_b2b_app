import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupDetails extends SignupEvent {
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? address;
  final String? mobile;
  final String? email;

  const SignupDetails({
    this.firstName,
    this.lastName,
    this.companyName,
    this.address,
    this.mobile,
    this.email,
  });

  List<Object?> get props => [firstName, lastName, companyName, address, mobile, email];
}

class SignupReset extends SignupEvent {}