import 'dart:developer';

import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/features/cart/services/cart_services.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/order/models/create_order_model.dart';
import 'package:e_commerce_graduation/features/order/models/get_order_model.dart';
import 'package:e_commerce_graduation/features/order/models/shipping_dto.dart';
import 'package:e_commerce_graduation/features/order/services/order_services.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

enum DeliveryMethod {
  standard(20.0),
  express(40.0);

  final double price;
  const DeliveryMethod(this.price);
}

class OrderCubit extends Cubit<OrderState> {
  final CartCubit cartCubit;
  final FavoritesCubit favoritesCubit;
  OrderCubit({required this.cartCubit, required this.favoritesCubit})
      : super(OrderInitial());

  final secureStorage = SecureStorage();
  final CartServices _cartServices = CartServicesImpl();
  final OrderServices _orderServices = OrderServicesImpl();
  final ProfilePageServices _profilePageServices = ProfilePageServicesimpl();
  DeliveryMethod _selectedDeliveryMethod = DeliveryMethod.standard;

  DeliveryMethod get selectedDeliveryMethod => _selectedDeliveryMethod;

  void setDeliveryMethod(DeliveryMethod method) {
    _selectedDeliveryMethod = method;
    emit(DeliveryMethodChanged(method));
  }

// get all cart items
  Future<void> getCartItems() async {
    emit(CartItemsLoading());
    final String user = await secureStorage.readSecureData('userId');
    try {
      final cartItems = await _cartServices.getCartItems(user);
      emit(CartItemsLoaded(cartItems));
    } on Exception catch (e) {
      emit(CartItemsError(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(CartItemsError(e.toString()));
    }
  }

  // // create Order
  // Future<void> createOrder() async {
  //   emit(CreatingOrder());
  //   try {
  //     final userData = await _profilePageServices.getUserData();
  //     final orderModelObject = CreateOrderModel(
  //       cartId: userData.id!,
  //       shippingDTO: ShippingDto(
  //         address: userData.address!,
  //         city: userData.city!,
  //         country: userData.country!,
  //         postalCode: userData.postalCode!,
  //         shippingMethod: selectedDeliveryMethod.name,
  //         useProfileAddress: true,
  //         updateProfileAddress: true,
  //       ),
  //     );
  //     await _orderServices.createOrder(orderModelObject);
  //     // await _cartServices.deleteAllProductsFromCart(userData.id!);
  //     log("🚩 successfuly created order 🚩");
  //     emit(CreatedOrder());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(CreatingOrderError(e.toString()));
  //   }
  // }

  // get all orders
  Future<void> getAllOrders() async {
    emit(GettingAllOrders());
    try {
      final allOrders = await _orderServices.getAllOrders();
      log("🚩 all orders 🚩 ${allOrders.length}");
      emit(GotAllOrders(allOrders));
    } catch (e) {
      log(e.toString());
      emit(GettingAllOrdersError(e.toString()));
    }
  }

  // create order with payment
  Future<void> createOrderWithPayment(BuildContext context) async {
    emit(CreatingOrderWithPayment());
    try {
      final userData = await _profilePageServices.getUserData();
      if (userData.address == "null") {
        emit(CreatingOrderWithPaymentError("empty address"));
        log("🚩 empty address 🚩");
        return;
      }
      final orderModelObject = CreateOrderModel(
        cartId: userData.id!,
        shippingDTO: ShippingDto(
          address: userData.address!,
          city: userData.city!,
          country: userData.country!,
          postalCode: userData.postalCode!,
          shippingMethod: selectedDeliveryMethod.name,
          useProfileAddress: true,
          updateProfileAddress: true,
        ),
      );

      final createdOrder =
          await _orderServices.createOrderWithPayment(orderModelObject);

      final result = await Navigator.pushNamed(
          context, AppRoutes.paymentWebviewPage,
          arguments: createdOrder.data.paymentUrl);

          log("🚩 result from payment webview: $result 🚩");

      if (result == true) {
        emit(CreatedOrderWithPayment());

        cartCubit.hasFetchedCart = false;
        favoritesCubit.hasFetchedFavorites = false;
      } else {
        emit(CreatingOrderWithPaymentError(
            "User exited payment before finishing"));
      }

      log("🚩 successfuly created order with payment 🚩");
    } catch (e) {
      log(e.toString());
      emit(CreatingOrderWithPaymentError(e.toString()));
    }
  }
}
