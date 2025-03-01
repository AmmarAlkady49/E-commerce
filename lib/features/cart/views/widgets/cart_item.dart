import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/counter_container.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Row(
      children: [
        // Product Image
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 90.h,
            width: 70.w,
            child: CachedNetworkImage(
              imageUrl: cartItem.product.image!,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(width: 8.w),

        // Product Details + Price
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title + Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.product.title ?? 'Item not found',
                      style: FontHelper.fontText(
                        context: context,
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      cartItem.product.category ?? 'Category not found',
                      style: FontHelper.fontText(
                        context: context,
                        size: 13.sp,
                        weight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    CounterContainer(cartItem: cartItem),
                  ],
                ),
              ),

              // Delete Button + Price
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      cartCubit.deleteProductFromCart(cartItem);
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "${(cartItem.product.price ?? 0) * (cartItem.quantity)}\$",
                    style: FontHelper.fontText(
                      context: context,
                      size: 16.sp,
                      weight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
