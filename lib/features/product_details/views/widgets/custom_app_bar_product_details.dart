import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarProductDetails extends StatelessWidget {
  final ProductResponse product;

  const CustomAppBarProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);

    return SliverAppBar(
      expandedHeight: 280.h,
      collapsedHeight: 65.h,
      pinned: true,
      backgroundColor: Colors.grey.shade300,
      leadingWidth: 80.w,
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate collapse ratio
          final expandedHeight = 280.h;
          final collapsedHeight = 65.h;
          final currentHeight = constraints.maxHeight;
          final collapseRatio = ((currentHeight - collapsedHeight) /
                  (expandedHeight - collapsedHeight))
              .clamp(0.0, 1.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with consistent sizing
              Positioned(
                top: MediaQuery.of(context).padding.top + 60.h,
                left: 8.w,
                right: 8.w,
                child: Transform.scale(
                  scale: 0.7 + (collapseRatio * 0.3),
                  child: SizedBox(
                    height: 200.h, // Fixed height for image
                    child: product.photos != null && product.photos!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: HelperFunctions.fixGoogleDriveUrl(
                                product.photos!.first.imageURL!),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/home_page/no_image_placeholder.png',
                              fit: BoxFit.contain,
                            ),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/images/home_page/no_image_placeholder.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),

              // Gradient overlay that becomes more prominent when collapsed
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha(100),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // AppBar content with smooth transitions
              Positioned(
                top: MediaQuery.of(context).padding.top + 8.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button with enhanced blur effect
                    _blurredCircleButton(
                      context,
                      icon: Icons.chevron_left_rounded,
                      blurIntensity:
                          8 + (collapseRatio * 4), // More blur when expanded
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.bottomNavBar,
                        (route) => false,
                      ),
                    ),

                    // Favorite button
                    BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      bloc: productDetailsCubit,
                      buildWhen: (prev, curr) =>
                          curr is SetProductFavoriteSuccess &&
                              curr.productId == product.productID.toString() ||
                          curr is SetProductFavoriteLoading,
                      builder: (context, state) {
                        bool isFavorite = product.isFavorite ?? false;
                        if (state is SetProductFavoriteSuccess &&
                            state.productId == product.productID.toString()) {
                          isFavorite = state.isFavorite;
                        }

                        return _blurredCircleButton(
                          context,
                          icon: state is SetProductFavoriteLoading
                              ? null
                              : (isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded),
                          iconColor: isFavorite ? Colors.red : Colors.white,
                          blurIntensity: 8 + (collapseRatio * 4),
                          child: state is SetProductFavoriteLoading
                              ? CupertinoActivityIndicator(radius: 10.r)
                              : null,
                          onPressed: () {
                            productDetailsCubit.setProductFavorite(
                                product.productID.toString());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blurredCircleButton(
    BuildContext context, {
    IconData? icon,
    Color iconColor = Colors.white,
    VoidCallback? onPressed,
    Widget? child,
    double blurIntensity = 10,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(75),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(80),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              splashColor: Colors.white.withAlpha(70),
              highlightColor: Colors.white.withAlpha(60),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: child ??
                    Icon(
                      icon,
                      color: iconColor,
                      size: 26.r,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
