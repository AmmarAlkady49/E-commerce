import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/favorite_product_item.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/search_section_for_favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class NotEmptyFavoriteProducts extends StatelessWidget {
  final List<FavoriteItemModel> favoriteProducts;
  const NotEmptyFavoriteProducts({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            SearchSectionForFavoritePage(),
            SizedBox(height: 18.h),
            BlocBuilder<FavoritesCubit, FavoritesState>(
              buildWhen: (previous, current) =>
                  current is FavoriteProductsLoading ||
                  current is FavoriteProductsLoaded ||
                  current is FavoriteProductsError ||
                  current is SearchFavoriteProductEmpty,
              builder: (context, state) {
                if (state is SearchFavoriteProductEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.h),
                      Icon(Iconsax.close_circle,
                          size: 50.sp, color: MyColor.poppy),
                      SizedBox(height: 4.h),
                      Text(
                        state.message,
                        style: FontHelper.fontText(
                            context: context,
                            size: 20.sp,
                            weight: FontWeight.w700,
                            color: Colors.black87),
                      ),
                    ],
                  );
                } else if (state is FavoriteProductsLoaded) {
                  final favorites = state.favoriteProducts;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      mainAxisExtent: 260.h,
                      crossAxisCount: 2,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) =>
                        FavoriteProductItem(product: favorites[index]),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
