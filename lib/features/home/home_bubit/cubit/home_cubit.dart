import 'dart:developer';

import 'package:e_commerce_graduation/core/models/customer_data.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/features/home/services/home_page_services.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FavoritesCubit favoritesCubit;
  HomeCubit({required this.favoritesCubit}) : super(HomeInitial());

  final HomePageServices homeServices = HomePageServicesImpl();
  final ProfilePageServices profileServices = ProfilePageServicesimpl();
  final FavoriteProductsServices _favoriteProductsServices =
      FavoriteProductsServicesImpl();
  final secureStorage = SecureStorage();

  // Get UserData
  Future<CustomerData> getUserData() async {
    emit(HomeAppBarLoading());
    try {
      final userName = await secureStorage.readSecureData('name');

      final firstName = userName.split(' ')[0];
      final capitalizedName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
      emit(HomeAppBarLoaded(capitalizedName));
      return userName;
    } catch (e) {
      emit(HomeAppBarError(e.toString()));
    }
    log("failed to get user data");
    throw Exception('Failed to fetch user data');
  }

  // Get All Products
  Future<void> getAllProducts() async {
    emit(LoadingHomeProducts());

    try {
      final userId = await secureStorage.readSecureData('userId');
      final products = await homeServices.getAllProducts();
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final List<ProductResponse> finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();
      emit(LoadedHomeProducts(finalProducts));
    } catch (e) {
      emit(ErrorHomeProducts(e.toString()));

      log(e.toString());
    }
  }

  Future<void> setFavortie(String productId) async {
    emit(SetFavoriteLoading(productId: productId));
    try {
      final userId = await secureStorage.readSecureData('userId');

      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final isFavorite = favoriteProducts.any(
        (element) => element.productId.toString() == productId,
      );
      if (isFavorite) {
        await _favoriteProductsServices.removeFavoriteProduct(
            userId, productId);
        favoritesCubit.hasFetchedFavorites = false;
      } else {
        await _favoriteProductsServices.addFavoriteProduct(userId, productId);
        favoritesCubit.hasFetchedFavorites = false;
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: productId));
    } catch (e) {
      emit(SetFavoriteError(error: e.toString(), productId: productId));
    }
  }
}
