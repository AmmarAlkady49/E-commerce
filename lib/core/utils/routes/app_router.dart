import 'package:e_commerce_graduation/bottom_nav_bar.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/features/address/views/pages/address_page.dart';
import 'package:e_commerce_graduation/features/address/views/pages/new_address_page.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/create_account.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/forget_password_page.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/sign_in_page.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/verify_account.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/products_by_category.dart';
import 'package:e_commerce_graduation/features/order/cubit/order_cubit.dart';
import 'package:e_commerce_graduation/features/order/views/pages/confirm_order_page.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/pages/home_page.dart';
import 'package:e_commerce_graduation/features/order/views/pages/my_order_page.dart';
import 'package:e_commerce_graduation/features/order/views/pages/payment_webview_page.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/views/pages/product_details_page.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/account_page.dart';
import 'package:e_commerce_graduation/core/widgets/change_password_profile.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/lang_page.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/profile_page.dart';
import 'package:e_commerce_graduation/features/search/cubit/search_cubit.dart';
import 'package:e_commerce_graduation/features/search/views/pages/speech_to_text_search_page.dart';
import 'package:e_commerce_graduation/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('---------------------Navigating to: ${settings.name}');
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: SignInPage(),
                ));
      case AppRoutes.createAccount:
        return MaterialPageRoute(builder: (_) => CreateAccount());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      case AppRoutes.speechToText:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SearchCubit()..initSpeechToText(),
                  child: const SpeechToTextSearchPage(),
                ));

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case AppRoutes.productsByCategoryPage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ProductsByCategory(
                  categoryCode: args['categoryCode'],
                  categoryCode2: args['categoryCode2'],
                  categoryName: args['categoryName'],
                ));

      case AppRoutes.profile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => ProfileCubit(),
                  child: const ProfilePage(),
                ));
      case AppRoutes.languagePage:
        return MaterialPageRoute(builder: (_) => const LangPage());
      case AppRoutes.paymentWebviewPage:
        final String paymentUrl = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PaymentWebviewPage(paymentUrl: paymentUrl));
      case AppRoutes.confirmOrderPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OrderCubit(
                      cartCubit: context.read<CartCubit>(),
                      favoritesCubit: context.read<FavoritesCubit>()),
                  child: const ConfirmOrderPage(),
                ));
      case AppRoutes.myOrderPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OrderCubit(
                      cartCubit: context.read<CartCubit>(),
                      favoritesCubit: context.read<FavoritesCubit>()),
                  child: const MyOrderPage(),
                ));

      case AppRoutes.verifyEmail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerifyAccount(
            email: args['email'],
            pageType: args['pageType'],
          ),
        );
      case AppRoutes.addressPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = AddressCubit();
                    cubit.getAllAddresses();
                    return cubit;
                  },
                  child: const AddressPage(),
                ));
      case AppRoutes.newAddressPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddressCubit(),
                  child: const NewAddressPage(),
                ));
      case AppRoutes.splash:
        final bool rememberMe = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => SplashScreen(rememberMe: rememberMe),
        );
      case AppRoutes.changePassword:
        final String? email = settings.arguments as String?;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: ChangePasswordProfile(email: email),
                ));
      case AppRoutes.accountPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProfileCubit();
                    cubit.getUserData();
                    return cubit;
                  },
                  child: const AccountPage(),
                ));
      case AppRoutes.productPage:
        final product = settings.arguments as ProductResponse;
        return MaterialPageRoute(
          builder: (context) {
            final cartCubit = context.read<CartCubit>();
            final favoriteCubit = context.read<FavoritesCubit>();
            final productDetailsCubit = ProductDetailsCubit(
                cartCubit: cartCubit, favoritesCubit: favoriteCubit)
              ..getProductDetails(product.productID!);

            return BlocProvider.value(
              value: productDetailsCubit,
              child: ProductDetailsPage(),
            );
          },
        );

      default:
        debugPrint('No route defined for ${settings.name}');
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
