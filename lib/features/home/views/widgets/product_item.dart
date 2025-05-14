import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final ProductResponse product;
  final bool isForCategoroesProducts;
  final String? categoryCode;
  final String? categoryCode2;
  const ProductItem({
    super.key,
    required this.product,
    this.isForCategoroesProducts = false,
    this.categoryCode,
    this.categoryCode2,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
              AppRoutes.productPage,
              arguments: product,
            )
            .then((value) => isForCategoroesProducts
                ? homeCubit.getProductsByCategoryForHomePage(
                    categoryCode!, categoryCode2!)
                : homeCubit.getAllProducts());
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
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: product.photos!.isEmpty || product.photos == null
                          ? Image.asset(
                              'assets/images/home_page/no_image_placeholder.png',
                              fit: BoxFit.contain,
                              height: 140.h,
                              width: double.infinity,
                              cacheHeight: 357,
                              cacheWidth: 422,
                            )
                          : CachedNetworkImage(
                              imageUrl: HelperFunctions.fixGoogleDriveUrl(
                                  product.photos!.first.imageURL!),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/home_page/no_image_placeholder.png',
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 140.h,
                              ),
                              imageBuilder: (context, imageProvider) {
                                final devicePixelRatio =
                                    MediaQuery.of(context).devicePixelRatio;
                                final targetHeight = 100.h;
                                final targetWidth =
                                    MediaQuery.of(context).size.width / 4.w;

                                return Image(
                                  image: ResizeImage(
                                    imageProvider,
                                    width: (targetWidth * devicePixelRatio)
                                        .toInt(),
                                    height: (targetHeight * devicePixelRatio)
                                        .toInt(),
                                  ),
                                  fit: BoxFit.scaleDown,
                                  width: double.infinity,
                                  height: targetHeight,
                                );
                              },
                            )),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    product.name ?? 'Item not found',
                    style: FontHelper.fontText(
                        context: context,
                        size: 14.sp,
                        weight: FontWeight.w700,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  product.categoryName ?? 'other',
                  textAlign: TextAlign.center,
                  style: FontHelper.fontText(
                      context: context,
                      size: 14.sp,
                      weight: FontWeight.w600,
                      color: Colors.black45),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.price} ${S.of(context).egyption_currency}',
                  style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w800,
                    color: MyColor.kellyGreen3,
                  ),
                ),
              ],
            ),
            Positioned(
                top: 10.h,
                right: 10.w,
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen: (previous, current) =>
                      (current is SetFavoriteLoading &&
                          product.productID.toString() == current.productId) ||
                      (current is SetFavoriteSuccess &&
                          product.productID.toString() == current.productId) ||
                      (current is SetFavoriteError &&
                          product.productID.toString() == current.productId),
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
                                      await homeCubit.setFavortie(
                                          product.productID.toString());
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
                                      await homeCubit.setFavortie(
                                          product.productID.toString());
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
                              await homeCubit
                                  .setFavortie(product.productID.toString());
                            },
                            child: product.isFavorite!
                                // child: true
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
