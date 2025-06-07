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
  SetProductFavoriteLoading();
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
  final ProductResponse product;
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

final class ProductAddingReview extends ProductDetailsState {}

final class ProductAddedReview extends ProductDetailsState {}

final class ProductAddedReviewError extends ProductDetailsState {
  final String message;
  ProductAddedReviewError({
    required this.message,
  });
}

final class ProductReviewsLoading extends ProductDetailsState {}

final class ProductReviewsLoaded extends ProductDetailsState {
  final List<ProductReviewsModel> reviews;
  ProductReviewsLoaded({
    required this.reviews,
  });
}
final class ProductReviewsError extends ProductDetailsState {
  final String message;
  ProductReviewsError({
    required this.message,
  });
}