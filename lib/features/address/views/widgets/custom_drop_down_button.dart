import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButton extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  const CustomDropDownButton(
      {super.key,
      required this.title,
      required this.items,
      this.selectedValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w600,
              color: Colors.black,
              context: context),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
            value: selectedValue,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.black87),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38, width: 1.0),
                borderRadius: BorderRadius.circular(12.0.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38, width: 1.0),
                borderRadius: BorderRadius.circular(12.0.r),
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: FontHelper.fontText(
                        context: context,
                        size: 15.sp,
                        weight: FontWeight.w500,
                        color: Colors.black),
                  ));
            }).toList(), onChanged: onChanged,),
            
        ],
    );
  }
}
