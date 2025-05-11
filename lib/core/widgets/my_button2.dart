import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton2 extends StatelessWidget {
  const MyButton2({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<AuthCubit, AuthState>(
      bloc: homeCubit,
      listenWhen: (previous, current) =>
          current is SigningWithGoogleError ||
          current is SigningWithGoogleSuccess,
      listener: (context, state) {
        if (state is SigningWithGoogleError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.message,
              textAlign: TextAlign.start,
              style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  context: context),
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ));
        }
        if (state is SigningWithGoogleSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.bottomNavBar, (route) => false);
        }
      },
      child: InkWell(
        onTap: () {
          homeCubit.signinWithGoogle();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(11.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/auth/google.png',
                  height: 23.h,
                  width: 23.w,
                ),
                SizedBox(width: 8.w),
                Text(S.of(context).sign_up_with_google,
                    style: FontHelper.fontText(
                        size: 14.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                        context: context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
