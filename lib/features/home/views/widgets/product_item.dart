import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final ProductResponse product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productPage,
          arguments: product,
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 125.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    product.title ?? 'Item not found',
                    style: FontHelper.fontText(
                        context: context,
                        size: 14.sp,
                        weight: FontWeight.w600,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  product.category!.name ?? 'Othersss',
                  style: FontHelper.fontText(
                      context: context,
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black45),
                ),
                Text(
                  "${product.price.toString()}\$",
                  style: FontHelper.fontText(
                      context: context,
                      size: 18.sp,
                      weight: FontWeight.w800,
                      color: Colors.red.shade700),
                ),
              ],
            ),
            Positioned(
                top: 8.h,
                right: 8.w,
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  bloc: favoriteCubit,
                  buildWhen: (previous, current) =>
                      current is FavoriteItemLoading ||
                      current is FavoriteItemLoaded,
                  builder: (context, state) {
                    if (state is FavoriteItemLoading &&
                        state.productId == product.id) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                            onTap: () async {
                              await favoriteCubit.setFavoriteItem(product);
                            },
                            child: ((state is FavoriteItemLoaded &&
                                    state.productId == product.id))
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20.sp,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.black,
                                    size: 20.sp,
                                  )),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
