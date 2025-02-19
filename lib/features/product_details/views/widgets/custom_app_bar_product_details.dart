import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
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
      expandedHeight: 300.h,
      collapsedHeight: 50.h,
      pinned: true,
      leading: IconButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.bottomNavBar, (route) => false),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        icon: Icon(
          Icons.chevron_left_rounded,
          size: 30.r,
          color: Colors.black,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            bloc: productDetailsCubit,
            buildWhen: (previous, current) =>
                (current is SetProductFavoriteSuccess &&
                    current.productId == product.id) ||
                (current is SetProductFavoriteError &&
                    current.productId == product.id) ||
                (current is SetProductFavoriteLoading &&
                    current.productId == product.id),
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    productDetailsCubit.setProductFavorite(product);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  icon: state is SetProductFavoriteLoading
                      ? CupertinoActivityIndicator()
                      : (state is SetProductFavoriteSuccess &&
                              state.isFavorite == true)
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red.shade600,
                              size: 28.r,
                            )
                          : (state is SetProductFavoriteSuccess &&
                                  state.isFavorite == false)
                              ? Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.black,
                                  size: 28.r,
                                )
                              : state is SetProductFavoriteError
                                  ? Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.black,
                                      size: 28.r,
                                    )
                                  : product.isFavorite!
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red.shade600,
                                          size: 28.r,
                                        )
                                      : Icon(
                                          Icons.favorite_border_rounded,
                                          color: Colors.black,
                                          size: 28.r,
                                        ));
            },
          ),
        ),
      ],
      // backgroundColor: Colors.white,
      backgroundColor: Colors.grey.shade400,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Padding(
            padding: EdgeInsets.only(
                left: 8.0.w, right: 8.0.w, top: 8.h, bottom: 8.h),
            child: CachedNetworkImage(
              imageUrl: product.image ??
                  "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
