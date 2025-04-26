import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/order/cubit/order_cubit.dart';
import 'package:e_commerce_graduation/features/order/views/widgets/delivary_option_tile.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryMethodSelector extends StatelessWidget {
  const DeliveryMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (prev, curr) => curr is DeliveryMethodChanged,
      builder: (context, state) {
        final selectedMethod =
            context.read<OrderCubit>().selectedDeliveryMethod;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).choose_delivery_method,
                style: FontHelper.fontText(
                  context: context,
                  size: 16.sp,
                  weight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              DeliveryOptionTile(
                title: S.of(context).standard_delivery,
                isSelected: selectedMethod == DeliveryMethod.standard,
                onTap: () => context
                    .read<OrderCubit>()
                    .setDeliveryMethod(DeliveryMethod.standard),
                price: "20 ${S.of(context).egyption_currency}",
                subtitle: "3–7 ${S.of(context).business_days}",
              ),
              SizedBox(height: 8.h),
              DeliveryOptionTile(
                title: S.of(context).express_delivery,
                subtitle: "1-2 ${S.of(context).business_days}",
                price: "40 ${S.of(context).egyption_currency}",
                isSelected: selectedMethod == DeliveryMethod.express,
                onTap: () => context
                    .read<OrderCubit>()
                    .setDeliveryMethod(DeliveryMethod.express),
              ),
            ],
          ),
        );
      },
    );
  }
}
