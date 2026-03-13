import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivado_b2b_app/screens/auth/signup/repositories/sign_up_repository.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository repository;

  SignupCubit({required this.repository}) : super(SignupInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String companyName,
    required String address,
    required String email,
    required String mobile,
  }) async {
    emit(SignupLoading());
    try {
      final response = await repository.SignupWithPassword(
        firstName: firstName,
        lastName: lastName,
        companyName: companyName,
        address: address,
        mobile: mobile,
        email: email,
      );
      emit(SignupSuccess(response));
    } catch (e) {
      emit(SignupFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void reset() => emit(SignupInitial());
}