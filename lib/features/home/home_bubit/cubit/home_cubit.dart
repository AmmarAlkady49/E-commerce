import 'dart:developer';

import 'package:e_commerce_graduation/core/models/user_data.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/favorites_services.dart';
import 'package:e_commerce_graduation/features/home/services/home_page_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomePageServices homeServices = HomePageServicesImpl();

  // // Get UserData
  // Future<UserData?> getUserData() async {
  //   emit(HomeAppBarLoading());
  //   try {
  //     final userData = await homeServices.getUserData();
  //     emit(HomeAppBarLoaded(userData));

  //     return userData;
  //   } catch (e) {
  //     emit(HomeAppBarError(e.toString()));
  //   }
  //   return null;
  // }

  // Get All Products
  Future<void> getAllProducts() async {
    // final favoriteProducts =
    //     await homeServices.getFavoriteProducts(currentUser.uid);

    emit(LoadingHomeProducts());
    debugPrint("===================Loading==================");

    try {
      final products = await homeServices.getAllProducts();
      // final List<ProductItemModel> finalProducts = products.map((product) {
      //   final isFavorite = favoriteProducts.any(
      //     (item) => item.id == product.id,
      //   );
      //   return product.copyWith(isFavorite: isFavorite);
      // }).toList();
      // emit(LoadedHomeProducts(finalProducts));
      emit(LoadedHomeProducts(products));
      debugPrint("===================Loaded==================");
    } catch (e) {
      emit(ErrorHomeProducts(e.toString()));
      debugPrint("===================error==================");

      log(e.toString());
    }
  }

  // Future<void> setFavortie(ProductItemModel product) async {
  //   emit(SetFavoriteLoading(productId: product.id!));
  //   try {
  //     final currentUser = await homeServices.getUserData();
  //     final favoriteProducts =
  //         await homeServices.getFavoriteProducts(currentUser.uid);
  //     final isFavorite = favoriteProducts.any(
  //       (element) => element.id == product.id,
  //     );
  //     if (isFavorite) {
  //       await homeServices.deleteFavoriteProduct(currentUser.uid, product.id!);
  //     } else {
  //       await homeServices.addFavoriteProduct(currentUser.uid, product);
  //     }
  //     emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id!));
  //   } catch (e) {
  //     emit(SetFavoriteError(error: e.toString(), productId: product.id!));
  //   }
  // }
}
