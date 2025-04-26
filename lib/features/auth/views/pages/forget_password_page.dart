import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D61E7),
        elevation: 4.0,
        shadowColor: Colors.black,
        toolbarHeight: 55.h,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).forget_password2,
          style: FontHelper.fontText(
              size: 19.sp,
              weight: FontWeight.w800,
              color: Colors.white,
              context: context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity),
                Text(
                  S.of(context).forget_password2,
                  style: FontHelper.fontText(
                      size: 18.sp,
                      weight: FontWeight.w800,
                      color: Colors.black,
                      context: context),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  S.of(context).enter_your_email_to_reset,
                  style: FontHelper.fontText(
                      size: 16.sp,
                      weight: FontWeight.w500,
                      color: Colors.black45,
                      context: context),
                ),
                SizedBox(height: 24.h),
                Text('${S.of(context).your_email}:',
                    style: FontHelper.fontText(
                        size: 15.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                        context: context)),
                SizedBox(height: 8.h),
                MyTextFormField(
                    width: double.infinity,
                    hint: S.of(context).enter_your_email,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).empty_cell;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return S.of(context).invalid_email;
                      }
                      return null;
                    }),
                SizedBox(height: 20.h),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: authCubit,
                  listenWhen: (previous, current) =>
                      current is OTPCodeSendingError || current is OTPCodeSent,
                  listener: (context, state) {
                    if (state is OTPCodeSent) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.verifyEmail,
                        arguments: {
                          "email": emailController.text,
                          "pageType": "forgetPassword",
                        },
                      );
                    }
                    if (state is OTPCodeSendingError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          textAlign: TextAlign.left,
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
                  buildWhen: (previous, current) =>
                      current is OTPCodeSending ||
                      current is OTPCodeSent ||
                      current is OTPCodeSendingError,
                  builder: (context, state) {
                    if (state is OTPCodeSending) {
                      return MyButton1(
                          width: double.infinity,
                          height: 48.h,
                          buttonTitle: S.of(context).loading,
                          isLoading: true,
                          onTap: null);
                    }
                    return MyButton1(
                        width: double.infinity,
                        height: 48.h,
                        buttonTitle: S.of(context).reset_password,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authCubit
                                .sendEmailForgetPassword(emailController.text);
                            // emailController.clear();
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
