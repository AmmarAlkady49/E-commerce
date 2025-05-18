import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/features/profile/views/widgets/text_form_field_change_password.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordProfile extends StatelessWidget {
  final String? email;
  const ChangePasswordProfile({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();

    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBarDefaultTheme(title: S.of(context).change_password),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).assign_new_password,
                  style: FontHelper.fontText(
                      size: 18.sp,
                      weight: FontWeight.w600,
                      color: Colors.black,
                      context: context),
                ),
                SizedBox(height: 12.h),
                TextFormFieldChangePassword(
                  controller: passwordController,
                  hintText: S.of(context).new_password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Password must contain at least one lowercase letter';
                    }
                    if (!value.contains(RegExp(r'\d'))) {
                      return 'password must contain at least one number';
                    }
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return 'Password must contain at least one special character';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                TextFormFieldChangePassword(
                  controller: passwordConfirmController,
                  hintText: S.of(context).confirm_password,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return S.of(context).password_not_match;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                Text(
                  '- ${S.of(context).password_instruction2}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 8.h),
                Text(
                  '- ${S.of(context).password_length2}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 8.h),
                Text(
                  '- ${S.of(context).password_uppercase}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 8.h),
                Text(
                  '- ${S.of(context).password_lowercase}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 8.h),
                Text(
                  '- ${S.of(context).password_number}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 8.h),
                Text(
                  '- ${S.of(context).password_special}',
                  style: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
                SizedBox(height: 24.h),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: authCubit,
                  buildWhen: (previous, current) =>
                      current is UpdateingPassword,
                  listenWhen: (previous, current) =>
                      current is UpdatePasswordSuccess ||
                      current is UpdatePasswordError,
                  listener: (context, state) {
                    if (state is UpdatePasswordSuccess) {
                      Navigator.pop(context);
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 400.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  topRight: Radius.circular(25.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 24.h),
                                  Text(
                                    S.of(context).reset_password_successfully,
                                    style: FontHelper.fontText(
                                        size: 20.sp,
                                        weight: FontWeight.w700,
                                        color: Colors.black,
                                        context: context),
                                  ),
                                  SizedBox(height: 12.h),
                                  Image.asset(
                                    'assets/images/auth/password_changed.png',
                                    width: 160.w,
                                    height: 160.h,
                                    cacheHeight: 479,
                                    cacheWidth: 513,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    S.of(context).dont_forget_new_password,
                                    style: FontHelper.fontText(
                                        size: 16.sp,
                                        weight: FontWeight.w600,
                                        color: Colors.black54,
                                        context: context),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                            );
                          });
                    }
                    if (state is UpdatePasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
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
                  },
                  builder: (context, state) {
                    if (state is UpdateingPassword) {
                      MyButton1(
                        width: double.infinity,
                        height: 42.h,
                        buttonTitle: S.of(context).loading,
                        onTap: null,
                        isLoading: true,
                      );
                    }
                    return MyButton1(
                        width: double.infinity,
                        height: 42.h,
                        buttonTitle: S.of(context).save,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            email != null
                                ? await authCubit.updatePassword(
                                    newPassword: passwordController.text,
                                    email: email)
                                : await authCubit.updatePassword(
                                    newPassword: passwordController.text,
                                    email: null);
                            // passwordController.clear();
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
