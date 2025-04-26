import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/order/models/create_order_model.dart';
import 'package:e_commerce_graduation/features/order/models/created_order_sucess_from_api_response.dart';
import 'package:e_commerce_graduation/features/order/models/get_order_model.dart';

abstract class OrderServices {
  Future<void> createOrder(CreateOrderModel orderModel);
  Future<List<GetOrderModel>> getAllOrders();
  Future<CreatedOrderSucessFromApiResponse> createOrderWithPayment(
      CreateOrderModel orderModel);
  Future<String> paymentCallback();
  Future<String> getOrderStatusById(String orderId);
}

class OrderServicesImpl implements OrderServices {
  final aDio = Dio();
  final secureStorage = SecureStorage();
  @override
  Future<void> createOrder(CreateOrderModel orderModel) async {
    try {
      final apiResponse = await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.createOrder}",
        data: {
          "cartId": orderModel.cartId,
          "shippingDTO": {
            "address": orderModel.shippingDTO.address,
            "city": orderModel.shippingDTO.city,
            "country": orderModel.shippingDTO.country,
            "postalCode": orderModel.shippingDTO.postalCode,
            "shippingMethod": orderModel.shippingDTO.shippingMethod,
            "useProfileAddress": true,
            "updateProfileAddress": true
          }
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
      );
      log(apiResponse.statusCode.toString());
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  @override
  Future<List<GetOrderModel>> getAllOrders() async {
    try {
      final apiResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getAllOrders}",
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (apiResponse.statusCode == 200) {
        log("Response: ${apiResponse.data}");
        final List<GetOrderModel> orders = (apiResponse.data as List)
            .map((orderJson) => GetOrderModel.fromMap(orderJson))
            .toList();

        return orders;
      } else if (apiResponse.statusCode == 400) {
        throw Exception(
            apiResponse.data['message'] ?? 'Failed to get all orders');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 403) {
        throw Exception('Forbidden: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 404) {
        throw Exception('Not Found: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 500) {
        throw Exception(
            'Internal Server Error: ${apiResponse.data['message']}');
      } else {
        throw Exception('Failed to get all orders: ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get all orders: $e');
    }
  }

  @override
  Future<CreatedOrderSucessFromApiResponse> createOrderWithPayment(
      CreateOrderModel orderModel) async {
    try {
      final apiResponse = await aDio.post(
        "${AppConstants.baseUrl}${AppConstants.createOrderWithPayment}",
        data: {
          "cartId": orderModel.cartId,
          "shippingDTO": {
            "address": orderModel.shippingDTO.address,
            "city": orderModel.shippingDTO.city,
            "country": orderModel.shippingDTO.country,
            "postalCode": orderModel.shippingDTO.postalCode,
            "shippingMethod": orderModel.shippingDTO.shippingMethod,
            "useProfileAddress": true,
            "updateProfileAddress": true
          }
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
      );
      if (apiResponse.statusCode == 200) {
        return CreatedOrderSucessFromApiResponse.fromMap(apiResponse.data);
      } else if (apiResponse.statusCode == 400) {
        throw Exception(apiResponse.data['message'] ??
            'Failed to create order with payment');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 403) {
        throw Exception('Forbidden: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 404) {
        throw Exception('Not Found: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 500) {
        throw Exception(
            'Internal Server Error: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 502) {
        throw Exception('Bad Gateway: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 503) {
        throw Exception('Service Unavailable: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 504) {
        throw Exception('Gateway Timeout: ${apiResponse.data['message']}');
      } else {
        throw Exception(
            'Failed to create order with payment: ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create order with payment: $e');
    }
  }

  // payment callback
  @override
  Future<String> paymentCallback() async {
    try {
      final apiResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.paymentCallback}",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
      );
      if (apiResponse.statusCode == 200) {
        return apiResponse.data['message'];
      } else if (apiResponse.statusCode == 400) {
        throw Exception(
            apiResponse.data['message'] ?? 'Failed to payment callback');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 403) {
        throw Exception('Forbidden: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 404) {
        throw Exception('Not Found: ${apiResponse.data['message']}');
      } else {
        throw Exception(
            'Failed to payment callback: ${apiResponse.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to payment callback: $e');
    }
  }

  // get order status by id
  @override
  Future<String> getOrderStatusById(String orderId) async {
    try {
      final apiResponse = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getOrderStatus}",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.readSecureData('token')}",
          },
        ),
        queryParameters: {
          "orderNumber": orderId,
        },
      );
      if (apiResponse.statusCode == 200) {
        return apiResponse.data['paymentStatus'];
      } else if (apiResponse.statusCode == 400) {
        throw Exception(
            apiResponse.data['message'] ?? 'Failed to get order status by id');
      } else if (apiResponse.statusCode == 401) {
        // 401
        throw Exception('Unauthorized: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 403) {
        // 403
        throw Exception('Forbidden: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 404) {
        // 404
        throw Exception('Not Found: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 500) {
        // 500
        throw Exception(
            'Internal Server Error: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 502) {
        // 502
        throw Exception('Bad Gateway: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 503) {
        // 503
        throw Exception('Service Unavailable: ${apiResponse.data['message']}');
      } else if (apiResponse.statusCode == 504) {
        // 504
        throw Exception('Gateway Timeout: ${apiResponse.data['message']}');
      } else {
        throw Exception(
            'Failed to get order status by id: ${apiResponse.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get order status by id: $e');
    }
  }
}
