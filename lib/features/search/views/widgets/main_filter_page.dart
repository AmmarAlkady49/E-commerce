import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/categories_filter_page.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFilterPage extends StatelessWidget {
  const MainFilterPage({super.key});

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
              S.of(context).filter,
              style: FontHelper.fontText(
                  context: context,
                  size: 20.sp,
                  weight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),

            // أقسام
            ListTile(
              title: Text(
                S.of(context).category,
                style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w700,
                    color: Colors.black),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 30.sp),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoriesFilterPage(), // صفحة الأقسام
                  ),
                );
              },
            ),
            Divider(),

            // البراندات
            ListTile(
              title: Text(
                S.of(context).price,
                style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w700,
                    color: Colors.black),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 30.sp),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoriesFilterPage(), // صفحة الأقسام
                  ),
                );
              },
            ),
            Divider(),

            // الألوان
            ListTile(
              title: Text(
                S.of(context).category,
                style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w700,
                    color: Colors.black),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 30.sp),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoriesFilterPage(), // صفحة الأقسام
                  ),
                );
              },
            ),
            Divider(),

            // الأسعار (ممكن هنا تحطهم كبادجات زي الصورة اللي بعتهالي)
            SizedBox(height: 20),
            Text(
              'السعر',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(label: Text('0-100 ج.م'), onSelected: (_) {}),
                FilterChip(label: Text('100-200 ج.م'), onSelected: (_) {}),
                FilterChip(label: Text('200-300 ج.م'), onSelected: (_) {}),
                FilterChip(label: Text('300-600 ج.م'), onSelected: (_) {}),
                FilterChip(label: Text('600-1000 ج.م'), onSelected: (_) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
