import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceText extends StatelessWidget {
  final double totalPrice;
  const PriceText({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: " \$ ",
            style: FontHelper.fontText(
              size: 20.sp,
              shadows: [
                const Shadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              weight: FontWeight.w700,
              color: Color(0xff1D61E7),
              context: context,
            ),
          ),
          TextSpan(
            text: totalPrice.toStringAsFixed(1),
            style: FontHelper.fontText(
              size: 20.sp,
              shadows: [
                const Shadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              weight: FontWeight.w700,
              color: Colors.black,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
