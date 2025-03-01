part of 'cart_cubit.dart';

class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  CartLoaded(this.cartItems);
}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

final class CartItemDeleted extends CartState {}

final class CartItemUpdated extends CartState {}
