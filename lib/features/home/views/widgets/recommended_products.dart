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
        Row(
          children: [
            // Text(S.of(context).recommended_for_you,
            //     style: FontHelper.fontText(
            //         size: 17.sp,
            //         weight: FontWeight.w800,
            //         color: Colors.black,
            //         context: context)),
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
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff53B175).withAlpha(30),
                    Color(0xff53B175).withAlpha(10),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Color(0xff53B175).withAlpha(100),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).see_all,
                    style: FontHelper.fontText(
                      size: 12.sp,
                      weight: FontWeight.w600,
                      color: Color(0xff53B175),
                      context: context,
                    ),
                  ),
                ],
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
