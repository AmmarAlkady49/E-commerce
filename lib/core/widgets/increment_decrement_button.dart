import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncrementDecrementButton extends StatefulWidget {
  final CartItemModel cartItem;
  final bool isIncrement;
  const IncrementDecrementButton(
      {super.key, required this.cartItem, required this.isIncrement});

  @override
  State<IncrementDecrementButton> createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  bool isChanging = false;
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return BlocConsumer<CartCubit, CartState>(
      bloc: cartCubit,
      listenWhen: (previous, current) =>
          current is CartItemUpdating ||
          current is CartItemUpdated ||
          current is CartItemUpdatedError,
      listener: (context, state) {
        if (state is CartItemUpdating &&
            state.productId == widget.cartItem.productId.toString() &&
            state.isIncrement == widget.isIncrement) {
          setState(() {
            isChanging = true;
          });
        } else if (state is CartItemUpdated) {
          setState(() {
            isChanging = false;
          });
        } else if (state is CartItemUpdatedError) {
          setState(() {
            isChanging = false;
          });
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
        return InkWell(
          onTap: () {
            !isChanging
                ? widget.isIncrement
                    ? widget.cartItem.quantity < 10
                        ? cartCubit.updateProductQuantity(widget.cartItem, true)
                        : null
                    : widget.cartItem.quantity > 1
                        ? cartCubit.updateProductQuantity(
                            widget.cartItem, false)
                        : null
                : null;
          },
          borderRadius: BorderRadius.circular(50.r),
          child: Padding(
            padding: Localizations.localeOf(context).languageCode == 'ar'
                ? widget.isIncrement
                    ? const EdgeInsets.only(left: 10.0)
                    : const EdgeInsets.only(right: 10.0)
                : widget.isIncrement
                    ? const EdgeInsets.only(right: 10.0)
                    : EdgeInsets.only(left: 10.0.w),
            child: Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                color: isChanging ? Colors.grey[300] : Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(450),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                widget.isIncrement ? Icons.add : Icons.remove,
                color: widget.isIncrement
                    ? widget.cartItem.quantity < 10
                        ? isChanging
                            ? Colors.black26
                            : Colors.black
                        : Colors.black26
                    : widget.cartItem.quantity > 1
                        ? isChanging
                            ? Colors.black26
                            : Colors.black
                        : Colors.black26,
              ),
            ),
          ),
        );
      },
    );
  }
}
