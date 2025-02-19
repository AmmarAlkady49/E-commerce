import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomOfTheProductDetails extends StatelessWidget {
  final ProductResponse product;
  const BottomOfTheProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddToCartButton(
              onTap: () {},
            ),
            Text("${product.price.toString()} \$",
                style: FontHelper.fontText(
                  size: 24.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                  context: context,
                )),
          ],
        ),
      ),
    );
  }
}
