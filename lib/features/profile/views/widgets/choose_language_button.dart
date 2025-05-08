import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguageButton extends StatefulWidget {
  final String text;
  const ChooseLanguageButton({super.key, required this.text});

  @override
  State<ChooseLanguageButton> createState() => _ChooseLanguageButtonState();
}

class _ChooseLanguageButtonState extends State<ChooseLanguageButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: Localizations.localeOf(context).languageCode ==
                        widget.text
                    ? const BorderSide(color: MyColor.kellyGreen3, width: 1.5)
                    : const BorderSide(color: Colors.black38, width: 1.0))),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h))),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          final resultLanguage = pref.getString('lang');
          if (resultLanguage != widget.text) {
            await pref.setString('lang', widget.text);
            Restart.restartApp();
          }
        },
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Image.asset(
              widget.text == 'en'
                  ? 'assets/images/other/england_flag.png'
                  : 'assets/images/other/egypt_flag.png',
              height: 40.h,
              width: 40.w,
            ),
            SizedBox(width: 12.w),
            Text(
              widget.text == 'en' ? 'English' : 'العربية',
              style: FontHelper.fontText(
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: Colors.black,
                  context: context),
            ),
            Spacer(),
            Icon(
              Localizations.localeOf(context).languageCode == widget.text
                  // ? Icons.check_box
                  ? CupertinoIcons.checkmark_alt
                  : null,
              size: 28.sp,
              color: MyColor.kellyGreen3,
            ),
            SizedBox(width: 8.w),
          ],
        ));
  }
}
