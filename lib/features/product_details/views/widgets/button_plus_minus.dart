import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonPlusMinus extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final bool isMax;
  const ButtonPlusMinus({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isMax,
  });

  @override
  State<ButtonPlusMinus> createState() => _ButtonPlusMinusState();
}

class _ButtonPlusMinusState extends State<ButtonPlusMinus> {
  bool _isPressed = false; // Track if the button is currently pressed

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isMax
          ? null
          : () {
              setState(() {
                _isPressed = true;
              });
              widget.onTap();
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  _isPressed = false;
                });
              });
            },
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        width: 26.w,
        height: 26.h,
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey[200] : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(400),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          widget.icon,
          size: 24.sp,
          color: widget.isMax ? Colors.black45 : Colors.black,
        ),
      ),
    );
  }
}
