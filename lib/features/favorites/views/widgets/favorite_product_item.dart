import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/add_to_card_and_delete_from_favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductItem extends StatelessWidget {
  final ProductItemModel product;

  const FavoriteProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
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
              Text(
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
              SizedBox(height: 2.h),
              Text(
                "${product.price.toString()}\$",
                style: FontHelper.fontText(
                    context: context,
                    size: 18.sp,
                    weight: FontWeight.w800,
                    color: Colors.red.shade600),
              ),
              SizedBox(height: 2.h),
              // Spacer(),
              AddToCardAndDeleteFromFavorite(productItem: product),
            ],
          ),
        ),
      ),
    );
  }
}
