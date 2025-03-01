import 'package:e_commerce_graduation/core/models/add_to_cart_model.dart';
import 'package:e_commerce_graduation/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterContainer extends StatelessWidget {
  final AddToCartModel cartItem;
  const CounterContainer({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              cartCubit.updateProductQuantity(true, cartItem);
            },
            icon: Icon(Icons.add),
          ),
          Text("${cartItem.quantity}"),
          IconButton(
            onPressed: () {
              cartCubit.updateProductQuantity(false, cartItem);
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
