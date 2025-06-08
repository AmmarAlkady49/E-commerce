import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/utils/themes/notification_storage.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/custome_search.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(0.h);

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      buildWhen: (previous, current) =>
          current is HomeInitial ||
          current is HomeAppBarLoading ||
          current is HomeAppBarLoaded,
      builder: (context, state) {
        return SafeArea(
          child: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 8.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () =>
                              Navigator.of(context, rootNavigator: false)
                                  .pushNamed(AppRoutes.accountPage)
                                  .then((value) {
                            // if (value == true) {
                            homeCubit.getUserData();
                            // }
                          }),
                          borderRadius: BorderRadius.circular(30.r),
                          child: state is HomeAppBarLoaded
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade200,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: state.photoUrl != ''
                                          ? Image.network(
                                              state.photoUrl,
                                              height: 48.sp,
                                              width: 48.sp,
                                              cacheHeight: 151,
                                              cacheWidth: 151,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/home_page/face_avatar1.png',
                                                height: 48.sp,
                                                width: 48.sp,
                                                cacheHeight: 151,
                                                cacheWidth: 151,
                                              ),
                                            )
                                          : state.gender == 'female'
                                              ? Image.asset(
                                                  'assets/images/home_page/face_avatar2.png',
                                                  height: 48.sp,
                                                  width: 48.sp,
                                                  cacheHeight: 151,
                                                  cacheWidth: 151,
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.asset(
                                                  'assets/images/home_page/face_avatar1.png',
                                                  height: 48.sp,
                                                  width: 48.sp,
                                                  cacheHeight: 151,
                                                  cacheWidth: 151,
                                                )),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 48.sp,
                                    height: 48.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state is HomeAppBarLoading
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 80.w,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : state is HomeAppBarLoaded
                                    ? Text(
                                        '${S.of(context).hi}, ${state.userName}',
                                        style: FontHelper.fontText(
                                            size: 15.sp,
                                            weight: FontWeight.w700,
                                            color: Colors.black,
                                            context: context))
                                    : const Text(''),
                            SizedBox(height: 2.h),
                            Text(
                              S.of(context).lets_go_shopping,
                              style: FontHelper.fontText(
                                  size: 12.sp,
                                  weight: FontWeight.w400,
                                  color: Colors.black45,
                                  context: context),
                            )
                          ],
                        ),
                        const Spacer(),
                        // IconButton(
                        //   onPressed: () {
                        //     showSearch(
                        //         context: context,
                        //         delegate: CustomeSearch(homeCubit: homeCubit));
                        //   },
                        //   icon: Icon(Iconsax.search_normal_1,
                        //       color: Colors.black, size: 24.sp),
                        // ),
                        // IconButton(
                        //   onPressed: () async {
                        //     List<NotificationMessageModel> notifications =
                        //         await NotificationStorage.loadNotifications();

                        //     Navigator.pushNamed(
                        //         context, AppRoutes.notificationPage,
                        //         arguments: notifications);
                        //   },
                        //   icon: Icon(Iconsax.notification,
                        //       color: Colors.black, size: 24.sp),
                        // ),
                        _buildActionButton(
                          icon: Iconsax.search_normal_1,
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomeSearch(homeCubit: homeCubit));
                          },
                        ),
                        SizedBox(width: 8.w),
                        _buildActionButton(
                          icon: Iconsax.notification,
                          hasNotification: state is HomeAppBarLoaded
                              ? state.hasNotification
                              : false,
                          onPressed: () async {
                            List<NotificationMessageModel> notifications =
                                await NotificationStorage.loadNotifications();

                            Navigator.pushNamed(
                                    context, AppRoutes.notificationPage,
                                    arguments: notifications)
                                .then((value) {
                              homeCubit.getUserData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildActionButton({
  required IconData icon,
  required VoidCallback onPressed,
  bool hasNotification = false,
}) {
  return Stack(
    children: [
      SizedBox(
        width: 45.w,
        height: 45.h,
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.black,
            size: 24.sp,
          ),
          padding: EdgeInsets.zero,
        ),
      ),

      // Notification Badge
      if (hasNotification)
        Positioned(
          right: 8.w,
          top: 8.h,
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: MyColor.poppy,
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColor.white,
                width: 1.5,
              ),
            ),
          ),
        ),
    ],
  );
}
