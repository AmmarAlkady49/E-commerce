import 'dart:developer';

import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyAccount extends StatefulWidget {
  final String email;
  final String? pageType;
  const VerifyAccount({super.key, required this.email, required this.pageType});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final int otpLength = 6;
  String otpCode = "";
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    log(widget.pageType!);
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget buildOtpField(int index, BuildContext context, AuthCubit cubit) {
    focusNodes[index].addListener(() {
      setState(() {});
    });

    bool isFocused = focusNodes[index].hasFocus;

    return Container(
      height: 48.h,
      width: 40.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color:
              isFocused ? MyColor.kellyGreen3 : Colors.black12, // ← هنا التغيير
          width: 2,
        ),
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: FontHelper.fontText(
            size: 20.sp,
            weight: FontWeight.w700,
            color: Colors.black,
            context: context),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < otpLength - 1) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          } else {
            otpCode = controllers.map((controller) => controller.text).join();
            log(otpCode);
            if (otpCode.length == otpLength) {
              FocusScope.of(context).unfocus();
              widget.pageType == "register"
                  ? cubit.activeAccount(otpCode, widget.email)
                  : widget.pageType == "forgetPassword"
                      ? cubit.verifyOtpCode(widget.email, otpCode)
                      : null;
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is VerifyEmailSuccess ||
          current is VerifyEmailError ||
          current is VerifyOTPCodeSuccess ||
          current is ResendOTPCodeSuccess ||
          current is ResendOTPCodeError,
      listener: (context, state) {
        if (state is VerifyEmailSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              S.of(context).verify_email_successfully,
              style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  context: context),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ));
        }
        if (state is VerifyOTPCodeSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.changePassword,
              arguments: widget.email);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              S.of(context).verify_otp_code_successfully,
              style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  context: context),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ));
        }
        if (state is VerifyEmailError) {
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
        if (state is ResendOTPCodeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              S.of(context).resend_otp_code_successfully,
              style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  context: context),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ));
        }
        if (state is ResendOTPCodeError) {
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
      buildWhen: (previous, current) =>
          current is VerifyEmailLoading ||
          current is VerifyEmailError ||
          current is ResendOTPCodeLoading ||
          current is ResendOTPCodeError ||
          current is ResendOTPCodeSuccess,
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.12,
                  right: 24.w,
                  left: 24.w),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/auth/otp_blue.png",
                    width: 100.w,
                    height: 100.h,
                    cacheHeight: 300,
                    cacheWidth: 320,
                  ),
                  Text(
                    S.of(context).verify_email_1,
                    style: FontHelper.fontText(
                        size: 24.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                        context: context),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    S.of(context).verify_email_2,
                    textAlign: TextAlign.center,
                    style: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w400,
                        color: Colors.black,
                        context: context),
                  ),
                  SizedBox(height: 24.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        otpLength,
                        (index) => buildOtpField(index, context, cubit),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      cubit.resendOtpCode(widget.email);
                      for (var controller in controllers) {
                        controller.clear();
                      }
                    },
                    child: Text.rich(
                      TextSpan(
                        text: S.of(context).verify_email_4,
                        style: FontHelper.fontText(
                            size: 14.sp,
                            weight: FontWeight.w500,
                            color: Colors.black,
                            context: context),
                        children: [
                          TextSpan(
                            text: " ${S.of(context).verify_email_3}",
                            style: FontHelper.fontText(
                                size: 13.sp,
                                weight: FontWeight.w700,
                                color: MyColor.kellyGreen,
                                context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Visibility(
                    visible: state is VerifyEmailLoading ||
                        state is ResendOTPCodeLoading,
                    child: CupertinoActivityIndicator(radius: 12.r),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
