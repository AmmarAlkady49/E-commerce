import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/features/cart/views/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class NotEmptyCart extends StatelessWidget {
  final List<AddToCartModel> cartItems;
  const NotEmptyCart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    debugPrint('============= ${cartItems.length}');
    debugPrint('============= ${cartItems[0].product.title}');
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return CartItem(cartItem: cartItems[index]);
            },
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.black12),
            itemCount: cartItems.length),
      ),
    );
  }
}
