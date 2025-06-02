import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowModalBottomSheet extends StatelessWidget {
  const ShowModalBottomSheet({super.key});

  static void show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ShowModalBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.green[600],
                      size: 42.sp,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Title
                  Text(
                    "${S.of(context).order_confirmed_title} 🎉",
                    style: FontHelper.fontText(
                      context: context,
                      size: 24.sp,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Delivery info
                  Text(
                    S.of(context).order_confirmed_desc,
                    textAlign: TextAlign.center,
                    style: FontHelper.fontText(
                      context: context,
                      size: 14.sp,
                      weight: FontWeight.w400,
                      color: Colors.grey[700]!,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Track My Order button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.myOrderPage);
                    },
                    child: Text(
                      S.of(context).track_your_order,
                      style: FontHelper.fontText(
                        context: context,
                        size: 16.sp,
                        weight: FontWeight.w700,
                        color: MyColor.kellyGreen2,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Continue Shopping button
                  SizedBox(
                    width: double.infinity,
                    child: MyButton1(
                        width: double.infinity,
                        height: 47.h,
                        buttonTitle: S.of(context).coninue_shopping,
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),

                  SizedBox(height: 12.h),

                  // Customer Support link
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: FontHelper.fontText(
                          context: context,
                          size: 12,
                          weight: FontWeight.w400,
                          color: Colors.grey[600]!),
                      children: [
                        TextSpan(
                          text: "${S.of(context).have_questions}  ",
                        ),
                        TextSpan(
                          text: S.of(context).support_team,
                          style: FontHelper.fontText(
                              context: context,
                              size: 12,
                              weight: FontWeight.w700,
                              color: MyColor.kellyGreen2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
