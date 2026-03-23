import 'package:drivado_b2b_app/models/user_info_model.dart';

abstract class UserInformationState {}

class UserInformationInitial extends UserInformationState {}

class UserInformationLoading extends UserInformationState {}

class UserInformationLoaded extends UserInformationState {
  final UserData userData;
  final UserInformationModel<UserData> response;

  UserInformationLoaded(this.userData, this.response);
}

class UserInformationError extends UserInformationState {
  final String message;
  UserInformationError(this.message);
}