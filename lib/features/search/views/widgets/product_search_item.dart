import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSearchItem extends StatelessWidget {
  final ProductResponse product;
  final HomeCubit homeCubit;
  const ProductSearchItem({
    super.key,
    required this.homeCubit,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: EdgeInsets.all(8),
                child: product.photos != null && product.photos!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: HelperFunctions.fixGoogleDriveUrl(
                            product.photos!.first.imageURL!),
                        fit: BoxFit.contain,
                        height: 140.h,
                        width: double.infinity,
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/images/home_page/no_image_placeholder.png',
                              fit: BoxFit.contain,
                              height: 140.h,
                              width: double.infinity,
                            ))
                    : Image.asset(
                        'assets/images/home_page/no_image_placeholder.png',
                        fit: BoxFit.contain,
                        height: 140.h,
                        width: double.infinity,
                      ),
              ),
              Positioned(
                top: 8,
                right: 8,
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
                      return CupertinoActivityIndicator(color: Colors.black);
                    }
                    bool isFav = state is SetFavoriteSuccess
                        ? state.isFavorite
                        : product.isFavorite ?? false;

                    return InkWell(
                      onTap: () {
                        homeCubit.setFavortie(product.productID.toString());
                      },
                      borderRadius: BorderRadius.circular(13.r),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            isFav ? Icons.favorite : CupertinoIcons.heart,
                            color: isFav ? Colors.red.shade600 : Colors.black87,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            product.name ?? 'Item not found',
            style: FontHelper.fontText(
              context: context,
              size: 14.sp,
              weight: FontWeight.w700,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            product.categoryName ?? 'other',
            textAlign: TextAlign.center,
            style: FontHelper.fontText(
                context: context,
                size: 12.sp,
                weight: FontWeight.w600,
                color: Colors.black45),
          ),
          const SizedBox(height: 4),
          Text(
            '${product.price} ${S.of(context).egyption_currency}',
            style: FontHelper.fontText(
              context: context,
              size: 16.sp,
              weight: FontWeight.w700,
              color: Colors.green.shade700,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.green, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                product.rating != null
                    ? '${product.rating.toString()} (${product.reviewCount.toString()})'
                    : S.of(context).no_reatings,
                style: FontHelper.fontText(
                  context: context,
                  size: 12.sp,
                  weight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
