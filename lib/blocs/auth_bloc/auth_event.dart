part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  RegisterEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class ChangePasswordEvent extends AuthEvent {
  final String email;
  final String oldPassword;
  final String password;

  ChangePasswordEvent({
    required this.email,
    required this.oldPassword,
    required this.password,
  });
}
