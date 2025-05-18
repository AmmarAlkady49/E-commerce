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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Background SVG
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        'assets/images/auth/background1.svg',
                        height: size.height * 0.6,
                        width: size.width,
                        fit: BoxFit.fill,
                      ),
                    ),

                    // Content
                    Column(
                      children: [
                        SizedBox(height: size.height * 0.068),
                        // Sign up text
                        Text(
                          S.of(context).sign_up,
                          style: FontHelper.fontText(
                            size: 36.sp,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            context: context,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // Already have an account text
                        Text.rich(
                          TextSpan(
                            text: S.of(context).already_have_an_account,
                            style: FontHelper.fontText(
                              size: 15.sp,
                              weight: FontWeight.w600,
                              color: Colors.white,
                              context: context,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${S.of(context).login2}',
                                style: FontHelper.fontText(
                                  size: 15.sp,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  context: context,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        // Form container
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ContainerOfTheCreateAcount(),
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
