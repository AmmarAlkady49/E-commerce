import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/home/model/parameter_request.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';

abstract class HomePageServices {
  Future<List<ProductResponse>> getAllProducts();
  // Future<bool> addFavoriteProduct(String userId, int productId);
  // Future<void> deleteFavoriteProduct(String userId, String productId);
  // Future<List<ProductItemModel>> getFavoriteProducts(String userId);
}

class HomePageServicesImpl implements HomePageServices {
  final aDio = Dio();

  // get all products
  @override
  Future<List<ProductResponse>> getAllProducts() async {
    try {
      final response = await aDio.get(
          "${AppConstants.baseUrl}${AppConstants.getAllProducts}",
          queryParameters:
              ParameterRequest(pagenum: 1, Maxpagesize: 15, pagesize: 15)
                  .toMap());
      final responseProducts = response.data['data'] as List<dynamic>;
      if (response.statusCode == 200) {
        log(responseProducts.toString());
        return (responseProducts)
            .map((item) => ProductResponse.fromMap(item))
            .toList();
      } else {
        log("Error from home page services: ${response.statusCode}");
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<bool> addFavoriteProduct(String userId, int productId) async {
  //   try {
  //     final response = await aDio
  //         .post("${AppConstants.baseUrl}${AppConstants.addToWishlist}", data: {
  //       "productId": productId,
  //     }, queryParameters: {
  //       "wishlistId": userId,
  //     });
  //     if (response.statusCode == 200) {
  //       log("Product added to favorites successfully");
  //       return true;
  //     } else {
  //       log("Error from home page services: ${response.statusCode}");
  //       throw Exception('Failed to add product to favorites');
  //     }
  //   } catch (e) {
  //     log("Error from home page services: $e");
  //     throw Exception('Failed to add product to favorites: $e');
  //   }
  // }

  // @override
  // Future<void> deleteFavoriteProduct(String userId, String productId) async {
  //   await _firestoreServices.deleteData(
  //       path: ApiPathes.favoriteProduct(userId, productId));
  // }

  // @override
  // Future<List<ProductItemModel>> getFavoriteProducts(String userId) async {
  //   return await _firestoreServices.getCollection<ProductItemModel>(
  //     path: ApiPathes.favoriteProducts(userId),
  //     builder: (data, documentId) => ProductItemModel.fromMap(data),
  //   );
  // }
}
