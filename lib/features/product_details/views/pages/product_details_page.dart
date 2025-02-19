import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/body_of_product_details.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/bottom_of_the_product_details.dart';
import 'package:e_commerce_graduation/features/product_details/views/widgets/custom_app_bar_product_details.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductResponse product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: CustomScrollView(
          slivers: [
            CustomAppBarProductDetails(product: product),
            BodyOfProductDetails(product: product),
          ],
        ),
        bottomNavigationBar: BottomOfTheProductDetails(product: product));
  }
}
