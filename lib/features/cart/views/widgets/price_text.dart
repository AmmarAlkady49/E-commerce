import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
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
            text: totalPrice.toStringAsFixed(1),
            style: FontHelper.fontText(
              size: HelperFunctions.isArabic(context) ? 19.sp : 17.sp,
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
          TextSpan(
            text: " ${S.of(context).egyption_currency} ",
            style: FontHelper.fontText(
              size: HelperFunctions.isArabic(context) ? 16.sp : 14.sp,
              shadows: [
                const Shadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              weight: FontWeight.w700,
              color: MyColor.kellyGreen3,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
