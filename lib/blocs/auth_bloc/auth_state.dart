part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitState extends AuthState {
  const AuthInitState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthLoadedState extends AuthState {
  const AuthLoadedState();
}

class LoginSuccessState extends AuthState {
  const LoginSuccessState();
}

class RegisterSuccessState extends AuthState {
  final String name;
  final String email;

  const RegisterSuccessState({required this.name, required this.email});
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState(this.error);
}

class ForgotPasswordState extends AuthState {
  final String email;

  const ForgotPasswordState({required this.email});
}

class ChangePasswordState extends AuthState{
  const ChangePasswordState();
}