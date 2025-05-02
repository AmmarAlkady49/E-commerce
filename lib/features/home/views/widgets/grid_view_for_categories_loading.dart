import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GridViewForCategoriesLoading extends StatelessWidget {
  const GridViewForCategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250.h,
        child: Shimmer.fromColors(
          direction: HelperFunctions.isArabic(context)
              ? ShimmerDirection.rtl
              : ShimmerDirection.ltr,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (_, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 80.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
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
                        child: Image.asset(''),
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
          ),
        ));
  }
}
