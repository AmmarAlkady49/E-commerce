import 'package:e_commerce_graduation/bottom_nav_bar.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/create_account.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/forget_password_page.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/sign_in_page.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/home/views/pages/home_page.dart';
import 'package:e_commerce_graduation/features/product_details/views/pages/product_details_page.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/account_page.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/change_password_profile.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/lang_page.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/profile_page.dart';
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

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case AppRoutes.profile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileCubit(),
                  child: const ProfilePage(),
                ));
      case AppRoutes.languagePage:
        return MaterialPageRoute(builder: (_) => const LangPage());
      case AppRoutes.changePassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileCubit(),
                  child: const ChangePasswordProfile(),
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
        final ProductResponse product = settings.arguments as ProductResponse;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(
                  product: product,
                ));

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
