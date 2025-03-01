import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarDefaultTheme extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool? needLeadingButton;
  final List<Widget>? actions;
  const AppBarDefaultTheme(
      {super.key, required this.title, this.needLeadingButton = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff1D61E7),
      elevation: 4.0,
      shadowColor: Colors.black,
      toolbarHeight: 55.h,
      centerTitle: true,
      leading: needLeadingButton ?? true
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: FontHelper.fontText(
            size: 19.sp,
            weight: FontWeight.w700,
            color: Colors.white,
            context: context),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
