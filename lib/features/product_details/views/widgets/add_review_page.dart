import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReviewPage extends StatefulWidget {
  final ProductResponse product;
  final ProductDetailsCubit productDetailsCubit;

  const AddReviewPage(
      {super.key, required this.product, required this.productDetailsCubit});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  int _selectedRating = 0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBarDefaultTheme(
        title: S.of(context).add_review,
        needLeadingButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Info Section
              _buildProductInfoSection(),
              SizedBox(height: 24.h),

              // Rating Section
              _buildRatingSection(),
              SizedBox(height: 24.h),

              // Review Text Section
              _buildReviewTextSection(),
              SizedBox(height: 32.h),

              // Submit Button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfoSection() {
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
          // Product Image (placeholder)
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            // child: Icon(
            //   Icons.shopping_bag_outlined,
            //   color: Colors.grey.shade400,
            //   size: 24.sp,
            // ),
            child: widget.product.photos?.isEmpty ?? true
                ? Image.asset(
                    'assets/images/home_page/no_image_placeholder.png',
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    imageUrl: HelperFunctions.fixGoogleDriveUrl(
                        widget.product.photos!.first.imageURL!),
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
                      final targetWidth =
                          MediaQuery.of(context).size.width / 3.w;

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
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).reviewing_product,
                  style: FontHelper.fontText(
                    size: 12.sp,
                    weight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    context: context,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.product.name ?? S.of(context).product_name,
                  style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black87,
                    context: context,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
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
              S.of(context).rating,
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.black87,
                context: context,
              ),
            ),
            Text(
              " *",
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.red,
                context: context,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _selectedRating == 0
                  ? Colors.red.shade300
                  : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                S.of(context).tap_to_rate,
                style: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: Colors.grey.shade600,
                  context: context,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        index < _selectedRating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: index < _selectedRating
                            ? Colors.amber.shade600
                            : Colors.grey.shade400,
                        size: 32.sp,
                      ),
                    ),
                  );
                }),
              ),
              if (_selectedRating > 0) ...[
                SizedBox(height: 8.h),
                Text(
                  _getRatingText(_selectedRating),
                  style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.amber.shade700,
                    context: context,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (_selectedRating == 0) ...[
          SizedBox(height: 8.h),
          Text(
            S.of(context).please_select_rating,
            style: FontHelper.fontText(
              size: 12.sp,
              weight: FontWeight.w500,
              color: Colors.red.shade600,
              context: context,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReviewTextSection() {
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
              S.of(context).your_review,
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.black87,
                context: context,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _reviewController,
          maxLines: 5,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return S.of(context).please_enter_review;
            }
            if (value.trim().length < 10) {
              return S.of(context).review_too_short;
            }
            if (value.trim().length > 50) {
              return S.of(context).review_too_long;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: S.of(context).share_your_experience,
            hintStyle: FontHelper.fontText(
              size: 14.sp,
              weight: FontWeight.w400,
              color: Colors.grey.shade500,
              context: context,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: MyColor.kellyGreen3, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red.shade300, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red.shade300, width: 2),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            errorStyle: FontHelper.fontText(
              size: 12.sp,
              weight: FontWeight.w500,
              color: Colors.red.shade600,
              context: context,
            ),
          ),
          style: FontHelper.fontText(
            size: 14.sp,
            weight: FontWeight.w500,
            color: Colors.black87,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    final cubit = widget.productDetailsCubit;
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is ProductAddedReview || current is ProductAddedReviewError,
      listener: (context, state) async {
        if (state is ProductAddedReview) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _showSuccessSnackBar(S.of(context).review_submitted_successfully);
          });
          Navigator.pop(context, true);
        }
        if (state is ProductAddedReviewError) {
          _showErrorSnackBar(S.of(context).failed_to_submit_review);
        }
      },
      buildWhen: (previous, current) =>
          current is ProductAddingReview || current is ProductAddedReviewError,
      builder: (context, state) {
        if (state is ProductAddingReview) {
          return MyButton1(
              width: double.infinity,
              height: 48.h,
              buttonTitle: S.of(context).submit_review,
              onTap: null,
              isLoading: true);
        } else {
          return MyButton1(
            width: double.infinity,
            height: 48.h,
            buttonTitle: S.of(context).submit_review,
            onTap: () {
              _submitReview(cubit);
            },
          );
        }
      },
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return S.of(context).poor;
      case 2:
        return S.of(context).fair;
      case 3:
        return S.of(context).good;
      case 4:
        return S.of(context).very_good;
      case 5:
        return S.of(context).excellent;
      default:
        return '';
    }
  }

  void _submitReview(ProductDetailsCubit cubit) async {
    if (_selectedRating == 0) {
      _showErrorSnackBar(S.of(context).please_select_rating);
      return;
    }

    if (_formKey.currentState!.validate()) {
      cubit.addReview(
        widget.product.productID!,
        _reviewController.text.trim(),
        _selectedRating,
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: FontHelper.fontText(
            size: 15.sp,
            weight: FontWeight.w600,
            color: Colors.white,
            context: context),
      ),
      backgroundColor: MyColor.kellyGreen3,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    ));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.start,
          style: FontHelper.fontText(
            size: 15.sp,
            weight: FontWeight.w600,
            color: Colors.white,
            context: context,
          ),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    );
  }
}
