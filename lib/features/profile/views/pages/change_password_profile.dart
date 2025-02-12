import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/profile/profile_cubit/cubit/profile_cubit.dart';
import 'package:e_commerce_graduation/features/profile/views/widgets/text_form_field_change_password.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordProfile extends StatelessWidget {
  const ChangePasswordProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();

    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D61E7),
        elevation: 4.0,
        shadowColor: Colors.black,
        toolbarHeight: 55.h,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).change_password,
          style: FontHelper.fontText(
              size: 19.sp, weight: FontWeight.w800, color: Colors.white,context: context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).change_password,
                style: FontHelper.fontText(
                    size: 18.sp, weight: FontWeight.w600, color: Colors.black,context: context),
              ),
              SizedBox(height: 12.h),
              TextFormFieldChangePassword(controller: passwordController),
              SizedBox(height: 12.h),
              Text(
                '- ${S.of(context).password_instruction2}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 8.h),
              Text(
                '- ${S.of(context).password_length2}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 8.h),
              Text(
                '- ${S.of(context).password_uppercase}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 8.h),
              Text(
                '- ${S.of(context).password_lowercase}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 8.h),
              Text(
                '- ${S.of(context).password_number}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 8.h),
              Text(
                '- ${S.of(context).password_special}',
                style: FontHelper.fontText(
                    size: 14.sp,
                    weight: FontWeight.w600,
                    color: Colors.black54,context: context),
              ),
              SizedBox(height: 24.h),
              BlocConsumer<ProfileCubit, ProfileState>(
                bloc: profileCubit,
                buildWhen: (previous, current) => current is UpdateingPassword,
                listenWhen: (previous, current) =>
                    current is UpdatedPassword ||
                    current is UpdatePasswordError,
                listener: (context, state) {
                  if (state is UpdatedPassword) {
                    // Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 400.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 24.h),
                                Text(
                                  S.of(context).change_password_successfully,
                                  style: FontHelper.fontText(
                                      size: 20.sp,
                                      weight: FontWeight.w700,
                                      color: Colors.black,context: context),
                                ),
                                SizedBox(height: 12.h),
                                Image.asset(
                                  'assets/images/other/success.png',
                                  width: 160.w,
                                  height: 160.h,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  S.of(context).dont_forget_new_password,
                                  style: FontHelper.fontText(
                                      size: 16.sp,
                                      weight: FontWeight.w600,
                                      color: Colors.black54,context: context),
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          );
                        });
                  }
                  if (state is UpdatePasswordError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.message,
                        style: FontHelper.fontText(
                            size: 15.sp,
                            weight: FontWeight.w600,
                            color: Colors.white,context: context),
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
                  if (state is UpdateingPassword) {
                    MyButton1(
                      width: double.infinity,
                      height: 42.h,
                      buttonTitle: S.of(context).loading,
                      onTap: () {},
                      isLoading: true,
                    );
                  }
                  return MyButton1(
                      width: double.infinity,
                      height: 42.h,
                      buttonTitle: S.of(context).save,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await profileCubit
                              .updatePassword(passwordController.text);
                          passwordController.clear();
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
