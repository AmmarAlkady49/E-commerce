import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/cart_item.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/total_subtotal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotEmptyCart extends StatelessWidget {
  final CartResponseBody cartItems;
  const NotEmptyCart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CartItem(cartItem: cartItems.items[index]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                // Divider(
                //   color: Colors.transparent,
                //   endIndent: 16.w,
                //   indent: 16.w,
                // ),
                itemCount: cartItems.items.length),
            SizedBox(height: 8.h),
            Divider(
              color: Colors.black12,
              endIndent: 16.w,
              indent: 16.w,
            ),
            SizedBox(height: 8.h),
            TotalSubtotalInfo(cartItems: cartItems),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
