import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/show_modal_bottom_sheet.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
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
                                        border: state.photoUrl != ''
                                            ? null
                                            : Border.all(
                                                color: Colors.black, width: 1),
                                        color: Colors.grey.shade400,
                                      ),
                                      child: state.photoUrl != ''
                                          ? Image.network(
                                              state.photoUrl,
                                              height: 47,
                                              width: 47,
                                              cacheHeight: 151,
                                              cacheWidth: 151,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/home_page/face_avatar1.png',
                                                height: 47,
                                                width: 47,
                                                cacheHeight: 151,
                                                cacheWidth: 151,
                                              ),
                                            )
                                          : state.gender == 'female'
                                              ? Image.asset(
                                                  'assets/images/home_page/face_avatar2.png',
                                                  height: 47,
                                                  width: 47,
                                                  cacheHeight: 151,
                                                  cacheWidth: 151,
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.asset(
                                                  'assets/images/home_page/face_avatar1.png',
                                                  height: 47,
                                                  width: 47,
                                                  cacheHeight: 151,
                                                  cacheWidth: 151,
                                                )),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 47.w,
                                    height: 47.h,
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
                        IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomeSearch(homeCubit: homeCubit));
                          },
                          icon: Icon(Iconsax.search_normal_1,
                              color: Colors.black, size: 24.sp),
                        ),
                        IconButton(
                          onPressed: () async {
                            ShowModalBottomSheet.show(context);
                          },
                          icon: Icon(Iconsax.notification,
                              color: Colors.black, size: 24.sp),
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
