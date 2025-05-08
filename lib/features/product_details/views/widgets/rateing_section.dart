import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class RateingSection extends StatelessWidget {
  final ProductResponse product;
  const RateingSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.r),
      child: Row(
        // mainAxisSize: Localizations.localeOf(context).languageCode == 'ar'
        //     ? MainAxisSize.min
        //     : MainAxisSize.max,
        children: product.rating == null
            ? [
                Icon(Icons.star, color: MyColor.kellyGreen3, size: 18.sp),
                SizedBox(width: 4.w),
                Text(
                  S.of(context).no_reatings,
                  style: FontHelper.fontText(
                    context: context,
                    size: 13.5.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ]
            : Localizations.localeOf(context).languageCode == 'ar'
                ? [
                    Icon(Icons.star, color: MyColor.kellyGreen3, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text(
                      product.rating.toString(),
                      style: FontHelper.fontText(
                        context: context,
                        size: 16.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "(${product.reviewCount} ${S.of(context).reviews})",
                      style: FontHelper.fontText(
                        size: 14.sp,
                        weight: FontWeight.w600,
                        color: Colors.black54,
                        context: context,
                      ),
                    ),
                  ]
                : [
                    Icon(
                      Iconsax.star1,
                      color: Colors.yellow.shade600,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      product.rating.toString(),
                      style: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w800,
                        color: Colors.black,
                        context: context,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "(${product.reviewCount} reviews)",
                      style: FontHelper.fontText(
                        size: 14.sp,
                        weight: FontWeight.w500,
                        color: Colors.black54,
                        context: context,
                      ),
                    ),
                  ],
      ),
    );
  }
}
