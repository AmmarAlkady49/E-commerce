import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final void Function() onTap;
  const MyListTile(
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
          Icon(leadingIcon, size: 24.sp, color: Colors.black),
          SizedBox(width: 12.w),
          Text(
            title,
            style: FontHelper.fontText(
                size: 18.sp,
                weight: FontWeight.w600,
                color: Colors.black,
                context: context),
          ),
          Spacer(),
          Icon(
              Localizations.localeOf(context).languageCode == 'ar'
                  ? CupertinoIcons.chevron_back
                  : CupertinoIcons.chevron_forward,
              size: 24.sp,
              color: Colors.black87),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
