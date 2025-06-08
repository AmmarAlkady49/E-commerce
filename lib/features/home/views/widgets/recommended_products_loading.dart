import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/widgets/product_item_loading.dart';

class RecommendedProductsLoading extends StatelessWidget {
  const RecommendedProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Shimmer.fromColors(
        direction: HelperFunctions.isArabic(context)
            ? ShimmerDirection.rtl
            : ShimmerDirection.ltr,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${S.of(context).recommended_for_you} :",
                style: FontHelper.fontText(
                    size: 17.sp,
                    weight: FontWeight.w800,
                    color: Colors.black,
                    context: context)),
            SizedBox(height: 12.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                mainAxisExtent: 230.h,
                crossAxisCount: 2,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => ProductItemLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
