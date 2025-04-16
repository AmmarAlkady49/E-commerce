import 'package:dio/dio.dart';

import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';

abstract class FavoriteProductsServices {
  Future<List<FavoriteItemModel>> getFavoriteProducts(String userId);
  Future<bool> addFavoriteProduct(String userId, String productId);
  Future<bool> removeFavoriteProduct(String userId, String productId);
  // Future<void> addToProduct(String userId, AddToCartModel product);
  Future<bool> removeAllProducts(String userId);
}

class FavoriteProductsServicesImpl implements FavoriteProductsServices {
  final aDio = Dio();
  @override
  Future<List<FavoriteItemModel>> getFavoriteProducts(String userId) async {
    try {
      final apiResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getWishlist}/${userId}w",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (apiResponse.statusCode == 200) {
        final items = apiResponse.data['items'];

        if (items is List) {
          return items
              .map((item) =>
                  FavoriteItemModel.fromMap(item as Map<String, dynamic>))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load favorite products: status ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load favorite products: $e');
    }
  }

  @override
  Future<bool> addFavoriteProduct(String userId, String productId) async {
    try {
      final apiResponse = await aDio.post(
          "${AppConstants.baseUrl}${AppConstants.addToWishlist}",
          data: {
            "productId": productId,
          },
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ),
          queryParameters: {
            "wishlistId": "${userId}w",
          });

      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 400) {
        return false;
      } else {
        throw Exception(
            'Failed to add favorite product: status ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add favorite product: $e');
    }
  }

  @override
  Future<bool> removeFavoriteProduct(String userId, String productId) async {
    try {
      final apiResponse = await aDio
          .delete("${AppConstants.baseUrl}${AppConstants.removeFromWishlist}",
              options: Options(
                validateStatus: (status) => status != null && status < 500,
              ),
              queryParameters: {
            "wishlistId": "${userId}w",
            "productId": productId,
          });

      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 400) {
        return false;
      } else {
        throw Exception(
            'Failed to remove favorite product: status ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to remove favorite product: $e');
    }
  }

  // @override
  // Future<void> addToProduct(String userId, AddToCartModel product) async {
  //   await _firestoreServices.setData(
  //       path: ApiPathes.cartItem(userId, product.id), data: product.toMap());
  // }

  @override
  Future<bool> removeAllProducts(String userId) async {
    final apiResponse = await aDio.delete(
      "${AppConstants.baseUrl}${AppConstants.clearWishlist}/${userId}w",
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (apiResponse.statusCode == 200) {
      return true;
    } else if (apiResponse.statusCode == 400) {
      return false;
    } else {
      throw Exception(
          'Failed to remove all favorite products: status ${apiResponse.statusCode}');
    }
  }
}
