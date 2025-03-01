import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/empty_cart.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/not_empty_cart.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBarDefaultTheme(
          title: S.of(context).cart,
          actions: [
            SizedBox(width: 10.w),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTapUp: (TapUpDetails details) {
                final RenderBox renderBox =
                    context.findRenderObject() as RenderBox;
                final Offset offset =
                    renderBox.localToGlobal(details.globalPosition);

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(offset.dx + -50,
                      offset.dy + 20.h, offset.dx + 40, offset.dy + 10),
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
                              color: Colors.red.shade700)),
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 200), () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(S.of(context).confirm_deletion,
                                  style: FontHelper.fontText(
                                      context: context,
                                      size: 18.sp,
                                      weight: FontWeight.w700,
                                      color: Colors.black87)),
                              content: Text(S.of(context).are_you_sure2,
                                  style: FontHelper.fontText(
                                      context: context,
                                      size: 14.sp,
                                      weight: FontWeight.w700,
                                      color: Colors.black54)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    S.of(context).cancel,
                                    style: FontHelper.fontText(
                                        color: Colors.black,
                                        context: context,
                                        size: 13.sp,
                                        weight: FontWeight.w700),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cartCubit.clearTheCart();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: Text(
                                    S.of(context).delete.toUpperCase(),
                                    style: FontHelper.fontText(
                                        color: Colors.white,
                                        context: context,
                                        size: 13.sp,
                                        weight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ],
                );
              },
              child:
                  Icon(CupertinoIcons.ellipsis_vertical, color: Colors.white),
            ),
            SizedBox(width: 10.w),
          ],
          needLeadingButton: false),
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (previous, current) => current is CartItemDeleted,
        listener: (context, state) {
          if (state is CartItemDeleted) {
            cartCubit.getCartItems();
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
            return Center(child: Text(state.message));
          } else {
            final cartItems = (state as CartLoaded).cartItems;
            if (cartItems.isEmpty) {
              return EmptyCart();
            } else {
              return NotEmptyCart(cartItems: cartItems);
            }
          }
        },
      ),
    );
  }
}
