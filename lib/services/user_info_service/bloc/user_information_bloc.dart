import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/services/user_info_service/user_information_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInformationBloc extends Bloc<UserInformationEvent, UserInformationState> {
  final UserInformationRepository userInformationRepository;

  UserInformationBloc({required this.userInformationRepository}) : super(UserInformationInitial()) {
    on<UserInformationLoadDetails>(_onLoadUserDetails);
  }

  Future<void> _onLoadUserDetails(
    UserInformationLoadDetails event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(UserInformationLoading());
    
    try {
      final response = await userInformationRepository.getUserDetails(accessToken: event.accessToken ?? "");
      
      if (response.success && response.data != null) {
        emit(UserInformationLoaded(response.data!, response));
      } else {
        emit(UserInformationError(response.message));
      }
    } catch (e) {
      emit(UserInformationError('Network error: $e'));
    }
  }
}
