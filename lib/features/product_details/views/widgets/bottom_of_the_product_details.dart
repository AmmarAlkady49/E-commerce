import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/add_to_cart_button.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class BottomOfTheProductDetails extends StatelessWidget {
  final ProductResponse product;
  const BottomOfTheProductDetails({super.key, required this.product});
  void _showAddToCartSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      btnOk: btnDialog(context),
      btnCancel: btnDialog(context, isCancel: true),
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      dialogBackgroundColor: MyColor.white,
      barrierColor: Colors.black.withAlpha(175),
      title: S.of(context).product_added_successfully,
      desc: S.of(context).what_would_you_like_to_do_next,
      titleTextStyle: FontHelper.fontText(
        size: 18.sp,
        weight: FontWeight.w700,
        color: Colors.black87,
        context: context,
      ),
      descTextStyle: FontHelper.fontText(
        size: 14.sp,
        weight: FontWeight.w600,
        color: Colors.black54,
        context: context,
      ),
      borderSide: BorderSide(
        color: MyColor.kellyGreen3.withAlpha(40),
        width: 2,
      ),
      showCloseIcon: true,
      closeIcon: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          color: Colors.black54,
          size: 20.sp,
        ),
      ),
      // buttonsBorderRadius: BorderRadius.circular(25.r),
      dialogBorderRadius: BorderRadius.circular(20.r),
      headerAnimationLoop: false,
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, AppRoutes.accountPage);
      },
      buttonsTextStyle: FontHelper.fontText(
        size: 16.sp,
        weight: FontWeight.w700,
        color: Colors.white,
        context: context,
      ),
      btnOkText: S.of(context).go_to_cart,
      btnOkColor: MyColor.kellyGreen3,
      btnOkIcon: Iconsax.shopping_cart,
      btnCancelOnPress: () {
        // Navigator.pop(context);
      },
      btnCancelText: S.of(context).continue_shopping,
      btnCancelColor: Colors.grey.shade400,
      btnCancelIcon: Iconsax.shop,
      customHeader: Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: MyColor.kellyGreen3.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(
            color: MyColor.kellyGreen3.withAlpha(120),
            width: 2,
          ),
        ),
        child: Icon(
          Iconsax.bag_tick,
          color: MyColor.kellyGreen3,
          size: 40.sp,
        ),
      ),
    ).show();
  }

  InkWell btnDialog(BuildContext context, {bool isCancel = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      splashColor: Colors.white.withAlpha(100),
      onTap: () {
        if (isCancel) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.bottomNavBar,
              arguments: 1);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isCancel ? Colors.grey.shade400 : MyColor.kellyGreen3,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isCancel ? Iconsax.shop : Iconsax.shopping_cart,
                color: Colors.white, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              isCancel
                  ? S.of(context).continue_shopping
                  : S.of(context).go_to_cart,
              style: FontHelper.fontText(
                size: 10.5.sp,
                weight: FontWeight.w800,
                color: Colors.white,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      listenWhen: (previous, current) => current is ProductAddedToCart,
      listener: (context, state) {
        if (state is ProductAddedToCart) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _showAddToCartSuccessDialog(context);
          });
        }
      },
      buildWhen: (previous, current) =>
          current is ProductAddingToCart ||
          current is ProductAddedToCart ||
          current is ProductAddedToCartError,
      builder: (context, state) {
        return Container(
          height: 65.h,
          padding: EdgeInsets.only(bottom: 16.0.h),
          decoration: BoxDecoration(color: MyColor.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Row(
              children: [
                state is ProductAddingToCart
                    ? AddToCartButton(
                        onTap: () {},
                        status: "loading",
                      )
                    : state is ProductAddedToCart
                        ? AddToCartButton(
                            onTap: () {},
                            status: "added",
                          )
                        : AddToCartButton(
                            onTap: () {
                              productDetailsCubit.addToCart(
                                product.productID.toString(),
                                productDetailsCubit.quantity,
                              );
                            },
                            status: "add"),
                Spacer(),
                BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  bloc: productDetailsCubit,
                  buildWhen: (previous, current) =>
                      current is ProductDetailsQuantityChanged,
                  builder: (context, state) {
                    final totalPrice = state is ProductDetailsQuantityChanged
                        ? state.quantity * product.price!
                        : product.price;
                    return Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: " ${totalPrice!.toStringAsFixed(2)} ",
                          style: FontHelper.fontText(
                            size: 22.sp,
                            shadows: [
                              const Shadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            weight: FontWeight.w700,
                            color: Colors.black,
                            context: context,
                          ),
                        ),
                        TextSpan(
                          text: S.of(context).egyption_currency,
                          style: FontHelper.fontText(
                            size: 18.sp,
                            shadows: [
                              const Shadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            weight: FontWeight.w800,
                            color: MyColor.kellyGreen3,
                            context: context,
                          ),
                        ),
                      ]),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
