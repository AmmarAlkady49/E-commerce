import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final FavoritesCubit favoritesCubit;
  final HomeCubit homeCubit;
  GeneralCubit({required this.favoritesCubit, required this.homeCubit})
      : super(GeneralInitial());

  final secureStorage = SecureStorage();
  final FavoriteProductsServices _favoriteProductsServices =
      FavoriteProductsServicesImpl();

  Future<void> setFavortie(String productId) async {
    log("Setting favorite for product ID: $productId");
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
      homeCubit.hasFetchedRecommendedProducts = false;
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: productId));
      log("Favorite status for product ID $productId: ${!isFavorite}");
    } catch (e) {
      log("error in set favorite: ${e.toString()}");
      emit(SetFavoriteError(error: e.toString(), productId: productId));
    }
  }
}
