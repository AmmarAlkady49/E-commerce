import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TextFormFieldChangePassword extends StatefulWidget {
  final TextEditingController controller;
  const TextFormFieldChangePassword({super.key, required this.controller});

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (!value.contains(RegExp(r'[A-Z]'))) {
          return 'Password must contain at least one uppercase letter';
        }
        if (!value.contains(RegExp(r'[a-z]'))) {
          return 'Password must contain at least one lowercase letter';
        }
        if (!value.contains(RegExp(r'\d'))) {
          return 'password must contain at least one number';
        }
        return null;
      },
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
          borderSide: BorderSide(color: Color(0xff1D61E7), width: 1.5),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        hintText: '**********',
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
