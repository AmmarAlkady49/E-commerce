import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesFilterPage extends StatelessWidget {
  const CategoriesFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              S.of(context).category,
              style: FontHelper.fontText(
                  context: context,
                  size: 20.sp,
                  weight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            MyButton1(
                width: double.infinity,
                height: 50,
                buttonTitle: S.of(context).apply_filters,
                onTap: () {
                  Navigator.pop(context); // Close modal
                  // Trigger filter logic
                }),
          ],
        ),
      ),
    );
  }
}
