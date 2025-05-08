import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TextFormFieldChangePassword extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  const TextFormFieldChangePassword(
      {super.key,
      required this.controller,
      this.hintText,
      required this.validator});

  @override
  State<TextFormFieldChangePassword> createState() =>
      _TextFormFieldChangePasswordState();
}

class _TextFormFieldChangePasswordState
    extends State<TextFormFieldChangePassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: obscureText,
      maxLength: 12,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 1.0),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.kellyGreen, width: 1.5),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        hintText: widget.hintText ?? '**********',
        hintStyle: FontHelper.fontText(
            size: 14.sp,
            weight: FontWeight.w400,
            color: Colors.black38,
            context: context),
        prefixIcon: const Icon(Iconsax.lock, color: Colors.black38),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(obscureText ? Iconsax.eye : Iconsax.eye_slash)),
      ),
    );
  }
}
