import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerOfTheSigninWidget extends StatefulWidget {
  const ContainerOfTheSigninWidget({super.key});

  @override
  State<ContainerOfTheSigninWidget> createState() =>
      _ContainerOfTheSigninWidgetState();
}

class _ContainerOfTheSigninWidgetState
    extends State<ContainerOfTheSigninWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 12.0.w),
        child: Center(
          child: Form(
            key: formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: MyButton2(),
                  ),
                  SizedBox(height: 10.h),
                  MyOrDevider(size: size.width * 0.02, text: S.of(context).or),
                  SizedBox(height: 10.h),
                  MyTextFormField(
                    width: size.width * 0.8,
                    hint: S.of(context).enter_your_email,
                    textInputType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).empty_cell;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return S.of(context).invalid_email;
                      }
                      return null;
                    },
                    presentFocusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                  ),
                  SizedBox(height: 13.h),
                  MyTextFormField(
                    width: size.width * 0.8,
                    hint: S.of(context).password,
                    textInputType: TextInputType.visiblePassword,
                    autofillHints: [AutofillHints.password],
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).empty_cell;
                      }
                      if (value.length < 5) {
                        return S.of(context).password_length;
                      }
                      return null;
                    },
                    presentFocusNode: passwordFocusNode,
                    nextFocusNode: null,
                    disFocus: true,
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
                        current is AuthSuccess ||
                        current is AuthError ||
                        current is AuthErrorVerification,
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.bottomNavBar, (route) => false);
                      }
                      if (state is AuthError) {
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
                      if (state is AuthErrorVerification) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          autoDismiss: true,
                          dismissOnBackKeyPress: true,
                          headerAnimationLoop: false,
                          title: S.of(context).verify_email,
                          desc: S.of(context).desc_verify_email,
                          titleTextStyle: FontHelper.fontText(
                              size: 20.sp,
                              weight: FontWeight.w600,
                              color: Colors.black,
                              context: context),
                          descTextStyle: FontHelper.fontText(
                              size: 15.sp,
                              weight: FontWeight.w600,
                              color: Colors.black,
                              context: context),
                          btnOkOnPress: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppRoutes.login, (route) => false);
                          },
                        ).show();
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthError ||
                        current is AuthErrorVerification,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MyButton1(
                          buttonTitle: S.of(context).login,
                          height: 42.h,
                          width: size.width * 0.8,
                          onTap: null,
                          isLoading: true,
                        );
                      }
                      if (state is AuthErrorVerification ||
                          state is AuthError) {
                        return MyButton1(
                          buttonTitle: S.of(context).login,
                          height: 42.h,
                          width: size.width * 0.8,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await cubit.loginAccount(emailController.text,
                                  passwordController.text);
                            }
                          },
                        );
                      }
                      return MyButton1(
                        buttonTitle: S.of(context).login,
                        height: 42.h,
                        width: size.width * 0.8,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.loginAccount(
                                emailController.text, passwordController.text);
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
                          color: Colors.black,
                          context: context),
                      children: [
                        TextSpan(
                          text: S.of(context).sign_up2,
                          style: FontHelper.fontText(
                              size: 14.sp,
                              weight: FontWeight.w700,
                              color: Color(0xff1D61E7),
                              context: context),
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
    );
  }
}
