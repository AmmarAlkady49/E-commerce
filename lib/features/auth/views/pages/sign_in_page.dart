import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_button2.dart';
import 'package:e_commerce_graduation/core/widgets/my_or_devider.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/features/auth/views/widgets/remember_and_forget_login.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/auth/background1.svg',
              height: size.height * 0.5,
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: size.height * 0.2,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).sign_in,
                    textAlign: TextAlign.center,
                    style: FontHelper.fontText(
                        size: 36.sp,
                        weight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).enter_your_email_and_password,
                    style: FontHelper.fontText(
                        size: 15.sp,
                        weight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              )),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 42.h),
              child: InkWell(
                onTap: () {},
                child: Text(S.of(context).english,
                    style: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.4,
            left: 0,
            right: 0,
            bottom: size.height * 0.05,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 18.0.h, horizontal: 12.0.w),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width * 0.8,
                              child: MyButton2(),
                            ),
                            SizedBox(height: 10.h),
                            MyOrDevider(
                                size: size.width * 0.02,
                                text: S.of(context).or),
                            SizedBox(height: 10.h),
                            MyTextFormField(
                              width: size.width * 0.8,
                              hint: S.of(context).enter_your_email,
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).empty_cell;
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return S.of(context).invalid_email;
                                }
                              },
                            ),
                            SizedBox(height: 13.h),
                            MyTextFormField(
                              width: size.width * 0.8,
                              hint: S.of(context).password,
                              textInputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).empty_cell;
                                }
                                if (value.length < 6) {
                                  return S.of(context).password_length;
                                }
                                
                              },
                            ),
                            SizedBox(height: 0.h),
                            SizedBox(
                              width: size.width * 0.8,
                              child: RememberAndForgetLogin(),
                            ),
                            SizedBox(height: 12.h),
                            BlocConsumer<AuthCubit, AuthState>(
                              bloc: cubit,
                              listenWhen: (previous, current) =>
                                  current is AuthSuccess,
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.home,
                                    (route) => false,
                                  );
                                }
                              },
                              buildWhen: (previous, current) =>
                                  current is AuthLoading ||
                                  current is AuthError ||
                                  current is AuthSuccess,
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return MyButton1(
                                    buttonTitle: S.of(context).login,
                                    height: 42.h,
                                    width: size.width * 0.8,
                                    onTap: () {},
                                    isLoading: true,
                                  );
                                }
                                return MyButton1(
                                  buttonTitle: S.of(context).login,
                                  height: 42.h,
                                  width: size.width * 0.8,
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      await cubit.loginAccount(
                                          emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 12.h),
                            RichText(
                              text: TextSpan(
                                text: '${S.of(context).Dont_have_an_account} ',
                                style: FontHelper.fontText(
                                    size: 14.sp,
                                    weight: FontWeight.w400,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: S.of(context).sign_up2,
                                    style: FontHelper.fontText(
                                        size: 14.sp,
                                        weight: FontWeight.w700,
                                        color: Color(0xff1D61E7)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.createAccount);
                                      },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
