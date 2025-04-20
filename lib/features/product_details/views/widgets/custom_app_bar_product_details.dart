import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
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
      collapsedHeight: 55.h,
      pinned: true,
      leadingWidth: 80.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: InkWell(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.bottomNavBar, (route) => false),
          borderRadius: BorderRadius.circular(100.r),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.chevron_left_rounded,
                size: 30.r, color: Colors.black),
          ),
        ),
      ),
      // actions: [
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      //     child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      //       bloc: productDetailsCubit,
      //       // buildWhen: (previous, current) =>
      //       //     (current is SetProductFavoriteSuccess &&
      //       //         current.productId == product.id) ||
      //       //     (current is SetProductFavoriteError &&
      //       //         current.productId == product.id) ||
      //       //     (current is SetProductFavoriteLoading &&
      //       //         current.productId == product.id),
      //       builder: (context, state) {
      //         return IconButton(
      //             padding: EdgeInsets.all(10.r),
      //             onPressed: () {
      //               // productDetailsCubit.setProductFavorite(product);
      //             },
      //             style: ButtonStyle(
      //               backgroundColor: WidgetStateProperty.all(
      //                   // Color.fromARGB(222, 222, 222, 222)),
      //                   Colors.white),
      //             ),
      //             icon: state is SetProductFavoriteLoading
      //                 ? CupertinoActivityIndicator()
      //                 : (state is SetProductFavoriteSuccess &&
      //                         state.isFavorite == true)
      //                     ? Icon(
      //                         Icons.favorite,
      //                         color: Colors.red.shade600,
      //                         size: 28.r,
      //                       )
      //                     : (state is SetProductFavoriteSuccess &&
      //                             state.isFavorite == false)
      //                         ? Icon(
      //                             Icons.favorite_border_rounded,
      //                             color: Colors.black,
      //                             size: 28.r,
      //                           )
      //                         : state is SetProductFavoriteError
      //                             ? Icon(
      //                                 Icons.favorite_border_rounded,
      //                                 color: Colors.black,
      //                                 size: 28.r,
      //                               )
      //                             : product.isFavorite!
      //                                 ? Icon(
      //                                     Icons.favorite,
      //                                     color: Colors.red.shade600,
      //                                     size: 28.r,
      //                                   )
      //                                 : Icon(
      //                                     Icons.favorite_border_rounded,
      //                                     color: Colors.black,
      //                                     size: 28.r,
      //                                   ));
      //       },
      // ),
      // ),
      // ],
      // backgroundColor: Colors.amber,
      // backgroundColor: Color(0xFFFDFEFF),
      backgroundColor: Colors.grey.shade200,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(top: 36.h, bottom: 8.h),
          child: product.photos != null && product.photos!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: HelperFunctions.fixGoogleDriveUrl(
                      product.photos!.first.imageURL!),
                  fit: BoxFit.contain,
                  height: 140.h,
                  width: double.infinity,
                )
              : Image.asset(
                  'assets/images/home_page/no_image_found.jpg',
                  fit: BoxFit.contain,
                  height: 140.h,
                  width: double.infinity,
                ),
        ),
      ),
    );
  }
}
