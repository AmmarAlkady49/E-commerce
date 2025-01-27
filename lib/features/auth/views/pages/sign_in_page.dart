import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_button2.dart';
import 'package:e_commerce_graduation/core/widgets/my_or_devider.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/features/auth/views/widgets/remember_and_forget_login.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            child: MyButton2(),
                          ),
                          SizedBox(height: 10.h),
                          MyOrDevider(
                              size: size.width * 0.02, text: S.of(context).or),
                          SizedBox(height: 10.h),
                          MyTextFormField(
                            width: size.width * 0.8,
                            hint: S.of(context).enter_your_email,
                            textInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 13.h),
                          MyTextFormField(
                            width: size.width * 0.8,
                            hint: S.of(context).password,
                            textInputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 0.h),
                          SizedBox(
                            width: size.width * 0.8,
                            child: RememberAndForgetLogin(),
                          ),
                          SizedBox(height: 4.h),
                          MyButton1(
                            buttonTitle: S.of(context).login,
                            height: 42.h,
                            width: size.width * 0.8,
                          ),
                          SizedBox(height: 8.h),
                          RichText(
                            text: TextSpan(
                              text: '${S.of(context).Dont_have_an_account}  ',
                              style: FontHelper.fontText(
                                  size: 12.sp,
                                  weight: FontWeight.w400,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: S.of(context).sign_up,
                                  style: FontHelper.fontText(
                                      size: 12.sp,
                                      weight: FontWeight.w700,
                                      color: Color(0xff1D61E7)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
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
        ],
      ),
    );
  }
}
