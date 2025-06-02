import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateingSection extends StatelessWidget {
  final ProductResponse product;
  const RateingSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: MyColor.kellyGreen3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              S.of(context).rating,
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.black87,
                context: context,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: MyColor.kellyGreen3.withAlpha(40),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: MyColor.kellyGreen3.withAlpha(100),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: product.rating == null
                ? [
                    Icon(
                      Icons.star_outline_rounded,
                      color: Colors.grey.shade500,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      S.of(context).no_reatings,
                      style: FontHelper.fontText(
                        context: context,
                        size: 13.sp,
                        weight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ]
                : [
                    ...List.generate(5, (index) {
                      double rating = product.rating?.toDouble() ?? 0.0;
                      if (index < rating.floor()) {
                        return Icon(
                          Icons.star_rounded,
                          color: Colors.amber.shade600,
                          size: 16.sp,
                        );
                      } else if (index < rating) {
                        return Icon(
                          Icons.star_half_rounded,
                          color: Colors.amber.shade600,
                          size: 16.sp,
                        );
                      } else {
                        return Icon(
                          Icons.star_outline_rounded,
                          color: Colors.grey.shade400,
                          size: 16.sp,
                        );
                      }
                    }),
                    SizedBox(width: 8.w),
                    Text(
                      "${product.rating?.toStringAsFixed(1)}",
                      style: FontHelper.fontText(
                        size: 15.sp,
                        weight: FontWeight.w700,
                        color: Colors.black87,
                        context: context,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "(${product.reviewCount} ${S.of(context).reviews})",
                      style: FontHelper.fontText(
                        size: 12.sp,
                        weight: FontWeight.w500,
                        color: Colors.grey.shade600,
                        context: context,
                      ),
                    ),
                  ],
          ),
        ),
      ],
    );
  }
}
