import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/build_lost_connection_widget.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/views/pages/cart_page.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/views/pages/favorites_page.dart';
import 'package:e_commerce_graduation/features/home/views/pages/home_page.dart';
import 'package:e_commerce_graduation/features/profile/views/pages/profile_page.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
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

  static List screenOptions = [
    HomePage(),
    CartPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavoritesCubit>().getFavoriteProducts(context);
      context.read<CartCubit>().getCartItems();
      // context.read<NotificationCubit>().getDummyRepeatedNotificationList();
    });
  }

  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => setState(() {
              _selectedIndex = 0;
            }),
        child: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);

              return Scaffold(
                backgroundColor: MyColor.seasalt,
                body: connected
                    ? screenOptions.elementAt(_selectedIndex)
                    : BuildLostConnectionWidget(),
                bottomNavigationBar: connected
                    ? Container(
                        decoration: BoxDecoration(
                          color: MyColor.seasalt,
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(20.r),
                          //     topRight: Radius.circular(20.r)),
                          border:
                              Border(top: BorderSide(color: Colors.black12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.6),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SafeArea(
                          bottom: true,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: GNav(
                              textStyle: FontHelper.fontText(
                                  size: 14.sp,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                  context: context),
                              hoverColor: Colors.grey[200]!,
                              gap: 8.w,
                              iconSize: 24,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 10.h),
                              duration: Duration(milliseconds: 400),
                              tabBackgroundColor: MyColor.kellyGreen3,
                              color: Colors.black54,
                              tabs: [
                                GButton(
                                  icon: _selectedIndex == 0
                                      ? Iconsax.home_15
                                      : Iconsax.home,
                                  text: S.of(context).home,
                                  iconActiveColor:
                                      _selectedIndex == 0 ? Colors.white : null,
                                ),
                                GButton(
                                  icon: _selectedIndex == 1
                                      ? Iconsax.shopping_bag5
                                      : Iconsax.shopping_bag,
                                  text: S.of(context).cart,
                                  iconActiveColor:
                                      _selectedIndex == 1 ? Colors.white : null,
                                ),
                                GButton(
                                  icon: _selectedIndex == 2
                                      ? Iconsax.heart5
                                      : Iconsax.heart,
                                  text: S.of(context).Favorites,
                                  iconActiveColor:
                                      _selectedIndex == 2 ? Colors.white : null,
                                ),
                                GButton(
                                  icon: _selectedIndex == 3
                                      ? Icons.person
                                      : LineIcons.user,
                                  text: S.of(context).profile,
                                  iconActiveColor:
                                      _selectedIndex == 3 ? Colors.white : null,
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
                      )
                    : null,
              );
            },
            child: SizedBox.shrink(),
          ),
        ));
  }
}
