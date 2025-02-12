import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutButton extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final void Function() onTap;
  const LogOutButton(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
        padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h)),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Icon(leadingIcon, size: 24.sp, color: Colors.red.shade700),
          SizedBox(width: 12.w),
          Text(
            title,
            style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w600,
                color: Colors.red.shade700,context: context),
          ),
        ],
      ),
    );
  }
}
