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
      appBar: AppBar(
        backgroundColor: Color(0xff1D61E7),
        elevation: 4.0,
        shadowColor: Colors.black,
        toolbarHeight: 55.h,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).language,
          style: FontHelper.fontText(
              size: 19.sp, weight: FontWeight.w800, color: Colors.white,context: context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: double.infinity),
            Text(
              S.of(context).Choose_language,
              style: FontHelper.fontText(
                  size: 18.sp, weight: FontWeight.w600, color: Colors.black,context: context),
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
