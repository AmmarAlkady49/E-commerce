import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/home/model/category_model.dart';
import 'package:e_commerce_graduation/features/home/model/parameter_request.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';

abstract class HomePageServices {
  Future<List<ProductResponse>> getAllProducts(
      ParameterRequest parameterRequest);
  Future<List<CategoryModel>> getAllCategories();
  Future<List<int>> getRecommendedProductsID(String userId);
  Future<List<ProductResponse>> getRecommendedProducts(List<int> productIds);

  // Future<bool> addFavoriteProduct(String userId, int productId);
  // Future<void> deleteFavoriteProduct(String userId, String productId);
  // Future<List<ProductItemModel>> getFavoriteProducts(String userId);
}

class HomePageServicesImpl implements HomePageServices {
  final aDio = Dio();

  // get all products
  @override
  Future<List<ProductResponse>> getAllProducts(
      ParameterRequest parameterRequest) async {
    try {
      final response = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getAllProducts}",
        queryParameters: parameterRequest.toMap(),
      );

      final responseProducts = response.data['data'] as List<dynamic>;
      if (response.statusCode == 200) {
        log(responseProducts.toString());
        return (responseProducts)
            .map((item) => ProductResponse.fromMap(item))
            .toList();
      } else if (response.statusCode == 500) {
        log("Server error: ${response.statusCode}");
        throw Exception('Server error: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        log("Unauthorized: ${response.statusCode}");
        throw Exception('Unauthorized: ${response.statusCode}');
      } else if (response.statusCode == 404) {
        log("Not found: ${response.statusCode}");
        throw Exception('Not found: ${response.statusCode}');
      } else if (response.statusCode == 400) {
        log("Bad request: ${response.statusCode}");
        throw Exception('Bad request: ${response.statusCode}');
      } else if (response.statusCode == 403) {
        log("Forbidden: ${response.statusCode}");
        throw Exception('Forbidden: ${response.statusCode}');
      } else if (response.statusCode == 409) {
        log("Conflict: ${response.statusCode}");
        throw Exception('Conflict: ${response.statusCode}');
      } else if (response.statusCode == 429) {
        log("Too many requests: ${response.statusCode}");
        throw Exception('Too many requests: ${response.statusCode}');
      } else if (response.statusCode == 503) {
        log("Service unavailable: ${response.statusCode}");
        throw Exception('Service unavailable: ${response.statusCode}');
      } else {
        log("Error from home page services: ${response.statusCode}");
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<int>> getRecommendedProductsID(String userId) async {
    try {
      final response = await aDio.get(
        "https://mohamed-essam0-recommendation-engine-api.hf.space/recommend/",
        queryParameters: {'user_id': userId},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return List<int>.from(response.data);
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests: (${response.statusCode})');
      } else {
        throw Exception('Failed to load recommended products');
      }
    } catch (e) {
      log("Error in getRecommendedProducts: $e");
      throw Exception('Failed to load recommended products');
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final apiResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getAllCategories}",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ));

    if (apiResponse.statusCode == 200) {
      return (apiResponse.data as List) 
          .map((item) => CategoryModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } else if (apiResponse.statusCode == 429) {
      throw Exception('Too many requests: (${apiResponse.statusCode})');
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<List<ProductResponse>> getRecommendedProducts(
      List<int> productIds) async {
    try {
      final response = await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.getRecommendedProducts}",
        data: productIds,
        options: Options(
          contentType: Headers.jsonContentType, // ✅ Set Content-Type properly
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final responseProducts = response.data as List<dynamic>;

        return responseProducts
            .map((item) => ProductResponse.fromMap(item))
            .toList();
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests: (${response.statusCode})');
      } else {
        throw Exception('Failed to load recommended products');
      }
    } catch (e) {
      log("Error in getRecommendedProducts: $e");
      throw Exception('Failed to load recommended products');
    }
  }
}
