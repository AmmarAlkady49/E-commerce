part of 'cart_cubit.dart';

class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final CartResponseBody cartItems;
  CartLoaded(this.cartItems);
}

final class CartError extends CartState {
  final String error;
  CartError(this.error);
}

final class CartItemDeleting extends CartState {
  final String productId;
  CartItemDeleting(this.productId);
}

final class CartItemDeleted extends CartState {}

final class CartItemDeletedError extends CartState {
  final String error;
  CartItemDeletedError(this.error);
}

final class CartItemUpdating extends CartState {
  final String productId;
  final bool isIncrement;
  CartItemUpdating(this.productId, this.isIncrement);
}

final class CartItemUpdated extends CartState {
  final int quantity;
  CartItemUpdated(this.quantity);
}

final class CartItemUpdatedError extends CartState {
  final String error;
  CartItemUpdatedError(this.error);
}
