import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListViewWidget extends StatefulWidget {
  const CategoryListViewWidget({super.key});

  @override
  State<CategoryListViewWidget> createState() => _CategoryListViewWidgetState();
}

int selectedIndex = 0;

class _CategoryListViewWidgetState extends State<CategoryListViewWidget> {
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final categoriesList = context.read<HomeCubit>().categoriesList;
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          itemCount: 12,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<HomeCubit>().selectedCategoryIndex = index;
                context.read<HomeCubit>().setSelectedCategoryIndex(index);
                setState(() {
                  selectedIndex = index;
                });
                context.read<HomeCubit>().getProductsByCategory(
                    categoriesList[index].categoryCode,
                    query: context.read<HomeCubit>().currentSearchQuery);
              },
              child: buildCategoryItem(
                categoriesList[index].name,
                isSelected: selectedIndex == index,
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildCategoryItem(String categoryName,
    {required bool isSelected, required BuildContext context}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 5.h),
            child: Text(
              categoryName,
              style: FontHelper.fontText(
                context: context,
                size: 14.sp,
                weight: FontWeight.w700,
                color: isSelected ? MyColor.kellyGreen2 : Colors.black54,
              ),
            ),
          ),
          // The underline
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2.5,
            width: isSelected ? _calculateTextWidth(categoryName, context) : 0,
            color: MyColor.kellyGreen2,
          ),
        ],
      ),
    ],
  );
}

/// Helper function to calculate text width
double _calculateTextWidth(String text, BuildContext context) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: FontHelper.fontText(
        context: context,
        size: 14.sp,
        weight: FontWeight.w700,
        color: Colors.black, // color here doesn't affect width
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
