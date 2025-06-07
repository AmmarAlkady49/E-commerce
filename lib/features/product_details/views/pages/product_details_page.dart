import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/product_details/cubit/product_details_cubit.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/body_of_product_details.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/bottom_of_the_product_details.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/custom_app_bar_product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return SafeArea(
      top: false,
      child: PopScope(
        canPop: true,
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          bloc: productDetailsCubit,
          buildWhen: (previous, current) =>
              current is ProductDetailsLoading ||
              current is ProductDetailsLoaded ||
              current is ProductDetailsError,
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return Scaffold(
                body: const Center(
                  child: CupertinoActivityIndicator(color: Colors.black),
                ),
              );
            } else if (state is ProductDetailsError) {
              return Scaffold(body: ErrorPage());
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return Scaffold(
                  backgroundColor: Colors.grey.shade300,
                  body: CustomScrollView(
                    slivers: [
                      CustomAppBarProductDetails(product: product),
                      BodyOfProductDetails(product: product),
                    ],
                  ),
                  bottomNavigationBar:
                      BottomOfTheProductDetails(product: product));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
