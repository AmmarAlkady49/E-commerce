import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/order/models/get_order_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCardItem extends StatelessWidget {
  final GetOrderModel order;
  const OrderCardItem({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TitleOfOrderCartItem(order: order),
          SizedBox(height: 8.0.h),
          ListOfOrderImages(order: order),
          SizedBox(height: 8.0.h),
          Row(
            children: [
              Text(
                "${order.orderDetails.length} ${S.of(context).product}",
                style: FontHelper.fontText(
                  context: context,
                  size: 14.sp,
                  weight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
              // const Spacer(),
              SizedBox(width: 12.w),
              HelperFunctions.isArabic(context)
                  ? const SizedBox.shrink()
                  : Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0.w, vertical: 4.0.h),
                      decoration: BoxDecoration(
                          color: HelperFunctions.getOrderStatusColor(
                                  order.orderStatus)
                              .withAlpha(40),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        HelperFunctions.getLocalizedOrderStatus(
                            order.orderStatus,
                            lang: HelperFunctions.isArabic(context)
                                ? 'ar'
                                : 'en'),
                        style: FontHelper.fontText(
                            context: context,
                            size: 10.sp,
                            weight: FontWeight.w700,
                            color: HelperFunctions.getOrderStatusColor(
                                    order.orderStatus)
                                .withAlpha(255)),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListOfOrderImages extends StatelessWidget {
  const ListOfOrderImages({
    super.key,
    required this.order,
  });

  final GetOrderModel order;

  @override
  Widget build(BuildContext context) {
    final visibleItems =
        order.orderDetails.length > 3 ? 3 : order.orderDetails.length;
    final remaining = order.orderDetails.length - visibleItems;

    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        itemCount: order.orderDetails.length > 3 ? 4 : visibleItems,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 8.0.w),
        itemBuilder: (context, index) {
          if (index == 3 && remaining > 0) {
            return Container(
              width: 50.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                HelperFunctions.isArabic(context)
                    ? "$remaining+"
                    : "+$remaining",
                style: FontHelper.fontText(
                  context: context,
                  size: 15.sp,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 4.0.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: HelperFunctions.fixGoogleDriveUrl(
                  order.orderDetails[index].mainImage),
              fit: BoxFit.contain,
              height: 50.h,
              width: 50.w,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TitleOfOrderCartItem extends StatelessWidget {
  const TitleOfOrderCartItem({
    super.key,
    required this.order,
  });

  final GetOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).order,
          style: FontHelper.fontText(
              context: context,
              size: 13.sp,
              weight: FontWeight.w600,
              color: Colors.black),
        ),
        SizedBox(width: 4.0.w),
        Text(
          "${HelperFunctions.formatArabicDate(order.orderDate, lang: HelperFunctions.isArabic(context) ? 'ar' : 'en')}, ",
          style: FontHelper.fontText(
              context: context,
              size: 14.sp,
              weight: FontWeight.w700,
              color: Colors.black),
        ),
        Text(
          S.of(context).number,
          style: FontHelper.fontText(
              context: context,
              size: 11.sp,
              weight: FontWeight.w600,
              color: Colors.black54),
        ),
        SizedBox(width: 3.0.w),
        Text(
          "(${order.orderNumber})",
          style: FontHelper.fontText(
              context: context,
              size: 11.sp,
              weight: FontWeight.w400,
              color: Colors.black54),
        ),
        const Spacer(),
        HelperFunctions.isArabic(context)
            ? Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.0.h),
                decoration: BoxDecoration(
                    color:
                        HelperFunctions.getOrderStatusColor(order.orderStatus)
                            .withAlpha(40),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  HelperFunctions.getLocalizedOrderStatus(order.orderStatus,
                      lang: HelperFunctions.isArabic(context) ? 'ar' : 'en'),
                  style: FontHelper.fontText(
                      context: context,
                      size: 10.sp,
                      weight: FontWeight.w700,
                      color:
                          HelperFunctions.getOrderStatusColor(order.orderStatus)
                              .withAlpha(255)),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
