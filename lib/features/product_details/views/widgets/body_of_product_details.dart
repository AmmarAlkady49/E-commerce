import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
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
          // color: Color(0xfffefffe),
          color: MyColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 18.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              // textAlign: TextAlign.end,
                              style: FontHelper.fontText(
                                size: 17.sp,
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
                                size: 17.sp,
                                weight: FontWeight.w700,
                                color: Colors.black,
                                context: context,
                              ),
                            ),
                          ),
                          CounterPlusMinus(),
                        ],
                ),
                SizedBox(height: 16.h),
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
