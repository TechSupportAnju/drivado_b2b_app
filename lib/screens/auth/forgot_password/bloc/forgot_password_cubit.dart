import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:drivado_b2b_app/screens/auth/forgot_password/repositories/forgot_password_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository repository;

  ForgotPasswordCubit({required this.repository})
      : super(ForgotPasswordState.initial());

  Future<void> sendResetEmail(String email) async {
    emit(state.copyWith(isLoading: true, error: null, emailSent: false));
    try {
      await repository.requestReset(email: email);
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          emailSent: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString().replaceFirst('Exception: ', ''),
          emailSent: false,
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, passwordChanged: false));
    try {
      await repository.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          passwordChanged: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString().replaceFirst('Exception: ', ''),
          passwordChanged: false,
        ),
      );
    }
  }

  void clearFlags() {
    emit(
      state.copyWith(
        error: null,
        emailSent: false,
        passwordChanged: false,
      ),
    );
  }
}

