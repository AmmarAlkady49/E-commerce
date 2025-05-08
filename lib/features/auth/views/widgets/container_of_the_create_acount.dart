import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_button2.dart';
import 'package:e_commerce_graduation/core/widgets/my_or_devider.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/features/auth/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ContainerOfTheCreateAcount extends StatefulWidget {
  const ContainerOfTheCreateAcount({super.key});

  @override
  State<ContainerOfTheCreateAcount> createState() =>
      _ContainerOfTheCreateAcountState();
}

class _ContainerOfTheCreateAcountState
    extends State<ContainerOfTheCreateAcount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController birthOfDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode fNameFocusNode = FocusNode();
  final FocusNode lNameFocusNode = FocusNode();
  final FocusNode birthOfDateFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    birthOfDateController.dispose();
    phoneController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    fNameFocusNode.dispose();
    lNameFocusNode.dispose();
    birthOfDateFocusNode.dispose();
    phoneFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  DateTime? _lastPickedDate;
  Future<void> _selectDate() async {
    DateTime? picked;
    picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: _lastPickedDate ?? DateTime.now(),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _lastPickedDate = picked;
        birthOfDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        color: MyColor.seasalt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 12.0.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextFormField(
                      width: size.width * 0.395,
                      hint: S.of(context).first_name,
                      textInputType: TextInputType.name,
                      controller: fNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).empty_cell;
                        }
                        if (value.length < 3) {
                          return S.of(context).invalid_name;
                        }
                        return null;
                      },
                      presentFocusNode: fNameFocusNode,
                      nextFocusNode: lNameFocusNode,
                    ),
                    MyTextFormField(
                      width: size.width * 0.395,
                      hint: S.of(context).last_name,
                      textInputType: TextInputType.name,
                      controller: lNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).empty_cell;
                        }
                        if (value.length < 3) {
                          return S.of(context).invalid_name;
                        }
                        return null;
                      },
                      presentFocusNode: lNameFocusNode,
                      nextFocusNode: emailFocusNode,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 13.h),
              MyTextFormField(
                width: size.width * 0.8,
                hint: S.of(context).email,
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty_cell;
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return S.of(context).invalid_email;
                  }
                  return null;
                },
                presentFocusNode: emailFocusNode,
                nextFocusNode: birthOfDateFocusNode,
              ),
              SizedBox(height: 13.h),
              MyTextFormField(
                width: size.width * 0.8,
                hint: S.of(context).birthday,
                suffIcon: Iconsax.calendar_1,
                controller: birthOfDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty_cell;
                  }
                  return null;
                },
                presentFocusNode: birthOfDateFocusNode,
                nextFocusNode: phoneFocusNode,
                readOnly: true,
                onTap: _selectDate,
              ),
              SizedBox(height: 13.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: MyTextFormField(
                  width: size.width * 0.8,
                  hint: S.of(context).phone,
                  textInputType: TextInputType.phone,
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).empty_cell;
                    }
                    if (value.length != 10) {
                      return S.of(context).invalid_phone;
                    }
                    return null;
                  },
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+20',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Container(
                        width: 1,
                        height: 18.h,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  presentFocusNode: phoneFocusNode,
                  nextFocusNode: passwordFocusNode,
                ),
              ),
              SizedBox(height: 13.h),
              MyTextFormField(
                width: size.width * 0.8,
                hint: S.of(context).password,
                textInputType: TextInputType.visiblePassword,
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty_cell;
                  }
                  if (value.length < 5) {
                    return S.of(context).password_length;
                  }
                  return null;
                },
                presentFocusNode: passwordFocusNode,
                nextFocusNode: confirmPasswordFocusNode,
              ),
              SizedBox(height: 13.h),
              MyTextFormField(
                width: size.width * 0.8,
                hint: S.of(context).confirm_password,
                textInputType: TextInputType.visiblePassword,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).empty_cell;
                  }
                  if (value.length < 5) {
                    return S.of(context).password_length;
                  }
                  if (value != passwordController.text) {
                    return S.of(context).password_not_match;
                  }
                  return null;
                },
                presentFocusNode: confirmPasswordFocusNode,
                nextFocusNode: null,
              ),
              SizedBox(height: 15.h),
              BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is CreatingAccoutSuccess ||
                    current is AuthError ||
                    current is AuthErrorVerification,
                listener: (context, state) {
                  if (state is CreatingAccoutSuccess) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.verifyEmail,
                      arguments: {
                        "email": emailController.text,
                        "pageType": "register",
                      },
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.message,
                        textAlign: TextAlign.left,
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
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is AuthLoading ||
                    current is AuthErrorVerification ||
                    current is CreatingAccoutSuccess ||
                    current is AuthError,
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return MyButton1(
                      buttonTitle: S.of(context).create_account,
                      height: 42.h,
                      width: size.width * 0.8,
                      onTap: null,
                      isLoading: true,
                    );
                  }
                  return MyButton1(
                    buttonTitle: S.of(context).create_account,
                    height: 42.h,
                    width: size.width * 0.8,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await cubit.createAccount(
                          email: emailController.text,
                          password: passwordController.text,
                          fName: fNameController.text,
                          lName: lNameController.text,
                          phone: phoneController.text,
                          birthDate: birthOfDateController.text,
                        );
                        // cubit.sendEmailVerification();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 13.h),
              MyOrDevider(size: size.width * 0.02, text: S.of(context).or),
              SizedBox(height: 13.h),
              SizedBox(
                width: size.width * 0.8,
                child: MyButton2(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
