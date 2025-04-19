import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/increment_decrement_button.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterContainer extends StatelessWidget {
  final CartItemModel cartItem;
  const CounterContainer({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.6),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IncrementDecrementButton(
            cartItem: cartItem,
            isIncrement: false,
          ),
          Text(
            cartItem.quantity.toString(),
            style: FontHelper.fontText(
              color: Colors.black87,
              size: 16.sp,
              weight: FontWeight.w700,
              context: context,
            ),
          ),
          IncrementDecrementButton(
            cartItem: cartItem,
            isIncrement: true,
          ),
        ],
      ),
    );
  }
}
