class ApiPathes {
  static String users(String userId) => 'users/$userId';

  static String cartItem(String userId, String productId) =>
      '/users/$userId/cart/$productId';
  static String cartItems(String userId) => '/users/$userId/cart/';
  static String favoriteProduct(String userId, String productId) =>
      '/users/$userId/favorites/$productId';
  static String favoriteProducts(String userId) => '/users/$userId/favorites/';
  static String addresses(String userId) => '/users/$userId/addresses';
  static String addressItem(String userId, String addressId) =>
      '/users/$userId/addresses/$addressId';
}
