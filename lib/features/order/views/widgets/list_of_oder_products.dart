import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfOderProducts extends StatelessWidget {
  final List<CartItemModel> cartItems;
  const ListOfOderProducts({required this.cartItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
            color: const Color.fromARGB(255, 233, 233, 233), height: 1.h),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final isLastItem = index == cartItems.length - 1;
          return Padding(
            padding: EdgeInsets.only(
                left: 12, right: 12, top: 12, bottom: isLastItem ? 12 : 12),
            child: Row(
              children: [
                Container(
                  height: 80.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: HelperFunctions.fixGoogleDriveUrl(
                          cartItems[index].photo),
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItems[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: FontHelper.fontText(
                          context: context,
                          size: 13.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${S.of(context).quantity}: ${cartItems[index].quantity}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text:
                              '${cartItems[index].price * cartItems[index].quantity} ',
                          style: FontHelper.fontText(
                            context: context,
                            size: 17.sp,
                            weight: FontWeight.w800,
                            color: MyColor.kellyGreen3,
                          ),
                          children: [
                            TextSpan(
                              text: S.of(context).egyption_currency,
                              style: FontHelper.fontText(
                                context: context,
                                size: 16.sp,
                                weight: FontWeight.w700,
                                color: MyColor.kellyGreen3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
