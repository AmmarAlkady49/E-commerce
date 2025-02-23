import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';

abstract class FavoriteProductsServices {
  Future<List<ProductItemModel>> getFavoriteProducts(String userId);
  Future<void> addFavoriteProduct(String userId, ProductItemModel product);
  Future<void> removeFavoriteProduct(String userId, ProductItemModel product);
  Future<void> addToProduct(String userId, AddToCartModel product);
}

class FavoriteProductsServicesImpl implements FavoriteProductsServices {
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<List<ProductItemModel>> getFavoriteProducts(String userId) async {
    return await _firestoreServices.getCollection(
        path: ApiPathes.favoriteProducts(userId),
        builder: (data, documentId) => ProductItemModel.fromMap(data));
  }

  @override
  Future<void> addFavoriteProduct(
      String userId, ProductItemModel product) async {
    await _firestoreServices.setData(
        path: ApiPathes.favoriteProduct(userId, product.id!),
        data: product.toMap());
  }

  @override
  Future<void> removeFavoriteProduct(
      String userId, ProductItemModel product) async {
    await _firestoreServices.deleteData(
        path: ApiPathes.favoriteProduct(userId, product.id!));
  }

  @override
  Future<void> addToProduct(String userId, AddToCartModel product) async {
    await _firestoreServices.setData(
        path: ApiPathes.cartItem(userId, product.id), data: product.toMap());
  }
}
