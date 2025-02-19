import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/button_plus_minus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterPlusMinus extends StatefulWidget {
  const CounterPlusMinus({super.key});

  @override
  State<CounterPlusMinus> createState() => _CounterPlusMinusState();
}

class _CounterPlusMinusState extends State<CounterPlusMinus> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      width: 95.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.6),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonPlusMinus(
              onTap: () {
                setState(() {
                  if (count < 10) {
                    count++;
                  }
                });
              },
              isMax: count == 10 ? true : false,
              icon: Icons.add,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                count.toString(),
                style: FontHelper.fontText(
                  size: 19.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                  context: context,
                ),
              ),
            ),
            ButtonPlusMinus(
              onTap: () {
                setState(() {
                  if (count > 1) count--;
                });
              },
              isMax: count == 1 ? true : false,
              icon: Icons.remove,
            ),
          ],
        ),
      ),
    );
  }
}
