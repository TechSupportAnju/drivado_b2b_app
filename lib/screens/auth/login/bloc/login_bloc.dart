import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/login/repositories/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginCubit({required this.repository}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final response = await repository.loginWithPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void reset() => emit(LoginInitial());
}