import 'package:flutter/material.dart';

class CategoriesFilterPage extends StatelessWidget {
  const CategoriesFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الخط اللي فوق
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

            // عنوان الصفحة
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.of(context).pop(); // رجوع للصفحة اللي قبلها
                  },
                ),
                SizedBox(width: 8),
                Text(
                  'الأقسام',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // قائمة الأقسام
            Expanded(
              child: ListView.separated(
                itemCount: 5, // عدد الأقسام (مثال)
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  // مثال على أقسام
                  final categories = [
                    'كتب',
                    'تصنيفات الصيف',
                    'ملابس',
                    'أجهزة كهربائية',
                    'أدوات منزلية'
                  ];
                  final categoryName = categories[index];

                  return ListTile(
                    title: Text(categoryName),
                    trailing: Icon(Icons.add),
                    onTap: () {
                      // هنا ممكن تعمل select للفلتر
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
