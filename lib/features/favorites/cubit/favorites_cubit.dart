import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/services/cart_services.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  // final CartCubit cartCubit;
  FavoritesCubit() : super(FavoritesInitial());

  final FavoriteProductsServices _favoritesServices2 =
      FavoriteProductsServicesImpl();
  final secureStorage = SecureStorage();
  bool hasFetchedFavorites = false;
  List<FavoriteItemModel> favoriteProductsStored = [];
  final CartServices cartServices = CartServicesImpl();

  // get favorite products
  Future<void> getFavoriteProducts(BuildContext context) async {
    if (hasFetchedFavorites) {
      log('🔥 getFavoriteProducts already called, skipping...');
      return;
    }

    emit(FavoriteProductsLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final favoriteProducts =
          await _favoritesServices2.getFavoriteProducts(userId);
      final cartProducts = await cartServices.getCartItems(userId);

      final finalFavoriteProducts = favoriteProducts.map((favoriteProduct) {
        final isInCart = cartProducts.items.any((cartItem) =>
            cartItem.productId.toString() ==
            favoriteProduct.productId.toString());
        return favoriteProduct.copyWith(isAddedToCart: isInCart);
      }).toList();
      favoriteProductsStored = favoriteProducts;
      hasFetchedFavorites = true;
      emit(FavoriteProductsLoaded(favoriteProducts: finalFavoriteProducts));
    } on Exception catch (e) {
      if (e.toString().contains('429')) {
        emit(FavoriteProductsError(message: S.of(context).too_many_requests));
      } else {
        emit(FavoriteProductsError(message: e.toString()));
      }
    } catch (e) {
      log('Error getting favorite products: $e');
      emit(FavoriteProductsError(message: e.toString()));
    }
  }

  void searchFavoriteProducts(String query, BuildContext context) {
    final filteredProducts = favoriteProductsStored.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(query.toLowerCase());
    }).toList();

    if (filteredProducts.isEmpty) {
      emit(SearchFavoriteProductEmpty(
          message: S.of(context).no_matching_products));
    } else {
      emit(FavoriteProductsLoaded(favoriteProducts: filteredProducts));
      //filteredProducts.clear();
      hasFetchedFavorites = false;
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

  // add to cart
  Future<void> addToCart(
      String productId, int quantity, CartCubit cartCubit) async {
    emit(AddProductToCartLoading(productId: productId));
    try {
      final userId = await secureStorage.readSecureData('userId');

      await cartServices.addProductToCart(
          userId, int.parse(productId), quantity);
      log('Product added to cart: $productId');
      emit(AddProductToCartLoaded(productId: productId));
      cartCubit.hasFetchedCart = false;
      hasFetchedFavorites = false;
    } catch (e) {
      log('Error adding product to cart: $e');
      emit(AddProductToCartError(productId: productId, message: e.toString()));
    }
  }

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
    } on Exception catch (e) {
      log('Error clearing favorite products: $e');
      emit(FavoriteProductsError(message: e.toString()));
    } catch (e) {
      log('Error clearing favorite products: $e');
      emit(FavoriteProductsError(message: e.toString()));
    }
  }
}
