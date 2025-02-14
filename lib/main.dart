import 'package:e_commerce_graduation/core/utils/routes/app_router.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/app_constants.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/firebase_options.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        return BlocProvider(
          create: (context) {
            final cubit = AuthCubit();
            cubit.checkAuth();
            return cubit;
          },
          child: Builder(builder: (context) {
            final authCubit = BlocProvider.of<AuthCubit>(context);
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
          }),
        );
      },
    );
  }
}
