import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? status;
  const AddToCartButton({super.key, required this.onTap, this.status});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return status == "add" || status == "added"
        ? ElevatedButton(
            onPressed: status == "added" ? null : onTap,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(status == "added"
                  ? Colors.grey.shade300
                  // : Color.fromARGB(255, 52, 110, 225)),
                  : MyColor.kellyGreen3),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12, width: 1.0),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: size.width * 0.05.w,
                  vertical: 10.h,
                ),
              ),
              elevation: WidgetStateProperty.all(1.0),
              overlayColor:
                  WidgetStateProperty.all(MyColor.kellyGreen3.withAlpha(100)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (status == "add" || status == "added")
                  Text(
                    status == "add"
                        ? S.of(context).add_to_cart
                        : status == "added"
                            ? S.of(context).added_to_cart
                            : S.of(context).add_to_cart,
                    style: FontHelper.fontText(
                      color: status == "added" ? Colors.black45 : Colors.white,
                      weight: FontWeight.w700,
                      context: context,
                      size: 15.sp,
                    ),
                  ),
                SizedBox(width: 8.w),
                if (status == "add" || status == "added")
                  Icon(
                    status == "add"
                        ? Iconsax.shopping_bag
                        : status == "added"
                            ? CupertinoIcons.checkmark_alt
                            // ? Icons.check
                            : null,
                    color: status == "added" ? Colors.black45 : Colors.white,
                    size: 24.sp,
                  ),
              ],
            ),
          )
        : IconButton(
            onPressed: null,
            icon: const CupertinoActivityIndicator(color: Colors.black),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12, width: 1.0),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: size.width * 0.05.w,
                  vertical: 10.h,
                ),
              ),
              elevation: WidgetStateProperty.all(2),
              overlayColor:
                  WidgetStateProperty.all(MyColor.kellyGreen3.withAlpha(100)),
            ),
          );
  }
}
