import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/features/cart/services/cart_services.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final FavoritesCubit favoritesCubit;
  CartCubit({required this.favoritesCubit}) : super(CartInitial());

  final _cartServices = CartServicesImpl();
  final secureStorage = SecureStorage();
  List<CartItemModel> cartItemsStored = [];
  bool hasFetchedCart = false;

  // get all cart items
  Future<void> getCartItems() async {
    if (hasFetchedCart) {
      log('🔥 getCartItems already called, skipping...');
      return;
    }
    emit(CartLoading());
    final String user = await secureStorage.readSecureData('userId');
    try {
      final cartItems = await _cartServices.getCartItems(user);
      log(cartItems.id.toString());
      emit(CartLoaded(cartItems));
      cartItemsStored = cartItems.items;
      hasFetchedCart = true;
    } on Exception catch (e) {
      emit(CartError(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(CartError(e.toString()));
    }
  }

  // delete product form cart
  Future<void> deleteProductFromCart(
      String productId, FavoritesCubit favoritesCubit) async {
    emit(CartItemDeleting(productId));
    final userId = await secureStorage.readSecureData('userId');
    try {
      log('Deleting product with ID: $productId from cart for user: $userId');
      await _cartServices.deleteProductFromCart(userId, productId);
      log('Product with ID: $productId deleted from cart for user: $userId');
      final favoriteProduct = favoritesCubit.favoriteProductsStored;
      final isInFavorites = favoriteProduct.any((favoriteItem) =>
          favoriteItem.productId.toString() == productId.toString());
      log('Product with ID: $productId is in favorites: $isInFavorites');
      if (isInFavorites) {
        favoritesCubit.hasFetchedFavorites = false;
        // favoritesCubit.favoriteProductsStored = favoriteProduct.map((item) {
        //   return item.copyWith(isAddedToCart: false);
        // }).toList();
      }

      emit(CartItemDeleted());
      hasFetchedCart = false;
    } catch (e) {
      log(e.toString());
      emit(CartItemDeletedError(e.toString()));
    }
  }

  // clear the cart items
  // Future<void> clearTheCart(FavoritesCubit favoritesCubit) async {
  Future<void> clearTheCart() async {
    emit(CartLoading());
    final userId = await secureStorage.readSecureData('userId');
    try {
      await _cartServices.deleteAllProductsFromCart(userId);
      final favoriteProducts = favoritesCubit.favoriteProductsStored;
      final hasCommonProduct = cartItemsStored.any((cartItem) =>
          favoriteProducts.any((favoriteItem) =>
              favoriteItem.productId.toString() ==
              cartItem.productId.toString()));

      if (hasCommonProduct) {
        favoritesCubit.hasFetchedFavorites = false;
      }

      emit(CartItemDeleted());
      hasFetchedCart = false;
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  // update product quantity
  Future<void> updateProductQuantity(
      CartItemModel cartItem, bool isIncrement) async {
    emit(CartItemUpdating(cartItem.productId.toString(), isIncrement));
    final userId = await secureStorage.readSecureData('userId');
    try {
      final newCartItem = isIncrement
          ? cartItem.copyWith(quantity: cartItem.quantity + 1)
          : cartItem.copyWith(quantity: cartItem.quantity - 1);
      await _cartServices.updateProductQuantity(
          userId, cartItem.productId.toString(), newCartItem.quantity);

      emit(CartItemUpdated(cartItem.quantity));
      hasFetchedCart = false;
    } catch (e) {
      emit(CartItemUpdatedError(e.toString()));
    }
  }
}
