part of 'product_details_cubit.dart';

class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class SetProductFavoriteSuccess extends ProductDetailsState {
  final bool isFavorite;
  final String productId;
  SetProductFavoriteSuccess({
    required this.isFavorite,
    required this.productId,
  });
}

final class SetProductFavoriteError extends ProductDetailsState {
  final String message;
  final String productId;
  SetProductFavoriteError({
    required this.message,
    required this.productId,
  });
}

final class SetProductFavoriteLoading extends ProductDetailsState {
  final String productId;
  SetProductFavoriteLoading({
    required this.productId,
  });
}
