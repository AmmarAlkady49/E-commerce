part of 'address_cubit.dart';

class AddressState {}

final class AddressInitial extends AddressState {}

final class AddingNewAddress extends AddressState {}

final class AddNewAddressSucess extends AddressState {}

final class AddNewAddressError extends AddressState {
  final String message;
  AddNewAddressError({required this.message});
}

final class GettingAddresses extends AddressState {}

final class GetAddressesSucess extends AddressState {
  final List<AddressModel> addresses;
  GetAddressesSucess({required this.addresses});
}

final class GetAddressesError extends AddressState {
  final String message;
  GetAddressesError({required this.message});
}

final class DeletingAddress extends AddressState {}

final class DeleteAddressSucess extends AddressState {}

final class DeleteAddressError extends AddressState {
  final String message;
  DeleteAddressError({required this.message});
}

final class UpdateingAddress extends AddressState {}

final class UpdateAddressSucess extends AddressState {}

final class UpdateAddressError extends AddressState {
  final String message;
  UpdateAddressError({required this.message});
}
