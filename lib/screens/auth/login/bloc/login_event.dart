import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginDetails extends LoginEvent {
  final String? email;
  final String? password;

  const LoginDetails({
    this.email,
    this.password,
  });

  List<Object?> get props => [email, password];
}

class LoginReset extends LoginEvent {}