import 'dart:developer';

import 'package:drivado_b2b_app/services/user_management/bloc/single_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_state.dart';
import 'package:drivado_b2b_app/services/user_management/single_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleUserBloc extends Bloc<SingleUserEvent, SingleUserState> {
  final SingleUserRepository repository;

  SingleUserBloc({required this.repository}) : super(SingleUserInitial()) {
    on<SingleUserFetchRequested>(_onFetch);
    on<SingleUserReset>(_onReset);
  }

  void _onReset(SingleUserReset event, Emitter<SingleUserState> emit) {
    emit(SingleUserInitial());
  }

  Future<void> _onFetch(
    SingleUserFetchRequested event,
    Emitter<SingleUserState> emit,
  ) async {
    final userId = event.userId.trim();
    if (userId.isEmpty) {
      emit(const SingleUserFailure('Missing user id.'));
      return;
    }
    if (event.accessToken.trim().isEmpty) {
      emit(const SingleUserFailure('Not signed in.'));
      return;
    }

    emit(SingleUserLoading());
    try {
      log('SingleUserBloc: fetch userId=$userId');
      final response = await repository.getSingleUser(
        userId: userId,
        accessToken: event.accessToken,
      );

      final detail = response.detail;
      if (detail == null) {
        final msg = response.message.trim();
        emit(SingleUserFailure(
          msg.isNotEmpty ? msg : 'Could not read user from response.',
        ));
        return;
      }

      emit(SingleUserLoaded(response: response, detail: detail));
    } catch (e) {
      emit(SingleUserFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
