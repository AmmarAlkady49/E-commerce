import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductResponse product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D61E7),
        title: Text(product.category!.name!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product.category!.name!),
            Text(product.creationAt!),
            // Text(product.description!),
            Text(product.id!),
          ],
        ),
      ),
    );
  }
}
