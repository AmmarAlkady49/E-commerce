import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutButtonBottom extends StatelessWidget {
  final CartResponseBody cartItems;
  const CheckoutButtonBottom({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: 48.h,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.confirmOrderPage);
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
            ),
            backgroundColor: WidgetStateProperty.all(MyColor.kellyGreen3),
            elevation: WidgetStateProperty.all(4.0),
          ),
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
                  color: MyColor.kellyGreen2.withAlpha(125),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${cartItems.subAmount}",
                          style: FontHelper.fontText(
                            size: 15.sp,
                            shadows: [
                              const Shadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            weight: FontWeight.w700,
                            color: Colors.white,
                            context: context,
                          ),
                        ),
                        TextSpan(
                          text: " ${S.of(context).egyption_currency} ",
                          style: FontHelper.fontText(
                            size: 12.sp,
                            shadows: [
                              const Shadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            weight: FontWeight.w700,
                            color: Colors.white,
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
