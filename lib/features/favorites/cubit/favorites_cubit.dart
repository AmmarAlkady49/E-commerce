import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final FavoriteProductsServices _favoritesServices2 =
      FavoriteProductsServicesImpl();
  final secureStorage = SecureStorage();
  bool hasFetchedFavorites = false;
  List<FavoriteItemModel> _favoriteProducts = [];

  // get favorite products
  Future<void> getFavoriteProducts() async {
    if (hasFetchedFavorites) {
      log('🔥 getFavoriteProducts already called, skipping...');
      return;
    }

    emit(FavoriteProductsLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final favoriteProducts =
          await _favoritesServices2.getFavoriteProducts(userId);
      emit(FavoriteProductsLoaded(favoriteProducts: favoriteProducts));
      _favoriteProducts = favoriteProducts;
      hasFetchedFavorites = true;
    } catch (e) {
      log('Error getting favorite products: $e');
      emit(FavoriteProductsError(message: e.toString()));
    }
  }

  void searchFavoriteProducts(String query, BuildContext context) {
    final filteredProducts = _favoriteProducts.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(query.toLowerCase());
    }).toList();

    if (filteredProducts.isEmpty) {
      emit(SearchFavoriteProductEmpty(message: S.of(context).no_matching_products));
    } else {
      emit(FavoriteProductsLoaded(favoriteProducts: filteredProducts));
    }
  }

  Future<void> deleteFavoriteProduct(String productId) async {
    emit(FavoriteProductsLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      await _favoritesServices2.removeFavoriteProduct(userId, productId);
      hasFetchedFavorites = false;
      emit(UpdateFavoritePage());
    } catch (e) {
      log('Error deleting favorite product: $e');
      emit(FavoriteProductsError(message: e.toString()));
    }
  }

  // // add to favorite
  // Future<void> addToFavorite(String productId) async {
  //   emit(AddProductToFavoriteLoading(productId: productId));
  //   try {
  //     final user = await _profilePageServices.getUserData();
  //     final isFavorite = await _favoritesServices2.addFavoriteProduct(
  //         user.id!, productId.toString());
  //     if (isFavorite) {
  //       emit(AddProductToFavoriteLoaded(productId: productId));
  //     } else {
  //       emit(AddProductToFavoriteError(
  //           message: 'Product is already in favorite', productId: productId));
  //     }
  //   } catch (e) {
  //     emit(AddProductToFavoriteError(
  //         message: e.toString(), productId: productId));
  //   }
  // }
  // // add to cart
  // Future<void> addToCart(ProductItemModel product) async {
  //   emit(AddProductToCartLoading(productId: product.id!));
  //   try {
  //     final user = _authServices.getCurrentUser();
  //     final finalProduct = AddToCartModel(
  //         id: DateTime.now().toIso8601String(),
  //         quantity: 1,
  //         userPrice: (product.price! * 1),
  //         product: product);
  //     await _favoritesServices2.addToProduct(user!.uid, finalProduct);
  //     emit(AddProductToCartLoaded(productId: product.id!));
  //   } catch (e) {
  //     emit(
  //         AddProductToCartError(productId: product.id!, message: e.toString()));
  //   }
  // }

  // delete all Favorite Products
  Future<void> clearFavorites() async {
    emit(FavoriteProductsLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');

      final result = await _favoritesServices2.removeAllProducts(userId);
      if (result) {
        emit(FavoriteProductsLoaded(favoriteProducts: []));
        emit(UpdateFavoritePage());
        hasFetchedFavorites = false;
      } else {
        emit(FavoriteProductsError(message: 'Failed to clear favorites'));
      }
    } catch (e) {
      emit(FavoriteProductsError(message: e.toString()));
    }
  }

  // Future<void> setFavoriteItem(String productItemId) async {
  //   emit(SetFavoriteItemLoading(productId: productItemId));
  // try {
  //   final user =await _profilePageServices.getUserData();
  //   final getFavoriteProducts =
  //       await _favoritesServices2.getFavoriteProducts(user.id!);
  //   final isFavorite =
  //       getFavoriteProducts.any((product) => product.id == productItemId.id);
  //   if (isFavorite) {
  //     _favoritesServices.removeFavorite(user.uid, productItemId);
  //     emit(SetFavoriteItemLoaded(productId: productItemId.id!));
  //   } else {
  //     emit(SetFavoriteItemError(
  //         productId: productItemId.id!, message: 'Product is not in favorite'));
  //   }
  // } catch (e) {
  //   emit(SetFavoriteItemError(
  //       message: e.toString(), productId: productItemId.id!));
  // }
  // }

  // Future<void> setFavortie(String productId) async {
  //   emit(SetFavoriteLoading(productId: productId));
  //   try {
  //     final userId = await secureStorage.readSecureData('userId');

  //     final favoriteProducts =
  //         await _favoritesServices2.getFavoriteProducts(userId);
  //     final isFavorite = favoriteProducts.any(
  //       (element) => element.productId.toString() == productId,
  //     );
  //     if (isFavorite) {
  //       await _favoritesServices2.removeFavoriteProduct(userId, productId);
  //     } else {
  //       await _favoritesServices2.addFavoriteProduct(userId, productId);
  //     }
  //     emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: productId));
  //   } catch (e) {
  //     emit(SetFavoriteError(error: e.toString(), productId: productId));
  //   }
  // }
}
