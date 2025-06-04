import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/features/order/cubit/order_cubit.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/order_card_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getAllOrders();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // final cartCubit = BlocProvider.of<CartCubit>(context);
    //   // cartCubit.getCartItems();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    return Scaffold(
      appBar: AppBarDefaultTheme(
          title: S.of(context).my_orders, needLeadingButton: true),
      body: BlocBuilder<OrderCubit, OrderState>(
        bloc: orderCubit,
        buildWhen: (previous, current) =>
            current is GettingAllOrders ||
            current is GotAllOrders ||
            current is GettingAllOrdersError,
        builder: (context, state) {
          if (state is GettingAllOrders) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is GotAllOrders) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.0.h),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.0.h),
                    itemCount: state.orders.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: OrderCardItem(order: state.orders[index]),
                      );
                    },
                  ),
                  SizedBox(height: 32.0.h),
                ],
              ),
            );
          } else if (state is GettingAllOrdersError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
