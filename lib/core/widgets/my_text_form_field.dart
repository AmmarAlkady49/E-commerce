import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class EnhancedTextFormField extends StatefulWidget {
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
  final bool? readOnly;
  final VoidCallback? onTap;
  final Iterable<String>? autofillHints;
  final Function()? onEditingComplete;
  final bool disFocus;

  const EnhancedTextFormField({
    super.key,
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
    this.nextFocusNode,
    this.readOnly,
    this.onTap,
    this.autofillHints,
    this.onEditingComplete,
    this.disFocus = false,
  });

  @override
  State<EnhancedTextFormField> createState() => _EnhancedTextFormFieldState();
}

class _EnhancedTextFormFieldState extends State<EnhancedTextFormField>
    with SingleTickerProviderStateMixin {
  bool isHidden = true;
  bool isFocused = false;
  bool hasError = false;
  String? errorText;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    widget.presentFocusNode?.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.presentFocusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.presentFocusNode?.hasFocus ?? false) {
      setState(() {
        isFocused = true;
      });
      _animationController.forward();
    } else {
      if (widget.controller?.text.isEmpty ?? true) {
        _animationController.reverse();
      }
      setState(() {
        isFocused = false;
      });
    }
  }

  Color _getFieldColor() {
    if (hasError) {
      return Colors.redAccent;
    } else if (isFocused) {
      return MyColor.kellyGreen3;
    } else {
      return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: 57.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isFocused ? _getFieldColor() : Colors.black26,
                width: isFocused ? 1.5 : 1.0,
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: _getFieldColor(),
                    ),
              ),
              child: TextFormField(
                readOnly: widget.readOnly ?? false,
                onTap: widget.onTap,
                validator: (value) {
                  final result = widget.validator(value);
                  setState(() {
                    hasError = result != null;
                    errorText = result;
                  });
                  return result;
                },
                controller: widget.controller,
                keyboardType: widget.textInputType,
                focusNode: widget.presentFocusNode,
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                autofillHints: widget.autofillHints,
                onEditingComplete: widget.onEditingComplete,
                onFieldSubmitted: (value) {
                  widget.disFocus
                      ? FocusScope.of(context).unfocus()
                      : FocusScope.of(context)
                          .requestFocus(widget.nextFocusNode);
                },
                textAlign: TextAlign.start,
                style: FontHelper.fontText(
                  size: 15.sp,
                  weight: FontWeight.w600,
                  color: Colors.black87,
                  context: context,
                ),
                obscureText: ((widget.hint == S.of(context).password ||
                        widget.hint == S.of(context).confirm_password)
                    ? true && isHidden
                    : false),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  // filled: true,
                  // fillColor: Colors.transparent,
                  hintText: widget.hint,
                  hintStyle: FontHelper.fontText(
                      size: 14.sp,
                      weight: FontWeight.w500,
                      color: Colors.grey,
                      context: context),
                  prefixIcon: widget.prefix != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                          child: widget.prefix,
                        )
                      : null,
                  suffixIcon: (widget.hint == S.of(context).password ||
                          widget.hint == S.of(context).confirm_password)
                      ? IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: Icon(
                              isHidden ? Iconsax.eye : Iconsax.eye_slash,
                              key: ValueKey<bool>(isHidden),
                              color: _getFieldColor(),
                              size: 20.sp,
                            ),
                          ),
                        )
                      : (widget.hint == S.of(context).birthday)
                          ? Icon(widget.suffIcon,
                              color: _getFieldColor(), size: 20.sp)
                          : null,
                ),
              ),
            ),
          ),
          if (hasError && errorText != null)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
              child: Row(
                children: [
                  Icon(
                    Iconsax.info_circle,
                    color: Colors.redAccent,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    errorText!,
                    style: FontHelper.fontText(
                      size: 12.sp,
                      weight: FontWeight.w500,
                      color: Colors.redAccent,
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
