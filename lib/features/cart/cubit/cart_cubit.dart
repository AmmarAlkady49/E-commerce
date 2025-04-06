import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/cart/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final _authService = AuthServicesImpl();
  final _cartServices = CartServicesImpl();

  // get all cart items
  Future<void> getCartItems() async {
    // emit(CartLoading());
    final user = _authService.getCurrentUser();
    try {
      final cartItems = await _cartServices.getCartItems(user!.uid);
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  // delete product form cart
  Future<void> deleteProductFromCart(AddToCartModel cartItem) async {
    emit(CartItemDeleting(cartItem.id));
    final user = _authService.getCurrentUser();
    try {
      await _cartServices.deleteProductFromCart(user!.uid, cartItem.id);
      emit(CartItemDeleted());
    } catch (e) {
      emit(CartItemDeletedError(e.toString()));
    }
  }

  // clear the cart items
  Future<void> clearTheCart() async {
    emit(CartLoading());
    final user = _authService.getCurrentUser();
    try {
      await _cartServices.deleteAllProductsFromCart(user!.uid);
      emit(CartItemDeleted());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  // update product quantity
  Future<void> updateProductQuantity(
      AddToCartModel cartItem, bool isIncrement) async {
    emit(CartItemUpdating(cartItem.id));
    final user = _authService.getCurrentUser();
    try {
      final newCartItem = isIncrement
          ? cartItem.copyWith(quantity: cartItem.quantity + 1)
          : cartItem.copyWith(quantity: cartItem.quantity - 1);
      await _cartServices.updateProductQuantity(
          user!.uid, cartItem.id, newCartItem);

      emit(CartItemUpdated(cartItem.quantity));
    } catch (e) {
      emit(CartItemUpdatedError(e.toString()));
    }
  }
}
