import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrDevider extends StatelessWidget {
  final double size;
  final String text;
  const MyOrDevider({super.key, required this.size,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            indent: size,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0.w),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            endIndent: size,
          ),
        ),
      ],
    );
  }
}
