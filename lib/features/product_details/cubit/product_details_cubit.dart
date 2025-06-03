import 'dart:developer';

import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/services/cart_services.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final CartCubit cartCubit;
  final FavoritesCubit favoritesCubit;
  final HomeCubit homeCubit;
  ProductDetailsCubit(
      {required this.cartCubit,
      required this.favoritesCubit,
      required this.homeCubit})
      : super(ProductDetailsInitial());

  final ProductDetailsServices _productDetailsServices =
      ProductDetailsServicesImpl();
  final SecureStorage secureStorage = SecureStorage();
  final CartServices _cartServices = CartServicesImpl();
  final FavoriteProductsServices _favoritesServices2 =
      FavoriteProductsServicesImpl();
  int quantity = 1;

  // set product to favorite
  Future<void> setProductFavorite(String productId) async {
    emit(SetProductFavoriteLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final favoriteProducts =
          await _favoritesServices2.getFavoriteProducts(userId);
      final isFavorite = favoriteProducts.any(
        (element) => element.productId.toString() == productId,
      );
      if (isFavorite) {
        await _favoritesServices2.removeFavoriteProduct(userId, productId);
      } else {
        await _favoritesServices2.addFavoriteProduct(userId, productId);
      }
      homeCubit.hasFetchedRecommendedProducts = false;
      emit(SetProductFavoriteSuccess(
          isFavorite: !isFavorite, productId: productId));
      favoritesCubit.hasFetchedFavorites = false;
    } catch (e) {
      emit(SetProductFavoriteError(
        message: e.toString(),
        productId: productId,
      ));
    }
  }

  void increaseQuantity() {
    if (quantity < 10) {
      quantity++;
    }
    emit(ProductDetailsQuantityChanged(quantity: quantity));
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(ProductDetailsQuantityChanged(quantity: quantity));
    }
  }

  // // Get Product Details
  // Future<void> getProductDetails(int productId) async {
  //   emit(ProductDetailsLoading());
  //   try {
  //     final product =
  //         await _productDetailsServices.getProductDetails(productId);

  //     emit(ProductDetailsLoaded(product: product));
  //   } catch (e) {
  //     emit(ProductDetailsError(message: e.toString()));
  //   }
  // }
  // Get Product Details
  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    try {
      final productDetails =
          await _productDetailsServices.getProductDetails(productId);

      final userId = await secureStorage.readSecureData('userId');
      final favoriteProducts =
          await _favoritesServices2.getFavoriteProducts(userId);
      final isFavorite = favoriteProducts.any(
        (element) => element.productId.toString() == productId.toString(),
      );

      // Update product.isFavorite manually
      final updatedProduct = productDetails.copyWith(isFavorite: isFavorite);

      emit(ProductDetailsLoaded(product: updatedProduct));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }

  // add to cart
  Future<void> addToCart(String productId, int quantity) async {
    emit(ProductAddingToCart());
    final userId = await secureStorage.readSecureData('userId');
    try {
      await _cartServices.addProductToCart(
          userId, int.parse(productId), quantity);

      emit(ProductAddedToCart());
      cartCubit.hasFetchedCart = false;
      // hasFetchedFavorites = false;
    } catch (e) {
      log('Error adding product to cart: $e');
      emit(ProductAddedToCartError(message: e.toString()));
    }
  }
}
