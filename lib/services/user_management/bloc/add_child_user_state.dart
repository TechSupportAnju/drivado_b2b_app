import 'package:equatable/equatable.dart';

abstract class AddChildUserState extends Equatable {
  const AddChildUserState();

  @override
  List<Object?> get props => [];
}

class AddChildUserInitial extends AddChildUserState {}

class AddChildUserSubmitting extends AddChildUserState {}

class AddChildUserSuccess extends AddChildUserState {}

class AddChildUserFailure extends AddChildUserState {
  final String message;

  const AddChildUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
