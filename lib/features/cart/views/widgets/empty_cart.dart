import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Icon(
              Iconsax.shopping_bag,
              size: 55.sp,
              color: Colors.black,
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).your_cart_is_empty,
              style: FontHelper.fontText(
                  size: 22.sp,
                  weight: FontWeight.bold,
                  color: Colors.black,
                  context: context),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).looks_like_you_havent_added,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: Colors.black45,
                  context: context),
            ),
          ],
        ),
      ),
    );
  }
}
