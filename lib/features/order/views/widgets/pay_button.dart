import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/show_modal_bottom_sheet.dart';
import 'package:e_commerce_graduation/features/cart/model/cart_response_body.dart';
import 'package:e_commerce_graduation/features/order/cubit/order_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayButton extends StatelessWidget {
  final CartResponseBody cartItems;
  const PayButton({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    return BlocConsumer<OrderCubit, OrderState>(
      bloc: orderCubit,
      listenWhen: (previous, current) =>
          current is CreatedOrderWithPayment ||
          current is CreatingOrderWithPaymentError,
      listener: (context, state) {
        if (state is CreatedOrderWithPayment) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomNavBar, (route) => false);
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     S.of(context).verify_email_successfully,
          //     style: FontHelper.fontText(
          //         size: 15.sp,
          //         weight: FontWeight.w600,
          //         color: Colors.white,
          //         context: context),
          //   ),
          //   backgroundColor: Colors.green,
          //   behavior: SnackBarBehavior.floating,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(26),
          //   ),
          // ));
          ShowModalBottomSheet.show(context);
        } else if (state is CreatingOrderWithPaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.message == "empty address"
                  ? S.of(context).empty_address
                  : S.of(context).error_creating_order,
              textAlign: TextAlign.start,
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
      buildWhen: (previous, current) =>
          current is CreatingOrderWithPayment ||
          current is CreatedOrderWithPayment ||
          current is CreatingOrderWithPaymentError,
      builder: (context, state) {
        return Container(
          height: 48.h,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(AppRoutes.confirmOrderPage);
              state is CreatingOrderWithPayment
                  ? null
                  : orderCubit.createOrderWithPayment(context);
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  side: BorderSide(
                    color: MyColor.kellyGreen3.withAlpha(1000),
                    width: 1.0,
                  ),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(
                  MyColor.kellyGreen3.withValues(alpha: 0.8)),
              elevation: WidgetStateProperty.all(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).confirm_and_pay,
                  style: FontHelper.fontText(
                    context: context,
                    size: 16.sp,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                state is CreatingOrderWithPayment
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Icon(
                        HelperFunctions.isArabic(context)
                            ? Icons.keyboard_double_arrow_left_sharp
                            : Icons.keyboard_double_arrow_right,
                        color: Colors.white,
                        size: 30.sp,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
