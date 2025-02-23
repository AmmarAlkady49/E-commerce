import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/favorites_services.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final FavoritesServices _favoritesServices = FavoritesServicesImpl();
  final FavoriteProductsServices _favoritesServices2 =
      FavoriteProductsServicesImpl();
  final AuthServices _authServices = AuthServicesImpl();
  Future<void> setFavoriteItem(ProductItemModel productItem) async {
    emit(SetFavoriteItemLoading(productId: productItem.id!));
    try {
      final user = _authServices.getCurrentUser();
      final getFavoriteProducts =
          await _favoritesServices.getFavorites(user!.uid);
      final isFavorite =
          getFavoriteProducts.any((product) => product.id == productItem.id);
      if (isFavorite) {
        _favoritesServices.removeFavorite(user.uid, productItem);
        emit(SetFavoriteItemLoaded(productId: productItem.id!));
      } else {
        emit(SetFavoriteItemError(
            productId: productItem.id!, message: 'Product is not in favorite'));
      }
    } catch (e) {
      emit(SetFavoriteItemError(
          message: e.toString(), productId: productItem.id!));
    }
  }

  // get favorite products
  Future<void> getFavoriteProducts() async {
    emit(FavoriteProductsLoading());
    try {
      final user = _authServices.getCurrentUser();
      final favoriteProducts = await _favoritesServices.getFavorites(user!.uid);
      emit(FavoriteProductsLoaded(favoriteProducts: favoriteProducts));
    } catch (e) {
      emit(FavoriteProductsError(message: e.toString()));
    }
  }

  // add to cart
  Future<void> addToCart(ProductItemModel product) async {
    emit(AddProductToCartLoading(productId: product.id!));
    try {
      final user = _authServices.getCurrentUser();
      final finalProduct = AddToCartModel(
          id: DateTime.now().toIso8601String(),
          quantity: 1,
          userPrice: (product.price! * 1),
          product: product);
      await _favoritesServices2.addToProduct(user!.uid, finalProduct);
      emit(AddProductToCartLoaded(productId: product.id!));
    } catch (e) {
      emit(
          AddProductToCartError(productId: product.id!, message: e.toString()));
    }
  }
}
