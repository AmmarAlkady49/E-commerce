import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/main_filter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(MyColor.kellyGreen2.withAlpha(200)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
      icon: const Icon(CupertinoIcons.slider_horizontal_3, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          isDismissible: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Navigator(
                onGenerateInitialRoutes: (navigatorContext, initialRoute) {
                  return [
                    MaterialPageRoute(
                      builder: (navigatorContext) => MainFilterPage(),
                    ),
                  ];
                },
              ),
            );
          },
        );
      },
    );
  }
}
