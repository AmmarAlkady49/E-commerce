part of 'favorites_cubit.dart';

class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoriteItemLoading extends FavoritesState {
  final String productId;

  FavoriteItemLoading({required this.productId});
}

final class FavoriteItemLoaded extends FavoritesState {
  final String productId;

  FavoriteItemLoaded({required this.productId});
}

final class FavoriteItemError extends FavoritesState {
  final String message;
  final String productId;

  FavoriteItemError({required this.message, required this.productId});
}
