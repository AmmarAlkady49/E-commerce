part of 'order_cubit.dart';

class OrderState {}

final class OrderInitial extends OrderState {}

final class CartItemsLoading extends OrderState {}

final class DeliveryMethodChanged extends OrderState {
  final DeliveryMethod deliveryMethod;
  DeliveryMethodChanged(this.deliveryMethod);
}

final class CartItemsLoaded extends OrderState {
  final CartResponseBody cartItems;
  CartItemsLoaded(this.cartItems);
}

final class CartItemsError extends OrderState {
  final String message;
  CartItemsError(this.message);
}

final class CreatingOrder extends OrderState {}

final class CreatedOrder extends OrderState {}

final class CreatingOrderError extends OrderState {
  final String message;
  CreatingOrderError(this.message);
}

final class GettingAllOrders extends OrderState {}

final class GotAllOrders extends OrderState {
  final List<GetOrderModel> orders;
  GotAllOrders(this.orders);
}

final class GettingAllOrdersError extends OrderState {
  final String message;
  GettingAllOrdersError(this.message);
}

final class CreatingOrderWithPayment extends OrderState {}

final class CreatedOrderWithPayment extends OrderState {}

final class CreatingOrderWithPaymentError extends OrderState {
  final String message;
  CreatingOrderWithPaymentError(this.message);
}
