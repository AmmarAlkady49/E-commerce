import 'dart:developer';

import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  final bool rememberMe;

  const SplashScreen({super.key, required this.rememberMe});

  @override

  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => curr is AuthSuccess || curr is AuthInitial,
      listener: (context, state) {
        if (state is AuthSuccess && rememberMe) {
          Navigator.pushReplacementNamed(context, AppRoutes.bottomNavBar);
          log('AuthSuccess');
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          log('AuthInitial');
        }
      },
      child: Scaffold(),
    );
  }
}
