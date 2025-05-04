import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLostConnectionWidget extends StatelessWidget {
  const BuildLostConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/other/disconnect.gif', height: 200.h),
            SizedBox(height: 8.h),
            Text(
              S.of(context).lost_connection,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                  context: context,
                  size: 17.sp,
                  weight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
