import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/product_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedProducts extends StatelessWidget {
  final List<ProductResponse> products;
  const RecommendedProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).recommended_for_you,
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w800,
                color: Colors.black87,
                context: context,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 3.h,
              width: 40.w * 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff53B175),
                    Color(0xff53B175).withAlpha(100),
                  ],
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            mainAxisExtent: 240.h,
            crossAxisCount: 2,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) =>
              ProductItem(product: products[index]),
        ),
      ],
    );
  }
}
