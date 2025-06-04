import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';

class LogOutButton extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  final bool isLoading;

  const LogOutButton({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            isLoading
                ? CupertinoActivityIndicator(
                    // color: MyColor.poppy,
                    color: Colors.black,
                    // radius: 11.sp,
                  )
                : Icon(leadingIcon, size: 24.sp, color: MyColor.poppy),
            SizedBox(width: 12.w),
            Text(
              title,
              style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w600,
                color: MyColor.poppy,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
