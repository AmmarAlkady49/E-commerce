import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/home/model/parameter_request.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';

abstract class HomePageServices {
  // Future<UserData> getUserData();
  Future<List<ProductResponse>> getAllProducts();
  // Future<void> addFavoriteProduct(String userId, ProductItemModel product);
  // Future<void> deleteFavoriteProduct(String userId, String productId);
  // Future<List<ProductItemModel>> getFavoriteProducts(String userId);
}

class HomePageServicesImpl implements HomePageServices {
  final aDio = Dio();

  //get user data
  // @override
  // Future<UserData> getUserData() async {
  //   final user = firebaseAuth.currentUser;
  //   final UserData userData = await _firestoreServices.getDocument(
  //     path: ApiPathes.users(user!.uid),
  //     builder: (data, documentID) {
  //       return UserData.fromMap(data);
  //     },
  //   );
  //   return userData;
  // }

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
  // Future<void> addFavoriteProduct(
  //     String userId, ProductItemModel product) async {
  //   await _firestoreServices.setData(
  //       path: ApiPathes.favoriteProduct(userId, product.id!),
  //       data: product.toMap());
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
