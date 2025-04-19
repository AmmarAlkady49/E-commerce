import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/services/app_services.dart';
import 'package:e_commerce_graduation/features/address/models/address_model.dart';
import 'package:e_commerce_graduation/features/address/services/address_services.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final _profileAuthServices = ProfilePageServicesimpl();
  final _appServices = AppServicesImpl();
  final addressServices = AddressServicesImpl();
  final secureStorage = SecureStorage();

  // add new address
  Future<void> addNewAddress(
      {required String country,
      required String city,
      required String address,
      required String postalCode}) async {
    emit(AddingNewAddress());
    final userProfile = await _profileAuthServices.getUserData();
    try {
      final result = await _appServices.editAccountProfile(
        name: userProfile.name!,
        email: userProfile.email!,
        address: address,
        city: city,
        country: country,
        postalCode: postalCode,
        phoneNumber: userProfile.phoneNumber!,
        gender: userProfile.gender!,
        dateOfBirth: userProfile.dateOfBirth!,
      );
      if (result) {
        emit(AddNewAddressSucess());
      } else {
        emit(AddNewAddressError(message: "address not added successfully"));
      }
    } catch (e) {
      emit(AddNewAddressError(message: e.toString()));
    }
  }

  // get all addresses
  Future<void> getAllAddresses() async {
    emit(GettingAddresses());
    final userProfile = await _profileAuthServices.getUserData();
    try {
      final addresses = AddressModel(
        id: userProfile.id!,
        country: userProfile.country ?? "null",
        city: userProfile.city ?? "null",
        address: userProfile.address ?? "null",
        postalCode: userProfile.postalCode ?? "null",
      );

      emit(GetAddressesSucess(addresses: addresses));
    } catch (e) {
      emit(GetAddressesError(message: e.toString()));
      log("error: ${e.toString()}");
    }
  }

  // delete address
  Future<void> deleteAddress() async {
    emit(DeletingAddress());
    final userProfile = await _profileAuthServices.getUserData();

    try {
      // final userId = _authService.getCurrentUser()!.uid;
      // await addressServices.deleteAddress(userId, addressId);
      final result = await _appServices.editAccountProfile(
        name: userProfile.name!,
        email: userProfile.email!,
        address: "null",
        city: "null",
        country: "null",
        postalCode: "null",
        phoneNumber: userProfile.phoneNumber!,
        gender: userProfile.gender!,
        dateOfBirth: userProfile.dateOfBirth!,
      );
      if (result) {
        emit(DeleteAddressSucess());
      } else {
        emit(DeleteAddressError(message: "address not deleted successfully"));
      }
    } catch (e) {
      emit(DeleteAddressError(message: e.toString()));
    }
  }

  // update address
  // Future<void> updateAddress(AddressModel address) async {
  //   // emit(UpdateingAddress());
  //   try {
  //     final userId = _authService.getCurrentUser()!.uid;
  //     final addresses = await addressServices.getAddresses(userId);
  //     final oldAddress =
  //         addresses.firstWhere((element) => element.isDefault == true);
  //     oldAddress.copyWith(isDefault: false);

  //     await addressServices.unSelectAddress(userId, oldAddress);
  //     await addressServices.selectAddress(userId, address);
  //     emit(UpdateAddressSucess());
  //   } catch (e) {
  //     emit(UpdateAddressError(message: e.toString()));
  //   }
  // }
}
