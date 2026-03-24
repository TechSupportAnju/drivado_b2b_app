import 'dart:developer';

import 'package:drivado_b2b_app/services/user_management/bloc/single_company_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_state.dart';
import 'package:drivado_b2b_app/services/user_management/single_company_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleCompanyBloc extends Bloc<SingleCompanyEvent, SingleCompanyState> {
  final SingleCompanyRepository repository;

  SingleCompanyBloc({required this.repository}) : super(SingleCompanyInitial()) {
    on<SingleCompanyFetchRequested>(_onFetch);
    on<SingleCompanyReset>(_onReset);
  }

  void _onReset(SingleCompanyReset event, Emitter<SingleCompanyState> emit) {
    emit(SingleCompanyInitial());
  }

  Future<void> _onFetch(
    SingleCompanyFetchRequested event,
    Emitter<SingleCompanyState> emit,
  ) async {
    final id = event.id.trim();
    if (id.isEmpty) {
      emit(const SingleCompanyFailure('Missing company or user id from profile.'));
      return;
    }
    if (event.accessToken.trim().isEmpty) {
      emit(const SingleCompanyFailure('Not signed in.'));
      return;
    }

    emit(SingleCompanyLoading());
    try {
      log('SingleCompanyBloc: fetch id=$id');
      final response = await repository.getSingleCompany(
        id: id,
        accessToken: event.accessToken,
      );

      final payload = response.managementPayload;
      if (payload == null) {
        if (!response.success) {
          emit(SingleCompanyFailure(
            response.message.isNotEmpty
                ? response.message
                : 'Company not found.',
          ));
        } else {
          emit(const SingleCompanyFailure(
            'No singleCompanyDetails in response.',
          ));
        }
        return;
      }

      emit(SingleCompanyLoaded(
        response: response,
        management: payload,
      ));
    } catch (e) {
      emit(SingleCompanyFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
