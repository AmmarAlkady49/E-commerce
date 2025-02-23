import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/firestore_services.dart';
import 'package:e_commerce_graduation/core/utils/api_pathes.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';

abstract class ProductDetailsServices {
  Future<void> addFavoriteProduct(String userId, ProductItemModel product);
  Future<void> deleteFavoriteProduct(String userId, String productId);
  Future<List<ProductItemModel>> getFavoriteProducts(String userId);
  Future<void> addToCart(String userId, AddToCartModel cartItem);
  Future<ProductItemModel> getProductDetails(String productId);
}

class ProductDetailsServicesImpl extends ProductDetailsServices {
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  final aDio = Dio();
  @override
  Future<void> addFavoriteProduct(
      String userId, ProductItemModel product) async {
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
  Future<List<ProductItemModel>> getFavoriteProducts(String userId) async {
    return await _firestoreServices.getCollection<ProductItemModel>(
      path: ApiPathes.favoriteProducts(userId),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
  }

  @override
  Future<void> addToCart(String userId, AddToCartModel cartItem) async {
    await _firestoreServices.setData(
        path: ApiPathes.cartItem(userId, cartItem.id), data: cartItem.toMap());
  }

  @override
  Future<ProductItemModel> getProductDetails(String productId) async {
    try {
      final selectedProduct = await aDio.get(
          "${AppConstants.baseUrl}${AppConstants.productsPath}/$productId");
      if (selectedProduct.statusCode == 200) {
        return ProductItemModel.fromMap(selectedProduct.data);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('Failed to load product details');
    }
  }
}
