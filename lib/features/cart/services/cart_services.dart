import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> getCartItems(String userId);
  Future<void> deleteProductFromCart(String userId, String productId);
  Future<void> deleteAllProductsFromCart(String userId);
  Future<void> updateProductQuantity(String userId, String productId, AddToCartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final _fireStoreService = FirestoreServices.instance;
  @override
  Future<List<AddToCartModel>> getCartItems(String userId) async {
    return await _fireStoreService.getCollection(
        path: ApiPathes.cartItems(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data));
  }

  @override
  Future<void> deleteProductFromCart(String userId, String productId) async {
    await _fireStoreService.deleteData(
        path: ApiPathes.cartItem(userId, productId));
  }

  @override
  Future<void> deleteAllProductsFromCart(String userId) async {
    await _fireStoreService.deleteCollection(path: ApiPathes.cartItems(userId));
  }

  @override
  Future<void> updateProductQuantity(String userId, String productId, AddToCartModel cartItem) async {
    await _fireStoreService.setData(
      path: ApiPathes.cartItem(userId, productId),
      data: cartItem.toMap(),
    );
  }
}
