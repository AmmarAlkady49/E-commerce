import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalSubtotalInfo extends StatelessWidget {
  final CartResponseBody cartItems;
  const TotalSubtotalInfo({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    // final subTotalPrice = cartItems.map((e) => e.product.price! * e.quantity);
    final int totalItems = cartItems.items.length;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: S.of(context).subtotal,
                    style: FontHelper.fontText(
                      size: 16.sp,
                      weight: FontWeight.w600,
                      color: Colors.black,
                      context: context,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " ($totalItems ${totalItems == 1 || totalItems == 2 ? S.of(context).product : S.of(context).products})",
                        style: FontHelper.fontText(
                          size: 15.sp,
                          weight: FontWeight.w600,
                          color: Colors.black45,
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  // "\$${subTotalPrice.reduce((a, b) => a + b).toStringAsFixed(2)}",
                  "\$${cartItems.subAmount}",
                  style: FontHelper.fontText(
                      context: context,
                      size: 15.sp,
                      weight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).shipping_fees,
                  style: FontHelper.fontText(
                    size: 16.sp,
                    weight: FontWeight.w600,
                    color: Colors.black,
                    context: context,
                  ),
                ),
                Text(
                  S.of(context).free,
                  style: FontHelper.fontText(
                      context: context,
                      size: 15.sp,
                      weight: FontWeight.w700,
                      color: Colors.green.shade600),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            const Divider(color: Colors.black12),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).total_amount,
                  style: FontHelper.fontText(
                    size: 16.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                    context: context,
                  ),
                ),
                Text(
                  // "\$${subTotalPrice.reduce((a, b) => a + b).toStringAsFixed(2)}",
                  "\$${cartItems.subAmount}",
                  style: FontHelper.fontText(
                      context: context,
                      size: 17.sp,
                      weight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
