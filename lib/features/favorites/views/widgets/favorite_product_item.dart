import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/add_to_card_and_delete_from_favorite.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductItem extends StatelessWidget {
  final FavoriteItemModel product;

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
              color: Colors.grey.withValues(alpha: 0.4),
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
                    imageUrl: HelperFunctions.fixGoogleDriveUrl(product.photo),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/home_page/no_image_placeholder.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 140.h,
                    ),
                    imageBuilder: (context, imageProvider) {
                      final devicePixelRatio =
                          MediaQuery.of(context).devicePixelRatio;
                      final targetHeight = 120.h;
                      final targetWidth =
                          MediaQuery.of(context).size.width / 3.w;

                      return Image(
                        image: ResizeImage(
                          imageProvider,
                          width: (targetWidth * devicePixelRatio).toInt(),
                          height: (targetHeight * devicePixelRatio).toInt(),
                        ),
                        fit: BoxFit.scaleDown,
                        width: double.infinity,
                        height: targetHeight,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                product.name,
                style: FontHelper.fontText(
                    context: context,
                    size: 13.sp,
                    weight: FontWeight.w700,
                    color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                '${product.price} ${S.of(context).egyption_currency}',
                style: FontHelper.fontText(
                  context: context,
                  size: 16.sp,
                  weight: FontWeight.w800,
                  color: MyColor.kellyGreen3,
                ),
              ),
              Spacer(),
              AddToCardAndDeleteFromFavorite(productItem: product),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
