import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton2 extends StatelessWidget {
  const MyButton2({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      buildWhen: (previous, current) =>
          current is SigningWithGoogle ||
          current is SigningWithGoogleError ||
          current is SigningWithGoogleSuccess,
      listenWhen: (previous, current) =>
          current is SigningWithGoogle ||
          current is SigningWithGoogleSuccess ||
          current is SigningWithGoogleError,
      listener: (context, state) {
        if (state is SigningWithGoogleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                textAlign: TextAlign.start,
                style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  context: context,
                ),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          );
        } else if (state is SigningWithGoogleSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.bottomNavBar,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SigningWithGoogle;

        return InkWell(
          onTap: isLoading ? null : () => authCubit.signinWithGoogle(),
          child: _GoogleButtonContent(
            text: isLoading
                ? S.of(context).loading
                : S.of(context).sign_up_with_google,
            isLoading: isLoading,
          ),
        );
      },
    );
  }
}

class _GoogleButtonContent extends StatelessWidget {
  final String text;
  final bool isLoading;

  const _GoogleButtonContent({
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              cacheHeight: 73,
              cacheWidth: 68,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: FontHelper.fontText(
                size: 14.sp,
                weight: FontWeight.w700,
                color: Colors.black,
                context: context,
              ),
            ),
            if (isLoading) ...[
              SizedBox(width: 12.w),
              SizedBox(
                width: 16.w,
                height: 16.h,
                child: CupertinoActivityIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
