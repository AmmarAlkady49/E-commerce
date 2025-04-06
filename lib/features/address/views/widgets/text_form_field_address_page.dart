import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldAddressPage extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final GlobalKey formKey;
  const TextFormFieldAddressPage(
      {super.key,
      required this.title,
      required this.hintText,
      required this.formKey,
      required this.controller});

  @override
  State<TextFormFieldAddressPage> createState() =>
      _TextFormFieldAddressPageState();
}

class _TextFormFieldAddressPageState extends State<TextFormFieldAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w600,
              color: Colors.black,
              context: context),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: FontHelper.fontText(
            size: 14.sp,
            weight: FontWeight.w600,
            color: Colors.black,
            context: context,
          ),
          validator: (value) {
            if (value == null) return S.of(context).empty_cell;
            if (value.isEmpty) {
              return S.of(context).empty_cell;
            }
            if (value.length < 6) {
              return S.of(context).invalid_name;
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hintText,
              errorStyle: FontHelper.fontText(
                size: 12.sp,
                weight: FontWeight.w600,
                color: Colors.red,
                context: context,
              ),
              hintStyle: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w600,
                  color: Colors.black54,
                  context: context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.black54, width: 0.7.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.black87, width: 1.2.w),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.2),
              )),
        ),
      ],
    );
  }
}
