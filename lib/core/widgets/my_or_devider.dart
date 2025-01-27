import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrDevider extends StatelessWidget {
  final double size;
  const MyOrDevider({super.key, required this.size});

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
            S.of(context).or,
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
