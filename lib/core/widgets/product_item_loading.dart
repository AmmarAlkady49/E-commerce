import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemLoading extends StatelessWidget {
  const ProductItemLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 125.h,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/home_page/no_image_placeholder.png',
                        fit: BoxFit.contain,
                        height: 140.h,
                        width: double.infinity,
                        cacheHeight: 357,
                        cacheWidth: 422,
                      )),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    'Item not found',
                    style: FontHelper.fontText(
                        context: context,
                        size: 14.sp,
                        weight: FontWeight.w700,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'other',
                  textAlign: TextAlign.center,
                  style: FontHelper.fontText(
                      context: context,
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black45),
                ),
                const SizedBox(height: 4),
                Text(
                  '0.00 EGP',
                  style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w800,
                    color: MyColor.kellyGreen3,
                  ),
                ),
              ],
            ),
            Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                        onTap: () async {},
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Colors.black87,
                          size: 20.sp,
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
