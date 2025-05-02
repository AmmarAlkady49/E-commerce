import 'package:e_commerce_graduation/core/utils/routes/app_router.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences pref = await SharedPreferences.getInstance();
  String lang = pref.getString('lang') ?? 'ar';
  bool rememberMe = pref.getBool("rememberMe") ?? false;
  runApp(Phoenix(
      child: MyApp(
    lang: lang,
    rememberMe: rememberMe,
  )));
}

class MyApp extends StatelessWidget {
  final String lang;
  final bool rememberMe;
  const MyApp({super.key, required this.lang, required this.rememberMe});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) {
                final cubit = AuthCubit();
                cubit.checkAuth();
                return cubit;
              },
            ),
            BlocProvider<FavoritesCubit>(
              create: (context) => FavoritesCubit()..getFavoriteProducts( context ),
            ),
            BlocProvider<CartCubit>(
              create: (context) => CartCubit(
                favoritesCubit: context.read<FavoritesCubit>(),
              )..getCartItems(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(),
            ),
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(
                favoritesCubit: context.read<FavoritesCubit>(),
              )..getAllProducts(),
            ),
          ],
          child: Builder(
            builder: (context) {
              final authCubit = context.read<AuthCubit>();
              return BlocBuilder<AuthCubit, AuthState>(
                bloc: authCubit,
                buildWhen: (previous, current) =>
                    current is AuthSuccess || current is AuthInitial,
                builder: (context, state) {
                  return MaterialApp(
                    title: AppConstants.appTitle,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    locale: Locale(lang),
                    theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                      useMaterial3: true,
                    ),
                    initialRoute: (state is AuthSuccess && rememberMe)
                        ? AppRoutes.bottomNavBar
                        : AppRoutes.login,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
