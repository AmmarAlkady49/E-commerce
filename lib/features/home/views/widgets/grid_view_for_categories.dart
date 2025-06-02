import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewForCategories extends StatelessWidget {
  final List<Map<String, String>> categories;
  const GridViewForCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).shop_by_category,
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
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Color(0xff53B175).withAlpha(30),
            //         Color(0xff53B175).withAlpha(10),
            //       ],
            //     ),
            //     borderRadius: BorderRadius.circular(20.r),
            //     border: Border.all(
            //       color: Color(0xff53B175).withAlpha(100),
            //       width: 1,
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text(
            //         S.of(context).see_all,
            //         style: FontHelper.fontText(
            //           size: 12.sp,
            //           weight: FontWeight.w600,
            //           color: Color(0xff53B175),
            //           context: context,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 230.h,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.productsByCategoryPage,
                        arguments: {
                          'categoryCode': categories[index]['categoryCode'],
                          'categoryCode2': categories[index]['categoryCode2'],
                          'categoryName': categories[index]['name'],
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 80.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: MyColor.seasalt,
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          categories[index]['imageUrl'] ?? "",
                          fit: BoxFit.contain,
                          cacheHeight: 220,
                          cacheWidth: 207,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    categories[index]['name'] ?? "مجهول",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: FontHelper.fontText(
                      size: 12.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                      context: context,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
