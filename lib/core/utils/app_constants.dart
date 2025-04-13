class AppConstants {
  static const String appTitle = 'E-Commerce Graduation Project';

  // APIs paths
  static const String baseUrl =
      'https://ecommerceapi-dve9edbbasgxbfg9.uaenorth-01.azurewebsites.net';
  static const String getAllProducts = '/Product/get-all-products';
  static const String getProductById = '/Product/get-product-by-id/';
  static const String login = '/Account/login';
  static const String register = '/Account/register';
  static const String logout = '/Account/logout';
  static const String accountProfile = '/Account/profile';
  static const String sendEmailForgetPassword = '/Account/send-email-forget-password';
  static const String resetPasswort = '/Account/reset-password';
  static const String activeAccount = '/Account/active-account';
  static const String editProfile = '/Account/edit-profile';
  static const String verifyOtp = '/Account/verify-otp';
  static const String resendOtp = '/Account/resend-otp';
  static const String googleLogin = '/Account/google-login';
}
