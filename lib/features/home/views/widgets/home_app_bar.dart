import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:skeletonizer/skeletonizer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const HomeAppBar({super.key, required this.tabController});

  @override
  Size get preferredSize => Size.fromHeight(110.h);

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
        return AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 32.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context, rootNavigator: false)
                            .pushNamed(AppRoutes.accountPage),
                        borderRadius: BorderRadius.circular(30.r),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1),
                              color: Colors.grey.shade400,
                            ),
                            child: Image.asset(
                                'assets/images/home_page/face_avatar1.png',
                                height: 55,
                                width: 55),
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
                                      '${S.of(context).hi}, ${state.userData.firstName}',
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
                        onPressed: () {},
                        icon: Icon(Iconsax.search_normal_1,
                            color: Colors.black, size: 24.sp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Iconsax.notification,
                            color: Colors.black, size: 24.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: TabBar(
                    unselectedLabelColor: Colors.black45,
                    controller: tabController,
                    labelStyle: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                        context: context),
                    unselectedLabelStyle: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w500,
                        color: Colors.black45,
                        context: context),
                    indicatorColor: Color(0xff1D61E7),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2.0,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        text: S.of(context).home,
                      ),
                      Tab(
                        text: S.of(context).category,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
