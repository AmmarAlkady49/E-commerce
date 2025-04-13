part of 'profile_cubit.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLogingOut extends ProfileState {}

final class ProfileLogedOut extends ProfileState {}

final class ProfileLogOutError extends ProfileState {
  final String message;

  ProfileLogOutError({required this.message});
}

final class UpdateingPassword extends ProfileState {}

final class UpdatedPassword extends ProfileState {}

final class UpdatePasswordError extends ProfileState {
  final String message;

  UpdatePasswordError({required this.message});
}

final class AccountPageLoading extends ProfileState {}
final class AccountPageUpdated extends ProfileState {}

final class AccountPageLoaded extends ProfileState {
  final String email;
  final String fName;
  final String lName;
  final String phone;
  final String gender;
  final String birthDate;

  AccountPageLoaded({
    required this.email,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.gender,
    required this.birthDate,
  });
}

final class AccountPageError extends ProfileState {
  final String message;

  AccountPageError({required this.message});
}
