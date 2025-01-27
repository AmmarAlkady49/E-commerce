import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton1 extends StatelessWidget {
  final double width;
  final double height;
  final String buttonTitle;
  final VoidCallback onTap;
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
        gradient: LinearGradient(
            colors: isLoading == true
                ? [
                    const Color.fromARGB(255, 177, 177, 177),
                    const Color.fromARGB(255, 91, 91, 91)
                  ]
                : [
                    Color.fromARGB(255, 81, 138, 250),
                    Color(0xff1D61E7),
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          isLoading == true ? S.of(context).loading : buttonTitle,
          style: FontHelper.fontText(
              size: 15.sp, weight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
