import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/create_account.dart';
import 'package:e_commerce_graduation/features/auth/views/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case AppRoutes.createAccount:
        return MaterialPageRoute(builder: (_) => CreateAccount());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              // Scaffold(
              //       backgroundColor: Colors.white,
              //       body: Center(
              //         child: Text('No route defined for ${settings.name}'),
              //       ),
              //     )
              SignInPage(),
        );
    }
  }
}
