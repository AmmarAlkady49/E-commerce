import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';

abstract class ProductDetailsServices {
  Future<void> addFavoriteProduct(String userId, ProductResponse product);
  Future<void> deleteFavoriteProduct(String userId, String productId);
  Future<List<ProductResponse>> getFavoriteProducts(String userId);
}

class ProductDetailsServicesImpl extends ProductDetailsServices {
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  @override
  Future<void> addFavoriteProduct(
      String userId, ProductResponse product) async {
    await _firestoreServices.setData(
        path: ApiPathes.favoriteProduct(userId, product.id!),
        data: product.toMap());
  }

  @override
  Future<void> deleteFavoriteProduct(String userId, String productId) async {
    await _firestoreServices.deleteData(
        path: ApiPathes.favoriteProduct(userId, productId));
  }

  @override
  Future<List<ProductResponse>> getFavoriteProducts(String userId) async {
    return await _firestoreServices.getCollection<ProductResponse>(
      path: ApiPathes.favoriteProducts(userId),
      builder: (data, documentId) => ProductResponse.fromMap(data),
    );
  }
}
