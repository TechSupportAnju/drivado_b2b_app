import 'package:equatable/equatable.dart';

abstract class UserInformationEvent extends Equatable {
  const UserInformationEvent();

  @override
  List<Object?> get props => [];
}

class UserInformationLoadDetails extends UserInformationEvent {
  final String? accessToken;

  const UserInformationLoadDetails({this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}

