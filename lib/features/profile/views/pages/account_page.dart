import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBarDefaultTheme(title: S.of(context).personal_info),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: profileCubit,
        buildWhen: (previous, current) =>
            current is AccountPageLoading ||
            current is AccountPageLoaded ||
            current is AccountPageUpdated ||
            current is AccountPageError,
        builder: (context, state) {
          if (state is AccountPageLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is AccountPageError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is AccountPageLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.grey.shade400,
                      ),
                      child: ClipPath(
                        clipBehavior: Clip.antiAlias,
                        clipper: ShapeBorderClipper(shape: CircleBorder()),
                        child: Image.asset(
                            'assets/images/home_page/face_avatar1.png',
                            height: 120.h,
                            width: 120.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 4,
                            offset: const Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        InfoCard(
                          title: S.of(context).name,
                          data: "${state.fName} ${state.lName}",
                          onTap: () {
                            showEditModalBottomSheet(
                                context,
                                S.of(context).name,
                                "${state.fName} ${state.lName}");
                          },
                        ),
                        Divider(),
                        InfoCard(
                          title: S.of(context).email,
                          data: state.email,
                          onTap: () {
                            // showEditModalBottomSheet(
                            //     context, S.of(context).email, state.email);
                          },
                        ),
                        Divider(),
                        InfoCard(
                          title: S.of(context).phone,
                          data: "0${state.phone}",
                          onTap: () {
                            showEditModalBottomSheet(
                                context, S.of(context).phone, state.phone);
                          },
                        ),
                        Divider(),
                        InfoCard(
                          title: S.of(context).gender,
                          data: state.gender,
                          onTap: () {
                            showEditModalBottomSheet(
                                context, S.of(context).gender, state.gender);
                          },
                        ),
                        Divider(),
                        InfoCard(
                          title: S.of(context).birthday,
                          data: state.birthDate,
                          onTap: () {
                            showEditModalBottomSheet(context,
                                S.of(context).birthday, state.birthDate);
                          },
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

void showEditModalBottomSheet(
    BuildContext context, String title, String initialValue) {
  final profileCubit = BlocProvider.of<ProfileCubit>(context);
  final TextEditingController controller =
      TextEditingController(text: initialValue);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 32.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: Color(0xff1D61E7),
                      borderRadius: BorderRadius.circular(8.r)),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "$title :",
                style: FontHelper.fontText(
                    size: 16.sp,
                    weight: FontWeight.w800,
                    color: Colors.black,
                    context: context),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: controller,
                style: FontHelper.fontText(
                    size: 16.sp,
                    weight: FontWeight.w600,
                    color: Colors.black,
                    context: context),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1D61E7)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff1D61E7), width: 2),
                      borderRadius: BorderRadius.circular(8.r),
                    )),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final newValue = controller.text;
                    final currentUserData = profileCubit.currentUserData;
                    Navigator.pop(context);
                    // profileCubit.getUserData();
                    final updatedUserData = currentUserData.copyWith(
                      name: title == S.of(context).name
                          ? newValue
                          : currentUserData.name,
                      email: title == S.of(context).email
                          ? newValue
                          : currentUserData.email,
                      phoneNumber: title == S.of(context).phone
                          ? newValue
                          : currentUserData.phoneNumber,
                      dateOfBirth: title == S.of(context).birthday
                          ? newValue
                          : currentUserData.dateOfBirth,
                      gender: title == S.of(context).gender
                          ? newValue
                          : currentUserData.gender,
                    );
                    profileCubit.updateUserData(updatedUserData);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    backgroundColor: Color(0xff1D61E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    S.of(context).save_changes,
                    style: FontHelper.fontText(
                        size: 17.sp,
                        weight: FontWeight.w700,
                        color: Colors.white,
                        context: context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class InfoCard extends StatelessWidget {
  final String title;
  final String data;
  final void Function() onTap;
  const InfoCard({
    super.key,
    required this.title,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: InkWell(
        onTap: title == S.of(context).email ? null : onTap,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FontHelper.fontText(
                      size: 17.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                      context: context),
                ),
                SizedBox(height: 1.h),
                Text(
                  data,
                  style: FontHelper.fontText(
                      size: 15.sp,
                      weight: FontWeight.w600,
                      color: Colors.black54,
                      context: context),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              size: 32.sp,
              color: title == S.of(context).email
                  ? Colors.black38
                  : Color(0xff1D61E7),
            ),
          ],
        ),
      ),
    );
  }
}
