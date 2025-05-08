import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/add_to_cart_button.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomOfTheProductDetails extends StatelessWidget {
  final ProductResponse product;
  const BottomOfTheProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductAddingToCart ||
          current is ProductAddedToCart ||
          current is ProductAddedToCartError,
      builder: (context, state) {
        return Container(
          height: 65.h,
          decoration: BoxDecoration(
            // color: Color(0xfffefffe),
            color: MyColor.white,
            // color: Colors.amber,
          ),
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
                            size: 23.sp,
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
                            size: 19.sp,
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
