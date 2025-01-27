import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_button2.dart';
import 'package:e_commerce_graduation/core/widgets/my_or_devider.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              top: size.height * 0.07,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    S.of(context).sign_up,
                    style: FontHelper.fontText(
                        size: 36.sp,
                        weight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(TextSpan(
                    text: S.of(context).already_have_an_account,
                    style: FontHelper.fontText(
                        size: 13.sp,
                        weight: FontWeight.w600,
                        color: Colors.white),
                    children: [
                      TextSpan(
                        text: ' ${S.of(context).login}',
                        style: FontHelper.fontText(
                          size: 13.sp,
                          weight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  )),
                ],
              )),
          Positioned(
            top: size.height * 0.185,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyTextFormField(
                                width: size.width * 0.395,
                                hint: S.of(context).first_name,
                                textInputType: TextInputType.name,
                              ),
                              MyTextFormField(
                                width: size.width * 0.395,
                                hint: S.of(context).last_name,
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 13.h),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).email,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 13.h),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).birthday,
                          suffIcon: Iconsax.calendar_1,
                          textInputType: TextInputType.datetime,
                        ),
                        SizedBox(height: 13.h),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).phone,
                          textInputType: TextInputType.phone,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '+20',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Container(
                                width: 1,
                                height: 18.h,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 13.h),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).password,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 13.h),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).confirm_password,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 15.h),
                        MyButton1(
                          buttonTitle: S.of(context).create_account,
                          height: 42.h,
                          width: size.width * 0.8,
                        ),
                        SizedBox(height: 13.h),
                        MyOrDevider(size: size.width * 0.02),
                        SizedBox(height: 13.h),
                        SizedBox(
                          width: size.width * 0.8,
                          child: MyButton2(),
                        )
                      ],
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
