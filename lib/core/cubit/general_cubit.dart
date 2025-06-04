import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final FavoritesCubit favoritesCubit;
  final HomeCubit homeCubit;
  GeneralCubit({required this.favoritesCubit, required this.homeCubit})
      : super(GeneralInitial());

  final FavoriteProductsServices _favoritesServices2 =
      FavoriteProductsServicesImpl();
  final secureStorage = SecureStorage();

  Future<void> deleteFavoriteProduct(
      String productId, BuildContext context) async {
    emit(FavoriteProductsLoadingGeneral());
    try {
      final userId = await secureStorage.readSecureData('userId');
      await _favoritesServices2.removeFavoriteProduct(userId, productId);
      favoritesCubit.hasFetchedFavorites = false;
      bool shouldRefetchRecommendedProducts = homeCubit
          .chachingRecommendedProductsIds
          .contains(int.parse(productId));
      if (shouldRefetchRecommendedProducts) {
        homeCubit.hasFetchedRecommendedProducts = false;
      }

      favoritesCubit.getFavoriteProducts(context);
      emit(UpdateFavoritePageGeneral());
    } catch (e) {
      log('Error deleting favorite product: $e');
      emit(FavoriteProductsErrorGeneral(message: e.toString()));
    }
  }

  // delete all Favorite Products
  Future<void> clearFavorites(BuildContext context) async {
    emit(FavoriteProductsLoadingGeneral());
    try {
      final userId = await secureStorage.readSecureData('userId');

      final result = await _favoritesServices2.removeAllProducts(userId);

      if (result) {
        emit(FavoriteProductsLoadedGeneral(favoriteProducts: []));
        // emit(UpdateFavoritePage());
        favoritesCubit.hasFetchedFavorites = false;
        homeCubit.hasFetchedRecommendedProducts = false;
        favoritesCubit.getFavoriteProducts(context);
      } else {
        emit(
            FavoriteProductsErrorGeneral(message: 'Failed to clear favorites'));
      }
    } on Exception catch (e) {
      log('Error clearing favorite products: $e');
      emit(FavoriteProductsErrorGeneral(message: e.toString()));
    } catch (e) {
      log('Error clearing favorite products: $e');
      emit(FavoriteProductsErrorGeneral(message: e.toString()));
    }
  }
}
