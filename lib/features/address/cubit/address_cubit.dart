import 'package:e_commerce_graduation/features/address/models/address_model.dart';
import 'package:e_commerce_graduation/features/address/services/address_services.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final _authService = AuthServicesImpl();
  final addressServices = AddressServicesImpl();

  // add new address
  Future<void> addNewAddress(AddressModel address) async {
    emit(AddingNewAddress());
    final userId = _authService.getCurrentUser()!.uid;
    try {
      await addressServices.addAddress(userId, address);
      emit(AddNewAddressSucess());
    } catch (e) {
      emit(AddNewAddressError(message: e.toString()));
    }
  }

  // get all addresses
  Future<void> getAllAddresses() async {
    emit(GettingAddresses());
    final userId = _authService.getCurrentUser()!.uid;
    try {
      final addresses = await addressServices.getAddresses(userId);
      if (addresses.isNotEmpty &&
          addresses.every((element) => element.isDefault == false)) {
        addresses.first = addresses.first.copyWith(isDefault: true);
        await addressServices.selectAddress(userId, addresses.first);
      }
      emit(GetAddressesSucess(addresses: addresses));
    } catch (e) {
      emit(GetAddressesError(message: e.toString()));
    }
  }

  // delete address
  Future<void> deleteAddress(String addressId) async {
    emit(DeletingAddress());
    try {
      final userId = _authService.getCurrentUser()!.uid;
      await addressServices.deleteAddress(userId, addressId);
      emit(DeleteAddressSucess());
    } catch (e) {
      emit(DeleteAddressError(message: e.toString()));
    }
  }

  // update address
  Future<void> updateAddress(AddressModel address) async {
    // emit(UpdateingAddress());
    try {
      final userId = _authService.getCurrentUser()!.uid;
      final addresses = await addressServices.getAddresses(userId);
      final oldAddress =
          addresses.firstWhere((element) => element.isDefault == true);
      oldAddress.copyWith(isDefault: false);

      await addressServices.unSelectAddress(userId, oldAddress);
      await addressServices.selectAddress(userId, address);
      emit(UpdateAddressSucess());
    } catch (e) {
      emit(UpdateAddressError(message: e.toString()));
    }
  }
}
