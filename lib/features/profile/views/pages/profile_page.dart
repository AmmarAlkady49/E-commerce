import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/features/profile/views/widgets/log_out_button.dart';
import 'package:e_commerce_graduation/features/profile/views/widgets/my_list_tile.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBarDefaultTheme(
        title: S.of(context).settings,
        needLeadingButton: false,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 18.0.h),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            bloc: profileCubit,
            listenWhen: (previous, current) =>
                current is ProfileLogedOut || current is ProfileLogOutError,
            buildWhen: (previous, current) => current is ProfileLogedOut,
            listener: (context, state) {
              if (state is ProfileLogedOut) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  (route) => false,
                );
              }
              if (state is ProfileLogOutError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.message,
                    style: FontHelper.fontText(
                        size: 15.sp,
                        weight: FontWeight.w600,
                        color: Colors.white,
                        context: context),
                  ),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ));
              }
            },
            builder: (context, state) {
              if (state is ProfileLogingOut) {
                return CircularProgressIndicator();
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity),
                    Text(
                      S.of(context).general,
                      style: FontHelper.fontText(
                          size: 18.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                          context: context),
                    ),
                    SizedBox(height: 12.h),
                    MyListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.accountPage);
                        },
                        title: S.of(context).personal_info,
                        leadingIcon: Iconsax.user),
                    SizedBox(height: 12.h),
                    MyListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.changePassword);
                        },
                        title: S.of(context).change_password,
                        leadingIcon: Iconsax.lock4),
                    SizedBox(height: 12.h),
                    MyListTile(
                        onTap: () {},
                        title: S.of(context).notification,
                        leadingIcon: Iconsax.notification),
                    SizedBox(height: 18.h),
                    Text(
                      S.of(context).preferences,
                      style: FontHelper.fontText(
                          size: 18.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                          context: context),
                    ),
                    SizedBox(height: 12.h),
                    MyListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.languagePage);
                        },
                        title: S.of(context).language,
                        leadingIcon: Iconsax.language_square),
                    SizedBox(height: 12.h),
                    MyListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.addressPage);
                        },
                        title: S.of(context).address,
                        leadingIcon: Iconsax.location),
                    SizedBox(height: 12.h),
                    LogOutButton(
                      leadingIcon: Iconsax.logout,
                      title: S.of(context).logout,
                      onTap: () async {
                        await profileCubit.logout();
                      },
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
