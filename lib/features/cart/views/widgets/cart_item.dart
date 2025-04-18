import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/counter_container.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/price_text.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    final totalPrice = cartItem.price * cartItem.quantity;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Product Image
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              height: 100.h,
              width: 70.w,
              child: CachedNetworkImage(
                imageUrl: HelperFunctions.fixGoogleDriveUrl(cartItem.photo),
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Product Details + Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.name,
                            style: FontHelper.fontText(
                              size: 16.sp,
                              weight: FontWeight.w700,
                              color: Colors.black,
                              context: context,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            // cartItem.category!,
                            "category",
                            style: FontHelper.fontText(
                              size: 14.sp,
                              weight: FontWeight.w500,
                              color: Colors.black45,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.w),
                      child: BlocBuilder<CartCubit, CartState>(
                        bloc: cartCubit,
                        buildWhen: (previous, current) =>
                            current is CartItemUpdatedError ||
                            (current is CartItemDeleting &&
                                current.productId ==
                                    cartItem.productId.toString()),
                        builder: (context, state) {
                          if (state is CartItemDeleting &&
                              state.productId ==
                                  cartItem.productId.toString()) {
                            return CupertinoActivityIndicator(
                                color: Colors.black54);
                          }
                          return InkWell(
                            onTap: () {
                              // cartCubit.deleteProductFromCart(
                              //     cartItem.productId.toString(),);
                              context.read<CartCubit>().deleteProductFromCart(
                                  cartItem.productId.toString(),
                                  context.read<FavoritesCubit>());
                            },
                            borderRadius: BorderRadius.circular(50.r),
                            child: Icon(
                              Icons.clear,
                              color: Colors.black54,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterContainer(cartItem: cartItem),
                    PriceText(totalPrice: totalPrice),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
