import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberAndForgetLogin extends StatefulWidget {
  const RememberAndForgetLogin({super.key});

  @override
  State<RememberAndForgetLogin> createState() => _RememberAndForgetLoginState();
}

class _RememberAndForgetLoginState extends State<RememberAndForgetLogin> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = false; // Default value
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelected = prefs.getBool('rememberMe') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isSelected,
              activeColor: const Color(0xff1D61E7),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) async {
                setState(() {
                  isSelected = value!;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('rememberMe', value!);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
                side: const BorderSide(color: Colors.red, width: 2.0),
              ),
            ),
            Text(
              S.of(context).remember_me,
              style: FontHelper.fontText(
                  size: 13.sp, weight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.forgotPassword);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Text(
            S.of(context).forgot_password,
            style: FontHelper.fontText(
                size: 13.sp,
                weight: FontWeight.w700,
                color: const Color.fromARGB(255, 44, 103, 223)),
          ),
        ),
      ],
    );
  }
}
