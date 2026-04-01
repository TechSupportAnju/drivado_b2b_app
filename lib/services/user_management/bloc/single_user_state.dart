import 'package:drivado_b2b_app/models/single_user_models.dart';
import 'package:drivado_b2b_app/models/single_user_response.dart';
import 'package:equatable/equatable.dart';

abstract class SingleUserState extends Equatable {
  const SingleUserState();

  @override
  List<Object?> get props => [];
}

class SingleUserInitial extends SingleUserState {}

class SingleUserLoading extends SingleUserState {}

class SingleUserLoaded extends SingleUserState {
  final SingleUserResponse response;
  final SingleUserDetail detail;

  const SingleUserLoaded({
    required this.response,
    required this.detail,
  });

  @override
  List<Object?> get props => [response.success, response.message, detail];
}

class SingleUserFailure extends SingleUserState {
  final String message;

  const SingleUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
