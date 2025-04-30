import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewForCategories extends StatefulWidget {
  const GridViewForCategories({super.key});

  @override
  State<GridViewForCategories> createState() => _GridViewForCategoriesState();
}

class _GridViewForCategoriesState extends State<GridViewForCategories> {
  @override
  void initState() {
    super.initState();
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.getAllCategoriesForHomePage();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: homeCubit,
      listenWhen: (previous, current) =>
          current is GetProductsByCategoryForHomePageError ||
          current is GetProductsByCategoryForHomePage,
      listener: (context, state) {
        if (state is GetProductsByCategoryForHomePageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w700,
                  color: Colors.red,
                  context: context,
                ),
              ),
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is GetAllCategoriesForHomePageLoading ||
          current is GetAllCategoriesForHomePage ||
          current is GetAllCategoriesForHomePageError,
      builder: (context, state) {
        if (state is GetAllCategoriesForHomePageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllCategoriesForHomePageError) {
          return Center(
            child: Text(
              state.error,
              style: FontHelper.fontText(
                size: 14.sp,
                weight: FontWeight.w700,
                color: Colors.red,
                context: context,
              ),
            ),
          );
        }
        if (state is GetAllCategoriesForHomePage) {
          return SizedBox(
            height: 250.h,
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
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
                            'categoryCode': state.categories[index]
                                ['categoryCode'],
                            'categoryCode2': state.categories[index]
                                ['categoryCode2'],
                            'categoryName': state.categories[index]['name'],
                          },
                        );
                      },
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
                          child: CachedNetworkImage(
                            imageUrl: HelperFunctions.fixGoogleDriveUrl2(
                              state.categories[index]['imageUrl'] ??
                                  "https://drive.google.com/file/d/1_r-RddCnTVuo-8flYAfvWoRZdycyahKZ/view?usp=sharing",
                            ),
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      state.categories[index]['name'] ?? "مش عارف منين",
                      maxLines: 2,
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
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
