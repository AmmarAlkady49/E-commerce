import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/grid_view_for_categories.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/image_slider.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/recommended_products.dart';
import 'package:e_commerce_graduation/features/notification/services/local_notification_services.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextButton(
              //     onPressed: () {
              //       LocalNotificationServices.showBasicNotification();
              //     },
              //     child: const Icon(Icons.notification_important)),
              SizedBox(height: 8.h),
              ImageSlider(),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).shop_by_category,
                      style: FontHelper.fontText(
                          size: 17.sp,
                          weight: FontWeight.w800,
                          color: Colors.black,
                          context: context)),
                  Text(S.of(context).see_all,
                      style: FontHelper.fontText(
                          size: 12.sp,
                          weight: FontWeight.w800,
                          color: MyColor.kellyGreen3,
                          context: context)),
                ],
              ),
              SizedBox(height: 8.h),
              GridViewForCategories(),
              // SizedBox(height: 0.h),
              RecommendedProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
