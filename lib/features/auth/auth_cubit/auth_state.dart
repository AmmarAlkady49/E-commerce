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

final class SigningWithGoogleSuccess extends AuthState {
  final Map<String, dynamic> data;
  SigningWithGoogleSuccess(this.data);
}

final class SigningWithGoogleError extends AuthState {
  final String message;
  SigningWithGoogleError(this.message);
}

final class OTPCodeSending extends AuthState {}

final class OTPCodeSent extends AuthState {}

final class OTPCodeSendingError extends AuthState {
  final String message;
  OTPCodeSendingError(this.message);
}

final class VerifyEmailLoading extends AuthState {}

final class VerifyEmailSuccess extends AuthState {}

final class VerifyOTPCodeSuccess extends AuthState {}

final class VerifyEmailError extends AuthState {
  final String message;
  VerifyEmailError(this.message);
}

final class UpdateingPassword extends AuthState {
  UpdateingPassword();
}

final class UpdatePasswordSuccess extends AuthState {
  UpdatePasswordSuccess();
}

final class UpdatePasswordError extends AuthState {
  final String message;
  UpdatePasswordError({required this.message});
}

final class ResendOTPCodeLoading extends AuthState {
  ResendOTPCodeLoading();
}

final class ResendOTPCodeSuccess extends AuthState {
  ResendOTPCodeSuccess();
}

final class ResendOTPCodeError extends AuthState {
  final String message;
  ResendOTPCodeError(this.message);
}
