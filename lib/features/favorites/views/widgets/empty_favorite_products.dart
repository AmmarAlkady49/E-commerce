import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyFavoriteProducts extends StatelessWidget {
  const EmptyFavoriteProducts({super.key});

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
              CupertinoIcons.heart,
              size: 55.sp,
              color: Colors.black,
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).no_favorite_item,
              style: FontHelper.fontText(
                  context: context,
                  size: 22.sp,
                  weight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).you_can_add_items,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                  context: context,
                  size: 16.sp,
                  // isItalic: true,
                  weight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
