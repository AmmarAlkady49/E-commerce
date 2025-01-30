part of 'auth_cubit.dart';

class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class CreatingAccoutSuccess extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthErrorVerification extends AuthState {
  AuthErrorVerification();
}

final class LoggedOut extends AuthState {}

final class LoggingOut extends AuthState {}

final class LogoutError extends AuthState {
  final String message;
  LogoutError(this.message);
}

final class SigningWithGoogle extends AuthState {}

final class SigningWithGoogleSuccess extends AuthState {}

final class SigningWithGoogleError extends AuthState {
  final String message;
  SigningWithGoogleError(this.message);
}

final class updatingPassword extends AuthState {}

final class PasswordUpdated extends AuthState {}

final class PasswordUpdateError extends AuthState {
  final String message;
  PasswordUpdateError(this.message);
}
