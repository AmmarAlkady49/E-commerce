import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
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
                // SizedBox(height: 8.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 125.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: (product.image != null &&
                              product.image!.trim().isNotEmpty)
                          ? product.image!
                          : 'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
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
                SizedBox(height: 0.h),
                Text(
                  product.category ?? 'other',
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
                      color: Colors.red.shade600),
                ),
              ],
            ),
            Positioned(
                top: 8.h,
                right: 8.w,
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen: (previous, current) =>
                      (current is SetFavoriteLoading &&
                          product.id == current.productId) ||
                      (current is SetFavoriteSuccess &&
                          product.id == current.productId) ||
                      (current is SetFavoriteError &&
                          product.id == current.productId),
                  builder: (context, state) {
                    if (state is SetFavoriteLoading) {
                      return CupertinoActivityIndicator(
                        color: Colors.black,
                      );
                    } else if (state is SetFavoriteSuccess) {
                      return state.isFavorite
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: InkWell(
                                    onTap: () async {
                                      await homeCubit.setFavortie(product);
                                    },
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red.shade600,
                                      size: 20.sp,
                                    )),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: InkWell(
                                    onTap: () async {
                                      await homeCubit.setFavortie(product);
                                    },
                                    child: Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.black87,
                                      size: 20.sp,
                                    )),
                              ),
                            );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                            onTap: () async {
                              await homeCubit.setFavortie(product);
                            },
                            child: product.isFavorite!
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade600,
                                    size: 20.sp,
                                  )
                                : Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.black87,
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
