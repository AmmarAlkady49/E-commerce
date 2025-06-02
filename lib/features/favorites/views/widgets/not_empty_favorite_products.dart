import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/widgets/empty_search.dart';
import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/favorite_product_item.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/search_section_for_favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            BlocConsumer<FavoritesCubit, FavoritesState>(
              listenWhen: (previous, current) =>
                  current is FavoriteProductsError ||
                  current is AddProductToCartError,
              buildWhen: (previous, current) =>
                  current is FavoriteProductsLoading ||
                  current is FavoriteProductsLoaded ||
                  current is FavoriteProductsError ||
                  current is SearchFavoriteProductEmpty,
              listener: (context, state) {
                if (state is FavoriteProductsError ||
                    state is AddProductToCartError) {
                  Navigator.pushNamed(context, AppRoutes.tooManyRequestPage);
                }
              },
              builder: (context, state) {
                if (state is FavoriteProductsError ||
                    state is AddProductToCartError) {
                  return ErrorPage();
                }
                if (state is SearchFavoriteProductEmpty) {
                  return EmptySearch();
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
