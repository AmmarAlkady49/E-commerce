import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GridViewForCategoriesLoading extends StatelessWidget {
  const GridViewForCategoriesLoading({super.key});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${S.of(context).shop_by_category} :",
                    style: FontHelper.fontText(
                        size: 17.sp,
                        weight: FontWeight.w800,
                        color: Colors.black,
                        context: context)),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
                height: 100.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: 70.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  'assets/images/categories/Baby supplies.png'),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Shimmer.fromColors(
                          direction: HelperFunctions.isArabic(context)
                              ? ShimmerDirection.rtl
                              : ShimmerDirection.ltr,
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 80.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
