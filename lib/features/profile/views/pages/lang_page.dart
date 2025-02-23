import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/profile/views/widgets/choose_language_button.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LangPage extends StatelessWidget {
  const LangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultTheme(title: S.of(context).language),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: double.infinity),
            Text(
              S.of(context).Choose_language,
              style: FontHelper.fontText(
                  size: 18.sp,
                  weight: FontWeight.w600,
                  color: Colors.black,
                  context: context),
            ),
            SizedBox(height: 16.h),
            ChooseLanguageButton(text: 'en'),
            SizedBox(height: 12.h),
            ChooseLanguageButton(text: "ar"),
          ],
        ),
      ),
    );
  }
}
