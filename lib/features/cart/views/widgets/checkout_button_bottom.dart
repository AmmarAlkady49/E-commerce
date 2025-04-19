import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutButtonBottom extends StatelessWidget {
  final CartResponseBody cartItems;
  const CheckoutButtonBottom({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    // final totalPrice = cartItems.map(
    //   (e) => e.product.price! * e.quantity,
    // );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Color(0xff1D61E7).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Adjust alignment
              children: [
                Expanded(
                  child: Text(
                    S.of(context).checkout2,
                    style: FontHelper.fontText(
                      context: context,
                      size: 16.sp,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1D61E7).withAlpha(1000),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Text(
                      // '\$ ${totalPrice.reduce((a, b) => a + b).toStringAsFixed(1)}',
                      '\$ ${cartItems.subAmount}',
                      style: FontHelper.fontText(
                        context: context,
                        size: 14.sp,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
