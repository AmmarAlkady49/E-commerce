import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';

class MyOrDevider extends StatelessWidget {
  final double size;
  const MyOrDevider({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey,
            indent: size,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            S.of(context).or,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey,
            endIndent: size,
          ),
        ),
      ],
    );
  }
}
