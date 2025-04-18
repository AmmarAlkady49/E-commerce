import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/counter_plus_minus.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/description_widget.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/rateing_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyOfProductDetails extends StatelessWidget {
  final ProductResponse product;
  const BodyOfProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfffefffe),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 24.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: double.infinity),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Localizations.localeOf(context).languageCode == 'en'
                      ? [
                          CounterPlusMinus(),
                          // Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55.w,
                            child: Text(
                              product.name!,
                              textAlign: TextAlign.right,
                              style: FontHelper.fontText(
                                size: 18.sp,
                                weight: FontWeight.w700,
                                color: Colors.black,
                                context: context,
                              ),
                            ),
                          ),
                        ]
                      : [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55.w,
                            child: Text(
                              product.name!,
                              style: FontHelper.fontText(
                                size: 18.sp,
                                weight: FontWeight.w700,
                                color: Colors.black,
                                context: context,
                              ),
                            ),
                          ),
                          CounterPlusMinus(),
                        ],
                ),
                SizedBox(height: 8.h),
                RateingSection(product: product),
                SizedBox(height: 4.h),
                DescriptionWidget(description: product.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
