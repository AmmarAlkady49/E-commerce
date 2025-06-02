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
                : homeCubit.getRecommendedProducts());
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(30),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                _buildImageSection(),
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

                SizedBox(height: 6.h),

                // category section
                _buildCategorySection(context),

                const SizedBox(height: 4),
                // price section

                Text(
                  '${product.price} ${S.of(context).egyption_currency}',
                  style: FontHelper.fontText(
                    context: context,
                    size: 17.sp,
                    weight: FontWeight.w800,
                    color: MyColor.kellyGreen3,
                  ),
                ),
                // SizedBox(height: 6.h),
              ],
            ),
            _buildFavoriteButton(homeCubit),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        product.categoryName ?? 'other',
        style: FontHelper.fontText(
          context: context,
          size: 11.sp,
          weight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  SizedBox _buildImageSection() {
    return SizedBox(
      height: 130.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: product.photos?.isEmpty ?? true
            ? Image.asset(
                'assets/images/home_page/no_image_placeholder.png',
                fit: BoxFit.contain,
              )
            : CachedNetworkImage(
                imageUrl: HelperFunctions.fixGoogleDriveUrl(
                    product.photos!.first.imageURL!),
                fit: BoxFit.contain,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/home_page/no_image_placeholder.png',
                  fit: BoxFit.contain,
                ),
                imageBuilder: (context, imageProvider) {
                  final devicePixelRatio =
                      MediaQuery.of(context).devicePixelRatio;
                  final targetHeight = 120.h;
                  final targetWidth = MediaQuery.of(context).size.width / 3.w;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: ResizeImage(
                          imageProvider,
                          width: (targetWidth * devicePixelRatio).toInt(),
                          height: (targetHeight * devicePixelRatio).toInt(),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildFavoriteButton(HomeCubit homeCubit) {
    return Positioned(
      top: 12.h,
      right: 12.w,
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
          return GestureDetector(
            onTap: () async {
              await homeCubit.setFavortie(product.productID.toString());
            },
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(230),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildFavoriteIcon(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteIcon(HomeState state) {
    if (state is SetFavoriteLoading) {
      return Center(
        child: CupertinoActivityIndicator(
          radius: 8.r,
          color: Colors.grey.shade600,
        ),
      );
    }

    bool isFavorite = false;
    if (state is SetFavoriteSuccess) {
      isFavorite = state.isFavorite;
    } else {
      isFavorite = product.isFavorite ?? false;
    }

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          color: isFavorite ? Colors.red.shade600 : Colors.grey.shade600,
          size: 20.sp,
        ),
      ),
    );
  }
}
