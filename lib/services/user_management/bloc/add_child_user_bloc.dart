import 'package:drivado_b2b_app/models/add_child_user_request.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_management/add_child_user_repository.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/add_child_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/add_child_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChildUserBloc extends Bloc<AddChildUserEvent, AddChildUserState> {
  final AddChildUserRepository repository;

  AddChildUserBloc({required this.repository}) : super(AddChildUserInitial()) {
    on<AddChildUserSubmitted>(_onSubmitted);
    on<AddChildUserReset>(_onReset);
  }

  void _onReset(AddChildUserReset event, Emitter<AddChildUserState> emit) {
    emit(AddChildUserInitial());
  }

  Future<void> _onSubmitted(
    AddChildUserSubmitted event,
    Emitter<AddChildUserState> emit,
  ) async {
    emit(AddChildUserSubmitting());
    try {
      final token = await AuthService.getAccessToken();
      if (token == null || token.trim().isEmpty) {
        emit(const AddChildUserFailure('Please log in again.'));
        return;
      }

      final parentId = event.parentCompanyId.trim();
      if (parentId.isEmpty) {
        emit(const AddChildUserFailure(
          'Company id missing from profile. Please refresh and try again.',
        ));
        return;
      }

      await repository.addChildUser(
        parentCompanyId: parentId,
        accessToken: token.trim(),
        request: AddChildUserRequest(
          firstName: event.firstName.trim(),
          lastName: event.lastName.trim(),
          userName: event.userName.trim(),
          email: event.email.trim(),
          password: event.password,
          mobile: event.mobile.trim(),
        ),
      );

      emit(AddChildUserSuccess());
    } catch (e) {
      emit(AddChildUserFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
