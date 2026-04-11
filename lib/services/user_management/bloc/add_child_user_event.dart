import 'package:equatable/equatable.dart';

abstract class AddChildUserEvent extends Equatable {
  const AddChildUserEvent();

  @override
  List<Object?> get props => [];
}

class AddChildUserSubmitted extends AddChildUserEvent {
  final String parentCompanyId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String mobile;

  const AddChildUserSubmitted({
    required this.parentCompanyId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobile,
  });

  @override
  List<Object?> get props => [
        parentCompanyId,
        firstName,
        lastName,
        userName,
        email,
        password,
        mobile,
      ];
}

class AddChildUserReset extends AddChildUserEvent {
  const AddChildUserReset();
}
