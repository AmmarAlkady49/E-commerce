import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyTextFormField extends StatefulWidget {
  final double width;
  final IconData? preIcon;
  final Widget? prefix;
  final IconData? suffIcon;
  final String hint;
  const MyTextFormField({
    super.key,
    required this.width,
    this.preIcon,
    this.prefix,
    this.suffIcon,
    required this.hint,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool ishidden = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        obscureText:
            ((widget.hint == 'Password' || widget.hint == 'Confirm Password')
                ? true && ishidden
                : false),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
          hintText: widget.hint,
          hintStyle: FontHelper.fontText(
              size: 16, weight: FontWeight.w400, color: Colors.grey),
          prefixIcon: widget.prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: widget.prefix,
                )
              : null,
          suffixIcon:
              (widget.hint == 'Password' || widget.hint == 'Confirm Password')
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
                  : widget.hint != 'Password'
                      ? Icon(widget.suffIcon, color: Colors.grey)
                      : null,
        ),
      ),
    );
  }
}
