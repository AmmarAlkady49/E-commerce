import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/grid_view_for_categories.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/grid_view_for_categories_loading.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/image_slider.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/recommended_products.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/recommended_products_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      backgroundColor: MyColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: BlocConsumer<HomeCubit, HomeState>(
            bloc: homeCubit,
            listener: (context, state) {
              if ((state is GetProductsByCategoryForHomePageError &&
                      state.error == 'Too many requests') ||
                  (state is ErrorHomeProducts &&
                      state.error == 'Too many requests')) {
                Navigator.pushNamed(context, AppRoutes.tooManyRequestPage);
              }
            },
            listenWhen: (previous, current) =>
                current is GetProductsByCategoryForHomePageError ||
                current is ErrorHomeProducts,
            buildWhen: (previous, current) =>
                current is GetAllCategoriesForHomePageLoading ||
                current is GetAllCategoriesForHomePage ||
                current is GetAllCategoriesForHomePageError ||
                current is LoadingHomeProducts ||
                current is LoadedHomeProducts ||
                current is ErrorHomeProducts,
            builder: (context, state) {
              if (homeCubit.isLoading) {
                return Column(
                  children: [
                    SizedBox(height: 12.h),
                    ImageSlider(),
                    SizedBox(height: 12.h),
                    GridViewForCategoriesLoading(),
                    RecommendedProductsLoading(),
                  ],
                );
              }
              if (homeCubit.hasError) {
                return ErrorPage();
              } else if (homeCubit.homeProducts.isNotEmpty &&
                  homeCubit.homeCategories.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSlider(),
                    SizedBox(height: 18.h),
                    GridViewForCategories(categories: homeCubit.homeCategories),
                    SizedBox(height: 12.h),
                    RecommendedProducts(products: homeCubit.homeProducts),
                  ],
                );
              } else {
                return ErrorPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
