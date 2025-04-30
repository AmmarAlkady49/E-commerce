import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/grid_view_for_categories.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/recommended_products.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).shop_by_category,
                      style: FontHelper.fontText(
                          size: 17.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                          context: context)),
                  Text(S.of(context).see_all,
                      style: FontHelper.fontText(
                          size: 12.sp,
                          weight: FontWeight.w700,
                          color: Color(0xff1D61E7),
                          context: context)),
                ],
              ),
              SizedBox(height: 12.h),
              GridViewForCategories(),
              SizedBox(height: 12.h),
              RecommendedProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
