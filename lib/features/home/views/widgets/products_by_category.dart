import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/custom_app_bar_for_category_products.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/product_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryCode;
  final String? categoryCode2;
  final String categoryName;
  const ProductsByCategory(
      {super.key,
      required this.categoryCode,
      this.categoryCode2,
      required this.categoryName});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeCubit>(context).getProductsByCategoryForHomePage(
        widget.categoryCode, widget.categoryCode2);
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: CustomAppBarForCategoryProducts(
          categoryCode: widget.categoryCode,
          categoryCode2: widget.categoryCode2),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is GetProductsByCategoryForHomePageLoading ||
            current is GetProductsByCategoryForHomePageError ||
            current is GetProductsByCategoryForHomePage,
        listener: (context, state) {
          if (state is GetProductsByCategoryForHomePageError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: FontHelper.fontText(
                    size: 15.sp,
                    weight: FontWeight.w600,
                    color: Colors.white,
                    context: context),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ));
          }
        },
        builder: (context, state) {
          if (state is GetProductsByCategoryForHomePageLoading) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (state is GetProductsByCategoryForHomePageError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is GetProductsByCategoryForHomePage) {
            final products = state.products;
            if (products.isEmpty) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity),
                  SizedBox(height: 200.h),
                  Icon(
                    Icons.search_off_outlined,
                    size: 50.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    S.current.no_products_found,
                    style: FontHelper.fontText(
                        context: context,
                        size: 20.sp,
                        weight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                    child: Text(
                      widget.categoryName,
                      style: FontHelper.fontText(
                          context: context,
                          size: 20.sp,
                          color: Colors.black,
                          weight: FontWeight.w700),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      mainAxisExtent: 240.h,
                      crossAxisCount: 2,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) => ProductItem(
                      product: state.products[index],
                      isForCategoroesProducts: true,
                      categoryCode: widget.categoryCode,
                      categoryCode2: widget.categoryCode2,
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
