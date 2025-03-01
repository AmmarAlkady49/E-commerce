part of 'favorites_cubit.dart';

class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class SetFavoriteItemLoading extends FavoritesState {
  final String productId;

  SetFavoriteItemLoading({required this.productId});
}

final class SetFavoriteItemLoaded extends FavoritesState {
  final String productId;

  SetFavoriteItemLoaded({required this.productId});
}

final class SetFavoriteItemError extends FavoritesState {
  final String message;
  final String productId;

  SetFavoriteItemError({required this.message, required this.productId});
}

final class FavoriteProductsLoading extends FavoritesState {}

final class UpdateFavoritePage extends FavoritesState {}

final class FavoriteProductsLoaded extends FavoritesState {
  final List<ProductItemModel> favoriteProducts;

  FavoriteProductsLoaded({required this.favoriteProducts});
}

final class FavoriteProductsError extends FavoritesState {
  final String message;

  FavoriteProductsError({required this.message});
}

final class AddProductToCartLoading extends FavoritesState {
  final String productId;

  AddProductToCartLoading({required this.productId});
}

final class AddProductToCartLoaded extends FavoritesState {
  final String productId;

  AddProductToCartLoaded({required this.productId});
}

final class AddProductToCartError extends FavoritesState {
  final String message;
  final String productId;

  AddProductToCartError({required this.message, required this.productId});
}
