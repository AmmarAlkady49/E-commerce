import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';

abstract class FavoritesServices {
  Future<void> addFavorite(String userId, ProductResponse productId);
  Future<void> removeFavorite(String userId, ProductResponse productId);
  Future<List<ProductResponse>> getFavorites(String userId);
}

class FavoritesServicesImpl implements FavoritesServices {
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<void> addFavorite(String userId, ProductResponse productId) async {
    return await _firestoreServices.setData(
        path: ApiPathes.favoriteProduct(userId, productId.id!),
        data: productId.toMap());
  }

  @override
  Future<void> removeFavorite(String userId, ProductResponse productId) {
    return _firestoreServices.deleteData(
        path: ApiPathes.favoriteProduct(userId, productId.id!));
  }

  @override
  Future<List<ProductResponse>> getFavorites(String userId) async {
    return await _firestoreServices.getCollection(
      path: ApiPathes.favoriteProducts(userId),
      builder: (data, documentId) => ProductResponse.fromMap(data),
    );
  }
}
