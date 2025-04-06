import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/button_plus_minus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterPlusMinus extends StatefulWidget {
  const CounterPlusMinus({super.key});

  @override
  State<CounterPlusMinus> createState() => _CounterPlusMinusState();
}

class _CounterPlusMinusState extends State<CounterPlusMinus> {
  // int count = 1;
  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);

    return SizedBox(
      height: 36.h,
      width: 100.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.6),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          bloc: productDetailsCubit,
          buildWhen: (previous, current) =>
              current is ProductDetailsQuantityChanged,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonPlusMinus(
                  onTap: () {
                    productDetailsCubit.increaseQuantity();
                  },
                  isMax: state is ProductDetailsQuantityChanged
                      ? state.quantity == 10
                          ? true
                          : false
                      : false,
                  icon: Icons.add,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    state is ProductDetailsQuantityChanged
                        ? state.quantity.toString()
                        : "1",
                    style: FontHelper.fontText(
                      size: 19.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                      context: context,
                    ),
                  ),
                ),
                ButtonPlusMinus(
                  onTap: () {
                    productDetailsCubit.decreaseQuantity();
                  },
                  isMax: state is ProductDetailsQuantityChanged
                      ? state.quantity == 1
                          ? true
                          : false
                      : true,
                  icon: Icons.remove,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
