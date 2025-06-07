import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/models/product_reviews_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ProductReviews extends StatefulWidget {
  final ProductResponse product;
  final ProductDetailsCubit productDetailsCubit;

  const ProductReviews({
    super.key,
    required this.product,
    required this.productDetailsCubit,
  });

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  @override
  void initState() {
    super.initState();
    widget.productDetailsCubit.getProductReviews(widget.product.productID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBarDefaultTheme(
        title: S.of(context).product_reviews,
        needLeadingButton: true,
      ),
      body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listenWhen: (previous, current) => current is ProductAddedReview,
        listener: (context, state) async {
          if (state is ProductAddedReview) {
            await widget.productDetailsCubit
                .getProductReviews(widget.product.productID!);
          }
        },
        bloc: widget.productDetailsCubit,
        buildWhen: (previous, current) =>
            current is ProductReviewsLoading ||
            current is ProductReviewsLoaded ||
            current is ProductReviewsError,
        builder: (context, state) {
          if (state is ProductReviewsLoading) {
            return Center(
                child: CupertinoActivityIndicator(color: Colors.black));
          } else if (state is ProductReviewsError) {
            return ErrorPage();
          } else if (state is ProductReviewsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Rating Section
                  _buildOverallRatingSection(context, state),
                  SizedBox(height: 24.h),

                  // Add Review Button
                  writeRate(context, widget.product),
                  SizedBox(height: 24.h),

                  // Reviews List
                  _buildReviewsSection(context, state),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  GestureDetector writeRate(BuildContext context, ProductResponse product) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, AppRoutes.addReviewPage, arguments: {
          "product": product,
          "productDetailsCubit": widget.productDetailsCubit,
        });
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

  Widget _buildOverallRatingSection(
      BuildContext context, ProductReviewsLoaded state) {
    double rating = state.reviews.isEmpty
        ? 0.0
        : state.reviews.map((e) => e.rating).reduce((a, b) => a + b) /
            state.reviews.length.toDouble();
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
                      state.reviews.isEmpty ? "0.0" : rating.toString(),
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
                  state.reviews.isEmpty
                      ? "${S.of(context).based_on}  0 ${S.of(context).reviews}"
                      : "${S.of(context).based_on}  ${state.reviews.length} ${S.of(context).reviews}",
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
              // double rating = widget.product.rating?.toDouble() ?? 0.0;
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

  Widget _buildReviewsSection(
      BuildContext context, ProductReviewsLoaded state) {
    if (state.reviews.isEmpty) {
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
              "${S.of(context).all_reviews} (${state.reviews.length})",
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
          itemCount: state.reviews.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final review = state.reviews[index];
            return _buildReviewCard(context, review);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, ProductReviewsModel review) {
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
                  review.customerName.isNotEmpty
                      ? review.customerName[0].toUpperCase()
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
                      review.customerName,
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
                  int rating = review.rating;
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
          if (review.reviewText.isNotEmpty)
            Text(
              review.reviewText,
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
          // Icon container
          CircleAvatar(
            radius: 24.r,
            backgroundColor: MyColor.kellyGreen3.withAlpha(170),
            child: Icon(
              Icons.rate_review_outlined,
              size: 24.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // Main title
          Text(
            S.of(context).no_reviews_yet,
            style: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w600,
              color: Colors.grey.shade700,
              context: context,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 6.h),

          // Subtitle
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
