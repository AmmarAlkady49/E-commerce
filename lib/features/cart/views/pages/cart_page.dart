import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/empty_cart.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/not_empty_cart.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/checkout_button_bottom.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final cartCubit = BlocProvider.of<CartCubit>(context);
      // cartCubit.getCartItems();
      context.read<CartCubit>().getCartItems();
    });
  }

  void _showModernConfirmationDialog(
      BuildContext context, CartCubit cartCubit) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      dialogBackgroundColor: MyColor.white,
      barrierColor: Colors.black.withAlpha(175),
      title: S.of(context).confirm_deletion,
      desc: S.of(context).are_you_sure,
      titleTextStyle: FontHelper.fontText(
        size: 20.sp,
        weight: FontWeight.w800,
        color: Colors.black87,
        context: context,
      ),
      descTextStyle: FontHelper.fontText(
        size: 16.sp,
        weight: FontWeight.w600,
        color: Colors.black54,
        context: context,
      ),
      borderSide: BorderSide(
        color: MyColor.poppy.withAlpha(60),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      dialogBorderRadius: BorderRadius.circular(20.r),
      headerAnimationLoop: false,
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
      // Custom header with warning icon
      customHeader: Container(
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: MyColor.poppy.withAlpha(20),
          shape: BoxShape.circle,
          border: Border.all(
            color: MyColor.poppy.withAlpha(100),
            width: 3,
          ),
        ),
        child: Icon(
          Iconsax.warning_2,
          color: MyColor.poppy,
          size: 45.sp,
        ),
      ),
      // Cancel button
      btnCancelOnPress: () {},
      btnCancelText: S.of(context).cancel,
      btnCancelColor: Colors.grey.shade500,
      btnCancelIcon: Iconsax.close_circle,
      // Confirm delete button
      btnOkOnPress: () {
        cartCubit.clearTheCart();
      },
      btnOkText: S.of(context).delete.toUpperCase(),
      btnOkColor: MyColor.poppy,
      btnOkIcon: Iconsax.trash,
      // Enhanced button styling
      buttonsTextStyle: FontHelper.fontText(
        size: 16.sp,
        weight: FontWeight.w700,
        color: Colors.white,
        context: context,
      ),
      buttonsBorderRadius: BorderRadius.circular(25.r),
      // Animation and interaction enhancements
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      useRootNavigator: true,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBarDefaultTheme(
        title: S.of(context).cart,
        actions: [
          SizedBox(width: 10.w),
          Builder(builder: (context) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTapUp: (TapUpDetails details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final Offset offset =
                    renderBox.localToGlobal(details.globalPosition);

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(offset.dx + -70,
                      offset.dy + -6.h, offset.dx + 40, offset.dy + 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  items: [
                    PopupMenuItem(
                      child: Text(S.of(context).delete_all,
                          style: FontHelper.fontText(
                              context: context,
                              size: 14.sp,
                              weight: FontWeight.w600,
                              color: MyColor.poppy)),
                      onTap: () {
                        _showModernConfirmationDialog(context, cartCubit);
                      },
                    ),
                  ],
                );
              },
              child:
                  Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
            );
          }),
          SizedBox(width: 10.w),
        ],
        needLeadingButton: false,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            current is CartItemUpdated ||
            current is CartItemDeleted ||
            current is CartItemDeletedError ||
            current is CartItemUpdatedError ||
            current is CartError,
        listener: (context, state) {
          if (state is CartItemUpdated || state is CartItemDeleted) {
            cartCubit.getCartItems();
          }

          if (state is CartItemUpdatedError ||
              state is CartItemDeletedError ||
              state is CartError) {
            cartCubit.hasFetchedCart = false;
            if ((state is CartError && state.error == 'Too many requests') ||
                (state is CartItemDeletedError &&
                    state.error == 'Too many requests') ||
                (state is CartItemUpdatedError &&
                    state.error == 'Too many requests')) {
              Navigator.pushNamed(context, AppRoutes.tooManyRequestPage);
            }
          }
        },
        bloc: cartCubit,
        buildWhen: (previous, current) =>
            current is CartLoading ||
            current is CartLoaded ||
            current is CartError,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is CartError) {
            return ErrorPage();
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;
            if (cartItems.items.isEmpty) {
              return EmptyCart();
            } else {
              return NotEmptyCart(cartItems: cartItems);
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      // Bottom Bar
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        buildWhen: (previous, current) =>
            current is CartLoading ||
            current is CartLoaded ||
            current is CartError,
        builder: (context, state) {
          final showBottomBar =
              state is CartLoaded && state.cartItems.items.isNotEmpty;

          if (state is CartLoaded) {
            if (showBottomBar) {
              final cartItems = state.cartItems;

              return CheckoutButtonBottom(cartItems: cartItems);
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
