part of 'cart_cubit.dart';

class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final CartResponseBody cartItems;
  CartLoaded(this.cartItems);
}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

final class CartItemDeleting extends CartState {
  final String productId;
  CartItemDeleting(this.productId);
}

final class CartItemDeleted extends CartState {}

final class CartItemDeletedError extends CartState {
  final String message;
  CartItemDeletedError(this.message);
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
  final String message;
  CartItemUpdatedError(this.message);
}
