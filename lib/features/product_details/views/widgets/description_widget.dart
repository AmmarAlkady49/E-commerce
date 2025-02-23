import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Description                                                               ",
          textDirection: TextDirection.ltr,
          style: FontHelper.fontText(
            size: 16.sp,
            weight: FontWeight.w700,
            color: Colors.black,
            context: context,
          ),
        ),
        Text(
          widget.description!,
          textDirection: TextDirection.ltr,
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: FontHelper.fontText(
            size: 14.sp,
            color: Color(0xff555555),
            context: context,
            weight: FontWeight.w600,
          ),
        ),
        SizedBox(height: isExpanded ? 2.w : 0.w),
        InkWell(
          onTap: () => setState(() {
            isExpanded = !isExpanded;
          }),
          borderRadius: BorderRadius.circular(10.r),
          child: Row(
            mainAxisSize: Localizations.localeOf(context).languageCode == 'ar'
                ? MainAxisSize.min
                : MainAxisSize.max,
            children: [
              Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Color(0xff1D61E7),
              ),
              Text(
                isExpanded ? S.of(context).show_less : S.of(context).show_more,
                style: FontHelper.fontText(
                  size: 13.sp,
                  color: Color(0xff1D61E7),
                  context: context,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
