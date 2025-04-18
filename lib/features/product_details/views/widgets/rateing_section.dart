import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class RateingSection extends StatelessWidget {
  final ProductResponse product;
  const RateingSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: Localizations.localeOf(context).languageCode == 'ar'
      //     ? MainAxisSize.min
      //     : MainAxisSize.max,
      children: Localizations.localeOf(context).languageCode == 'ar'
          ? [
              Icon(
                CupertinoIcons.star_fill,
                color: Colors.yellow.shade600,
                size: 18.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                product.rating.toString(),
                style: FontHelper.fontText(
                  size: 16.sp,
                  weight: FontWeight.w800,
                  color: Colors.black,
                  context: context,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "(${product.reviewCount} ${S.of(context).reviews})",
                style: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w500,
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
              SizedBox(width: 2.w),
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
    );
  }
}
