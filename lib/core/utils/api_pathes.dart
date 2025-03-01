class ApiPathes {
  static String users(String userId) => 'users/$userId';

  static String cartItem(String userId, String productId) =>
      '/users/$userId/cart/$productId';
  static String cartItems(String userId) => '/users/$userId/cart/';
  static String favoriteProduct(String userId, String productId) =>
      '/users/$userId/favorites/$productId';
  static String favoriteProducts(String userId) => '/users/$userId/favorites/';
}
