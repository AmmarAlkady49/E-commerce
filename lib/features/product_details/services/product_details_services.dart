import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';

abstract class ProductDetailsServices {
  Future<ProductResponse> getProductDetails(int productId);
  Future<void> addProductReview(int productId, String review, int rating);
}

class ProductDetailsServicesImpl extends ProductDetailsServices {
  final aDio = Dio();
  final SecureStorage secureStorage = SecureStorage();

  @override
  Future<ProductResponse> getProductDetails(int productId) async {
    try {
      final selectedProduct = await aDio.get(
          "${AppConstants.baseUrl}${AppConstants.getProductById}$productId");
      log('message: ${selectedProduct.data}');
      if (selectedProduct.statusCode == 200) {
        return ProductResponse.fromMap(selectedProduct.data);
      } else if (selectedProduct.statusCode == 400) {
        throw Exception('Bad request: ${selectedProduct.statusCode}');
      } else {
        throw Exception('Failed to load product detailssssss');
      }
    } catch (e) {
      throw Exception('Failed to load product detailseeeee');
    }
  }

  @override
  Future<void> addProductReview(
      int productId, String review, int rating) async {
    try {
      await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.addProductReview}",
        data: {
          "productId": productId,
          "rating": rating,
          "reviewText": review,
        },
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to add product review: $e');
    }
  }
}
