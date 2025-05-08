import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionWidget extends StatefulWidget {
  final String? description;
  const DescriptionWidget({super.key, this.description});

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity),
        Text(
          // "                                                                                 ${S.of(context).description}",
          S.of(context).description,
          textDirection: TextDirection.ltr,
          style: FontHelper.fontText(
            size: 15.sp,
            weight: FontWeight.w700,
            color: Colors.black87,
            context: context,
          ),
        ),
        SizedBox(height: 2.h),
        AnimatedSize(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: widget.description == null
              ? Text(
                  S.of(context).no_description,
                  maxLines: isExpanded ? null : 1,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: FontHelper.fontText(
                    size: 14.sp,
                    color: Color(0xff555555),
                    context: context,
                    weight: FontWeight.w600,
                  ),
                )
              : Text(
                  widget.description!.trim(),
                  maxLines: isExpanded ? null : 1,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: FontHelper.fontText(
                    size: 14.sp,
                    color: Color(0xff555555),
                    context: context,
                    weight: FontWeight.w600,
                  ),
                ),
        ),
        SizedBox(height: 2.h),
        Visibility(
          visible: widget.description != null,
          child: InkWell(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            borderRadius: BorderRadius.circular(10.r),
            child: Row(
              // mainAxisSize: Localizations.localeOf(context).languageCode == 'ar'
              //     ? MainAxisSize.min
              //     : MainAxisSize.max,
              children: [
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: MyColor.kellyGreen3,
                ),
                Text(
                  isExpanded
                      ? S.of(context).show_less
                      : S.of(context).show_more,
                  style: FontHelper.fontText(
                    size: 12.sp,
                    color: MyColor.kellyGreen3,
                    context: context,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
