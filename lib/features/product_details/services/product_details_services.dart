import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/product_details/models/product_reviews_model.dart';

abstract class ProductDetailsServices {
  Future<ProductResponse> getProductDetails(int productId);
  Future<void> addProductReview(int productId, String review, int rating);
  Future<List<ProductReviewsModel>> getProductReviews(int productId);
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

  @override
  Future<List<ProductReviewsModel>> getProductReviews(int productId) async {
    try {
      final response = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getProductReviews}/$productId",
        options: Options(
          headers: {
            "Authorization": "Bearer ${secureStorage.readSecureData('token')}",
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) =>
                ProductReviewsModel.fromMap(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 400) {
        throw Exception('Bad request: ${response.statusCode}');
      } else {
        throw Exception('Failed to get product reviews');
      }
    } catch (e) {
      throw Exception('Failed to get product reviews: $e');
    }
  }
}
