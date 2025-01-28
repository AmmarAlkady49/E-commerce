import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberAndForgetLogin extends StatefulWidget {
  const RememberAndForgetLogin({super.key});

  @override
  State<RememberAndForgetLogin> createState() => _RememberAndForgetLoginState();
}

class _RememberAndForgetLoginState extends State<RememberAndForgetLogin> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isSelected,
              activeColor: Color(0xff1D61E7),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                setState(() {
                  isSelected = value!;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
                side: BorderSide(color: Colors.red, width: 2.0),
              ),
            ),
            Text(
              S.of(context).remember_me,
              style: FontHelper.fontText(
                  size: 13.sp, weight: FontWeight.w600, color: Colors.black),
            )
          ],
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.r),
          child: Text(
            S.of(context).forgot_password,
            style: FontHelper.fontText(
                size: 13.sp,
                weight: FontWeight.w700,
                color: Color.fromARGB(255, 44, 103, 223)),
          ),
        ),
      ],
    );
  }
}
