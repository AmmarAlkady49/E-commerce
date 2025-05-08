import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton1 extends StatelessWidget {
  final double width;
  final double height;
  final String buttonTitle;
  final VoidCallback? onTap;
  final bool? isLoading;
  const MyButton1(
      {super.key,
      required this.width,
      required this.height,
      required this.buttonTitle,
      required this.onTap,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.6),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        color: isLoading == true ? Colors.grey : MyColor.kellyGreen3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: Text(
          isLoading == true ? S.of(context).loading : buttonTitle,
          style: FontHelper.fontText(
              size: 15.sp,
              weight: FontWeight.w700,
              color: Colors.white,
              context: context),
        ),
      ),
    );
  }
}
