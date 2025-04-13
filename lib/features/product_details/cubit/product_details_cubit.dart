import 'dart:developer';

import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/product_details/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final ProductDetailsServices _productDetailsServices =
      ProductDetailsServicesImpl();
  final AuthServices authServices = AuthServicesImpl();

  int quantity = 1;
  // Future<void> setProductFavorite(ProductItemModel product) async {
  //   emit(SetProductFavoriteLoading(productId: product.id!));
  //   try {
  //     final currentUser = authServices.getCurrentUser();
  //     final favoriteProducts =
  //         await _productDetailsServices.getFavoriteProducts(currentUser!.uid);
  //     final isFavorite = favoriteProducts.any(
  //       (element) => element.id == product.id,
  //     );
  //     if (isFavorite) {
  //       await _productDetailsServices.deleteFavoriteProduct(
  //           currentUser.uid, product.id!);
  //     } else {
  //       await _productDetailsServices.addFavoriteProduct(
  //           currentUser.uid, product);
  //     }
  //     emit(SetProductFavoriteSuccess(
  //         isFavorite: !isFavorite, productId: product.id!));
  //   } catch (e) {
  //     emit(SetProductFavoriteError(
  //       message: e.toString(),
  //       productId: product.id!,
  //     ));
  //   }
  // }

  // Add To cart Items
  // Future<void> addToCart(ProductItemModel product) async {
  //   emit(ProductAddingToCart());
  //   final currentUser = authServices.getCurrentUser();
  //   try {
  //     final cartItem = AddToCartModel(
  //         id: DateTime.now().toIso8601String(),
  //         quantity: quantity,
  //         userPrice: product.price! * quantity,
  //         product: product);
  //     await _productDetailsServices.addToCart(currentUser!.uid, cartItem);
  //     emit(ProductAddedToCart());
  //   } catch (e) {
  //     emit(ProductAddedToCartError(message: e.toString()));
  //   }
  // }

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

  // Get Product Details
  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final product =
          await _productDetailsServices.getProductDetails(productId);
      log('ProductDetailsCubit getProductDetails product===============: ${product.price}');
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}
