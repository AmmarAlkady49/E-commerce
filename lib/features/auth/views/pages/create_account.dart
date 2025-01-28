import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/auth/views/widgets/container_of_the_create_acount.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              top: size.height * 0.068,
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
                        size: 15.sp,
                        weight: FontWeight.w600,
                        color: Colors.white),
                    children: [
                      TextSpan(
                        text: ' ${S.of(context).login2}',
                        style: FontHelper.fontText(
                          size: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  )),
                ],
              )),
          Positioned(
            top: size.height * 0.187,
            left: 0,
            right: 0,
            bottom: size.height * 0.05,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ContainerOfTheCreateAcount(),
            ),
          ),
        ],
      ),
    );
  }
}
