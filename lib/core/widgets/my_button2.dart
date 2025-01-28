import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton2 extends StatelessWidget {
  const MyButton2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(11.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/auth/google.png',
              height: 23.h,
              width: 23.w,
            ),
            SizedBox(width: 8.w),
            Text(S.of(context).sign_up_with_google,
                style: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
