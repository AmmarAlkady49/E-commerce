import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/auth/views/widgets/container_of_the_signin_widget.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Stack(
                  children: [
                    // Background image
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.6,
                      child: SvgPicture.asset(
                        'assets/images/auth/background1.svg',
                        fit: BoxFit.fill,
                      ),
                    ),

                    // Language switcher button
                    Positioned(
                      top: 54.h,
                      // left: 24.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: InkWell(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            String presentLang = pref.getString('lang') ?? 'ar';
                            pref.setString(
                                'lang', presentLang == 'ar' ? 'en' : 'ar');
                            Restart.restartApp();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.of(context).english,
                                style: FontHelper.fontText(
                                  size: 16.sp,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                  context: context,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Main content column
                    Column(
                      children: [
                        SizedBox(height: size.height * 0.16),
                        // Sign in title
                        Text(
                          S.of(context).sign_in,
                          textAlign: TextAlign.center,
                          style: FontHelper.fontText(
                            size: 36.sp,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            context: context,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // Subtitle
                        Text(
                          S.of(context).enter_your_email_and_password,
                          style: FontHelper.fontText(
                            size: 15.sp,
                            weight: FontWeight.w400,
                            color: Colors.white,
                            context: context,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        // Sign in form
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ContainerOfTheSigninWidget(),
                        ),
                        // Spacer to push content up
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
