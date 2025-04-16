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

final class UnFavoriteProductSuccess extends FavoritesState {
  final String productId;

  UnFavoriteProductSuccess({required this.productId});
}

final class UpdateFavoritePage extends FavoritesState {}

final class FavoriteProductsLoaded extends FavoritesState {
  final List<FavoriteItemModel> favoriteProducts;

  FavoriteProductsLoaded({required this.favoriteProducts});
}

final class SearchFavoriteProductEmpty extends FavoritesState {
  final String message;

  SearchFavoriteProductEmpty({required this.message});
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


final class SetFavoriteLoading extends FavoritesState {
  final String productId;

  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends FavoritesState {
  final bool isFavorite;
  final String productId;

  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}

final class SetFavoriteError extends FavoritesState {
  final String error;
  final String productId;

  SetFavoriteError({required this.error, required this.productId});
}
