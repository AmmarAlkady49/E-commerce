import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/auth/views/widgets/container_of_the_signin_widget.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
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
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 54.h),
          //     child: InkWell(
          //       onTap: () async {
          //         SharedPreferences pref =
          //             await SharedPreferences.getInstance();
          //         String presentLang = pref.getString('lang') ?? 'ar';
          //         pref.setString('lang', presentLang == 'ar' ? 'en' : 'ar');

          //         // Phoenix.rebirth(context);
          //       },
          //       child: Text(S.of(context).english,
          //           style: FontHelper.fontText(
          //               size: 16.sp,
          //               weight: FontWeight.w600,
          //               color: Colors.white,
          //               decoration: TextDecoration.underline)),
          //     ),
          //   ),
          // ),
          Positioned(
            top: size.height * 0.4,
            left: 0,
            right: 0,
            bottom: size.height * 0.05,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ContainerOfTheSigninWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
