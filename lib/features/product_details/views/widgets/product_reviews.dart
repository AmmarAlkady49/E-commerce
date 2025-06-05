import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ProductReviews extends StatelessWidget {
  final ProductResponse product;
  final ProductDetailsCubit productDetailsCubit;

  const ProductReviews(
      {super.key, required this.product, required this.productDetailsCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBarDefaultTheme(
        title: S.of(context).product_reviews,
        needLeadingButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Section
            _buildOverallRatingSection(context),
            SizedBox(height: 24.h),

            // Add Review Button
            writeRate(context, product),
            SizedBox(height: 24.h),

            // Reviews List
            _buildReviewsSection(context),
          ],
        ),
      ),
    );
  }

  GestureDetector writeRate(BuildContext context, ProductResponse product) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
            context, AppRoutes.addReviewPage,
            arguments: {
              "product": product,
              "productDetailsCubit": productDetailsCubit,
            });

        if (result == true) {
          // Refresh the reviews manually
          await productDetailsCubit.getProductDetails(product.productID!);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColor.kellyGreen3,
              MyColor.kellyGreen3.withAlpha(180),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: MyColor.kellyGreen3.withAlpha(50),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                // Icons.rate_review,
                Iconsax.edit_2,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              S.of(context).write_a_review,
              style: FontHelper.fontText(
                size: 14.sp,
                weight: FontWeight.w700,
                color: Colors.white,
                context: context,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRatingSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.kellyGreen3.withAlpha(20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: MyColor.kellyGreen3.withAlpha(60),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Rating Stars and Number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).overall_rating,
                  style: FontHelper.fontText(
                    size: 16.sp,
                    weight: FontWeight.w600,
                    color: Colors.black87,
                    context: context,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      "${product.rating?.toStringAsFixed(1)}",
                      style: FontHelper.fontText(
                        size: 28.sp,
                        weight: FontWeight.w800,
                        color: Colors.black87,
                        context: context,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber.shade600,
                      size: 24.sp,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "${S.of(context).based_on} ${product.reviewCount ?? 0} ${S.of(context).reviews}",
                  style: FontHelper.fontText(
                    size: 12.sp,
                    weight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    context: context,
                  ),
                ),
              ],
            ),
          ),

          // Star Rating Display
          Column(
            children: List.generate(5, (index) {
              double rating = product.rating?.toDouble() ?? 0.0;
              if (index < rating.floor()) {
                return Icon(
                  Icons.star_rounded,
                  color: Colors.amber.shade600,
                  size: 24.sp,
                );
              } else if (index < rating) {
                return Icon(
                  Icons.star_half_rounded,
                  color: Colors.amber.shade600,
                  size: 24.sp,
                );
              } else {
                return Icon(
                  Icons.star_outline_rounded,
                  color: Colors.grey.shade400,
                  size: 24.sp,
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    if (product.reviews == null || product.reviews!.isEmpty) {
      return _buildNoReviewsWidget(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: MyColor.kellyGreen3,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              "${S.of(context).all_reviews} (${product.reviews!.length})",
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.black87,
                context: context,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.reviews!.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final review = product.reviews![index];
            return _buildReviewCard(context, review);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Info and Rating
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20.r,
                backgroundColor: MyColor.kellyGreen3.withAlpha(100),
                child: Text(
                  review.name != null && review.name!.isNotEmpty
                      ? review.name![0].toUpperCase()
                      : 'U',
                  style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    context: context,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name ?? S.of(context).anonymous_user,
                      style: FontHelper.fontText(
                        size: 14.sp,
                        weight: FontWeight.w600,
                        color: Colors.black87,
                        context: context,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _formatDate(review.reviewDate),
                      style: FontHelper.fontText(
                        size: 11.sp,
                        weight: FontWeight.w400,
                        color: Colors.grey.shade600,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Stars
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  int rating = review.rating ?? 0;
                  if (index < rating) {
                    return Icon(
                      Icons.star_rounded,
                      color: Colors.amber.shade600,
                      size: 14.sp,
                    );
                  } else {
                    return Icon(
                      Icons.star_outline_rounded,
                      color: Colors.grey.shade400,
                      size: 14.sp,
                    );
                  }
                }),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review Text
          if (review.reviewText != null && review.reviewText!.isNotEmpty)
            Text(
              review.reviewText!,
              style: FontHelper.fontText(
                size: 13.sp,
                weight: FontWeight.w400,
                color: Colors.black87,
                context: context,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNoReviewsWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            S.of(context).no_reviews_yet,
            style: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w600,
              color: Colors.grey.shade600,
              context: context,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            S.of(context).be_first_to_review,
            style: FontHelper.fontText(
              size: 12.sp,
              weight: FontWeight.w400,
              color: Colors.grey.shade500,
              context: context,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
