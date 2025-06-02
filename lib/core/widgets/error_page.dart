import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated error image
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.0),
              duration: const Duration(seconds: 1),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/other/404_error.png',
                height: 220.h,
              ),
            ),

            SizedBox(height: 24.h),

            // Error title
            Text(
              S.of(context).something_went_wrong,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                size: 20.sp,
                weight: FontWeight.bold,
                color: Colors.black,
                context: context,
              ),
            ),

            SizedBox(height: 12.h),

            // Error description
            Text(
              S.of(context).error_description,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                size: 14.sp,
                weight: FontWeight.normal,
                color: Colors.black54,
                context: context,
              ),
            ),

            SizedBox(height: 32.h),

            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.bottomNavBar, (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColor.kellyGreen3.withAlpha(40),
                foregroundColor: Colors.white,
                minimumSize: Size(200.w, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 2,
              ),
              icon: Icon(
                Iconsax.back_square,
                size: 20.sp,
                color: MyColor.kellyGreen3,
              ),
              label: Text(
                S.of(context).back,
                style: FontHelper.fontText(
                  size: 16.sp,
                  weight: FontWeight.w700,
                  color: MyColor.kellyGreen3,
                  context: context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
