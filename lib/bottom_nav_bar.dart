import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/cart/views/pages/cart_page.dart';
import 'package:e_commerce_graduation/features/favorites/views/pages/favorites_page.dart';
import 'package:e_commerce_graduation/features/home/views/pages/home_page.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/profile_page.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List _screenOptions = [
    HomePage(),
    CartPage(),
    FavoritesPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _screenOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        height: 85.h,
        decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(color: Colors.black12, width: 1)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: .1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              textStyle: FontHelper.fontText(
                  size: 14.sp, weight: FontWeight.w500, color: Colors.white),
              hoverColor: Colors.grey[100]!,
              gap: 8.w,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0xff1D61E7).withValues(alpha: 0.8),
              color: Colors.black54,
              tabs: [
                GButton(
                  icon: _selectedIndex == 0 ? Iconsax.home_15 : Iconsax.home,
                  text: S.of(context).home,
                  iconActiveColor: _selectedIndex == 0 ? Colors.white : null,
                ),
                GButton(
                  icon: _selectedIndex == 1
                      ? Iconsax.shopping_bag5
                      : Iconsax.shopping_bag,
                  text: S.of(context).cart,
                  iconActiveColor: _selectedIndex == 1 ? Colors.white : null,
                ),
                GButton(
                  icon: _selectedIndex == 2 ? Iconsax.heart5 : Iconsax.heart,
                  text: S.of(context).Favorites,
                  iconActiveColor: _selectedIndex == 2 ? Colors.white : null,
                ),
                GButton(
                  icon: _selectedIndex == 3 ? Icons.person : LineIcons.user,
                  text: S.of(context).profile,
                  iconActiveColor: _selectedIndex == 3 ? Colors.white : null,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
