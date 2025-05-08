import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/order/cubit/order_cubit.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/address_container_widget.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/delivery_method_selector.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/list_of_oder_products.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/pay_button.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/total_subtotal_info.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderCubit>().getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    return Scaffold(
      backgroundColor: MyColor.seasalt,
      appBar: AppBarDefaultTheme(
          title: S.of(context).payment_process, needLeadingButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: BlocBuilder<OrderCubit, OrderState>(
          bloc: orderCubit,
          buildWhen: (previous, current) =>
              current is CartItemsLoading ||
              current is CartItemsLoaded ||
              current is CartItemsError,
          builder: (context, state) {
            if (state is CartItemsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is CartItemsError) {
              return Center(child: Text(state.message));
            } else if (state is CartItemsLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    AddressContainerWidget(),
                    SizedBox(height: 16.h),
                    ListOfOderProducts(cartItems: state.cartItems.items),
                    SizedBox(height: 16.h),
                    DeliveryMethodSelector(),
                    SizedBox(height: 16.h),
                    TotalSubtotalInfo(cartItems: state.cartItems),
                    SizedBox(height: 16.h),
                    PayButton(cartItems: state.cartItems),
                    SizedBox(height: 32.h),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
