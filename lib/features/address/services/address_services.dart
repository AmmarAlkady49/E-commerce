import 'package:e_commerce_graduation/core/utils/api_pathes.dart';
import 'package:e_commerce_graduation/features/address/models/address_model.dart';

abstract class AddressServices {
  // Future<void> addAddress(String userId, AddressModel address);
  // Future<List<AddressModel>> getAddresses(String userId);
  // Future<void> deleteAddress(String userId, String addressId);
  // Future<void> selectAddress(String userId, AddressModel address);
  // Future<void> unSelectAddress(String userId, AddressModel address);
}

class AddressServicesImpl implements AddressServices {
  // @override
  // Future<void> addAddress(String userId, AddressModel address) async {
  //   await _fireStoreServices.setData(
  //       path: ApiPathes.addressItem(userId, address.id), data: address.toMap());
  // }

  // @override
  // Future<List<AddressModel>> getAddresses(String userId) async {
  //   return await _fireStoreServices.getCollection(
  //       path: ApiPathes.addresses(userId),
  //       builder: (data, documentId) => AddressModel.fromMap(data));
  // }

  // @override
  // Future<void> deleteAddress(String userId, String addressId) async {
  //   await _fireStoreServices.deleteData(
  //       path: ApiPathes.addressItem(userId, addressId));
  // }

  // @override
  // Future<void> selectAddress(String userId, AddressModel address) async {
  //   await _fireStoreServices.setData(
  //       path: ApiPathes.addressItem(userId, address.id),
  //       data: address.copyWith(isDefault: true).toMap());
  // }

  // @override
  // Future<void> unSelectAddress(String userId, AddressModel address) async{
  //   await _fireStoreServices.setData(
  //       path: ApiPathes.addressItem(userId, address.id),
  //       data: address.copyWith(isDefault: false).toMap(),
  //   );
  // }
}
