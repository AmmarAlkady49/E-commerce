import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDefaultTheme(
          title: S.of(context).cart,
          needLeadingButton: false,
        ),
        body: Center(
          child: Text('Cart Page'),
        ));
  }
}
