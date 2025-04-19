import 'package:dio/dio.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';

abstract class CartServices {
  Future<CartResponseBody> getCartItems(String userId);
  Future<bool> deleteProductFromCart(String userId, String productId);
  Future<bool> deleteAllProductsFromCart(String userId);
  Future<void> updateProductQuantity(
      String userId, String productId, int newQuantity);
  Future<bool> addProductToCart(String userId, int productId, int quantity);
}

class CartServicesImpl implements CartServices {
  final aDio = Dio();
  @override
  Future<CartResponseBody> getCartItems(String userId) async {
    try {
      final response = await aDio.get(
        "${AppConstants.baseUrl}${AppConstants.getCart}/$userId",
        options:
            Options(validateStatus: (status) => status != null && status < 500),
      );
      if (response.statusCode == 200) {
        return CartResponseBody.fromMap(response.data);
      } else if (response.statusCode == 500) {
        throw Exception('Server error: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: ${response.statusCode}');
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      throw Exception('Failed to load cart items: $e');
    }
  }

  @override
  Future<bool> deleteProductFromCart(String userId, String productId) async {
    try {
      final apiResponse = await aDio.delete(
        "${AppConstants.baseUrl}${AppConstants.removeCartItem}",
        queryParameters: {
          'cartId': userId,
          'productId': productId,
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (apiResponse.statusCode == 200) {
        // Handle successful deletion if needed
        return true;
      } else if (apiResponse.statusCode == 500) {
        throw Exception('Server error: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 404) {
        throw Exception('Product not found: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 400) {
        throw Exception('Bad request: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 403) {
        throw Exception('Forbidden: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 429) {
        throw Exception('Too many requests: ${apiResponse.statusCode}');
      } else {
        throw Exception('Failed to delete product from cart');
      }
    } catch (e) {
      throw Exception('Failed to delete product from cart: $e');
    }
  }

  @override
  Future<bool> deleteAllProductsFromCart(String userId) async {
    try {
      final apiResponse = await aDio.delete(
        "${AppConstants.baseUrl}${AppConstants.deleteAllCartItems}/$userId",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 500) {
        throw Exception('Server error: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.statusCode}');
      } else {
        throw Exception('Failed to delete all products from cart');
      }
    } catch (e) {
      throw Exception('Failed to delete all products from cart: $e');
    }
  }

  @override
  Future<bool> updateProductQuantity(
      String userId, String productId, int newQuantity) async {
    try {
      final apiResponse = await aDio.put(
        "${AppConstants.baseUrl}${AppConstants.updateProductQuantity}",
        queryParameters: {
          'cartId': userId,
          'productId': productId,
          'quantity': newQuantity,
        },
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 500) {
        throw Exception('Server error: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.statusCode}');
      } else {
        throw Exception('Failed to update product quantity');
      }
    } catch (e) {
      throw Exception('Failed to update product quantity: $e');
    }
  }

  @override
  Future<bool> addProductToCart(
      String userId, int productId, int quantity) async {
    try {
      final apiResponse = await aDio.post(
          "${AppConstants.baseUrl}${AppConstants.addProductToCart}",
          queryParameters: {
            'cartId': userId,
          },
          data: {
            'productId': productId,
            'quantity': quantity,
          },
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ));

      if (apiResponse.statusCode == 200) {
        return true;
      } else if (apiResponse.statusCode == 500) {
        throw Exception('Server error: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 401) {
        throw Exception('Unauthorized: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 404) {
        throw Exception('Product not found: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 400) {
        throw Exception('Bad request: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 403) {
        throw Exception('Forbidden: ${apiResponse.statusCode}');
      } else if (apiResponse.statusCode == 429) {
        throw Exception('Too many requests: ${apiResponse.statusCode}');
      } else {
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      throw Exception('Failed to add product to cart: $e');
    }
  }
}
