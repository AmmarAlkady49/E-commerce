import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: homeCubit,
          listenWhen: (previous, current) =>
              current is LoggedOut || current is LogoutError,
          listener: (context, state) {
            if (state is LogoutError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is LoggedOut) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.login, (route) => false);
            }
          },
          buildWhen: (previous, current) => current is LoggingOut,
          builder: (context, state) {
            if (state is LoggingOut) {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      pref.setBool('rememberMe', false);
                      homeCubit.signOut();
                    },
                    child: Text('Exit')),
              ],
            );
          },
        ),
      ),
    );
  }
}
