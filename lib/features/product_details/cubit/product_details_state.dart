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

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddedToCart extends ProductDetailsState {}

final class ProductAddedToCartError extends ProductDetailsState {
  final String message;
  ProductAddedToCartError({
    required this.message,
  });
}

final class ProductDetailsQuantityChanged extends ProductDetailsState {
  final int quantity;

  ProductDetailsQuantityChanged({required this.quantity});
}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded({
    required this.product,
  });
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({
    required this.message,
  });
}
