import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/sort_by_name.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/sort_by_price.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFilterPage extends StatelessWidget {
  const MainFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
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

            // // أقسام
            // ListTile(
            //   title: Text(
            //     S.of(context).category,
            //     style: FontHelper.fontText(
            //         context: context,
            //         size: 16.sp,
            //         weight: FontWeight.w700,
            //         color: Colors.black),
            //   ),
            //   trailing: Icon(Icons.chevron_right_rounded, size: 30.sp),
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             CategoriesFilterPage(), // صفحة الأقسام
            //       ),
            //     );
            //   },
            // ),
            // Divider(),

            // البراندات
            ListTile(
              title: Text(
                S.of(context).filter_by_price,
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
                    builder: (context) => SortByPrice(),
                  ),
                );
              },
            ),
            Divider(),

            // sort by name
            ListTile(
              title: Text(
                S.of(context).sort_by,
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
                    builder: (context) => SortByName(), // صفحة الأقسام
                  ),
                );
              },
            ),
            Divider(),
            SizedBox(height: 20.h),
            BlocConsumer<HomeCubit, HomeState>(
              bloc: homeCubit,
              listenWhen: (previous, current) =>
                  current is FilterLoading ||
                  current is FilterLoaded ||
                  current is FilterError,
              listener: (context, state) {
                if (state is FilterLoaded) {
                  Navigator.of(context, rootNavigator: true).pop();
                } else if (state is FilterError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current is FilterLoading ||
                  current is FilterLoaded ||
                  current is FilterError,
              builder: (context, state) {
                if (state is FilterLoading) {
                  return MyButton1(
                    width: double.infinity,
                    height: 55,
                    buttonTitle: S.of(context).loading,
                    onTap: null,
                    isLoading: true,
                  );
                }
                return MyButton1(
                    width: double.infinity,
                    height: 55,
                    buttonTitle: S.of(context).apply_filters,
                    onTap: () {
                      homeCubit.filterProducts();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
