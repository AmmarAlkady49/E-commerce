class AppConstants {
  static const String appTitle = 'E-Commerce Graduation Project';
  static const String googleClientId =
      '563886842859-ekb482r8dm27fp0kedd20plsbela73hp.apps.googleusercontent.com';
      static const String webClientId = '563886842859-v006q58f3c1jvpqu5apbggur8cpgbd61.apps.googleusercontent.com';
  // 'com.googleusercontent.apps.563886842859-ekb482r8dm27fp0kedd20plsbela73hp';

  // APIs paths
  static const String baseUrl =
      'https://ecommerceapi-dve9edbbasgxbfg9.uaenorth-01.azurewebsites.net';
  static const String getAllProducts = '/Product/get-all-products';
  static const String getProductById = '/Product/get-product-by-id/';
  static const String login = '/Account/login';
  static const String register = '/Account/register';
  static const String logout = '/Account/logout';
  static const String accountProfile = '/Account/profile';
  static const String editAccountProfile = '/Account/edit-profile';
  static const String sendEmailForgetPassword =
      '/Account/send-email-forget-password';
  static const String resetPasswort = '/Account/reset-password';
  static const String activeAccount = '/Account/active-account';
  static const String editProfile = '/Account/edit-profile';
  static const String verifyOtp = '/Account/verify-otp';
  static const String resendOtp = '/Account/resend-otp';
  static const String googleLogin = '/Account/google-login';
  static const String mobileGoogleLogin = '/Account/mobile-google-login';
  static const String addToWishlist = '/Wishlist/add-to-wishlist';
  static const String getWishlist = '/Wishlist/get-wishlist-by-id';
  static const String removeFromWishlist =
      '/Wishlist/remove-item-from-wishlist';
  static const String clearWishlist = '/Wishlist/clear-wishlist';
  static const String getCart = '/Cart/get-cart-by-id';
  static const String removeCartItem = '/Cart/remove-item';
  static const String deleteAllCartItems = '/Cart/delete-cart';
  static const String updateProductQuantity = '/Cart/update-quantity';
  static const String addProductToCart = '/Cart/add-to-cart';
  static const String getAllCategories = '/Category/get-all-categories';
  static const String createOrder = '/Order/create-order';
  static const String getAllOrders = '/Order/get-all-orders-for-user';
  static const String createOrderWithPayment =
      '/Payment/create-order-with-payment';
  static const String paymentCallback = '/Payment/callback';
  static const String getOrderStatus = '/Order/get-order-status-by-id';
}
