import 'package:equatable/equatable.dart';

abstract class SingleUserEvent extends Equatable {
  const SingleUserEvent();

  @override
  List<Object?> get props => [];
}

class SingleUserFetchRequested extends SingleUserEvent {
  final String userId;
  final String accessToken;

  const SingleUserFetchRequested({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}

class SingleUserReset extends SingleUserEvent {
  const SingleUserReset();
}
