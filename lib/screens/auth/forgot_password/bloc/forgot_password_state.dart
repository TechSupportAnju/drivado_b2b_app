import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool emailSent;
  final bool passwordChanged;

  const ForgotPasswordState({
    this.isLoading = false,
    this.error,
    this.emailSent = false,
    this.passwordChanged = false,
  });

  factory ForgotPasswordState.initial() => const ForgotPasswordState();

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? error,
    bool? emailSent,
    bool? passwordChanged,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      emailSent: emailSent ?? this.emailSent,
      passwordChanged: passwordChanged ?? this.passwordChanged,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, emailSent, passwordChanged];
}

