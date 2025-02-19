import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddToCartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ElevatedButton(
      onPressed: () => onTap,
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color(0xff1D61E7)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: size.width * 0.07.w,
              vertical: 10.h,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.shopping_bag,
            color: Colors.white,
            size: 24.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'Add to cart',
            style: TextStyle(
                fontSize: 19.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
