import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonPlusMinus extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final bool isMax;
  const ButtonPlusMinus(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.isMax});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isMax ? null : onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
          width: 26.w,
          height: 26.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon,
              size: 24.sp, color: isMax ? Colors.black45 : Colors.black)),
    );
  }
}
