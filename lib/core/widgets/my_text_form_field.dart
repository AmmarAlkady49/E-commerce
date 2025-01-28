import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MyTextFormField extends StatefulWidget {
  final double width;
  final IconData? preIcon;
  final Widget? prefix;
  final IconData? suffIcon;
  final String hint;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final FocusNode? presentFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;

  const MyTextFormField(
      {super.key,
      required this.width,
      this.preIcon,
      this.prefix,
      this.suffIcon,
      required this.hint,
      this.textInputType,
      this.controller,
      required this.validator,
      this.presentFocusNode,
      this.textInputAction,
      this.nextFocusNode});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool ishidden = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            focusNode: widget.presentFocusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            },
            style: (widget.hint == S.of(context).password ||
                    widget.hint == S.of(context).confirm_password)
                ? TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )
                : FontHelper.fontText(
                    size: 15.sp, weight: FontWeight.w500, color: Colors.black),
            obscureText: ((widget.hint == S.of(context).password ||
                    widget.hint == S.of(context).confirm_password)
                ? true && ishidden
                : false),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 11.h, horizontal: 14.w),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade800, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              errorStyle: FontHelper.fontText(
                  size: 12.sp,
                  weight: FontWeight.w500,
                  color: Colors.red.shade800),
              hintText: widget.hint,
              hintStyle: FontHelper.fontText(
                  size: 15.sp, weight: FontWeight.w500, color: Colors.grey),
              prefixIcon: widget.prefix != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                      child: widget.prefix,
                    )
                  : null,
              suffixIcon: (widget.hint == S.of(context).password ||
                      widget.hint == S.of(context).confirm_password)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          ishidden = !ishidden;
                        });
                      },
                      icon: Icon(
                        ishidden ? Iconsax.eye : Iconsax.eye_slash,
                        color: Colors.grey,
                      ),
                    )
                  : (widget.hint == S.of(context).birthday)
                      ? Icon(widget.suffIcon, color: Colors.grey)
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
