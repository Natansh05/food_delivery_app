import 'package:flutter/material.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class CartIconWithBadge extends StatelessWidget {
  final VoidCallback onTap;

  const CartIconWithBadge({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<Restaurant>().getTotalItems();

    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: onTap,
        ),
        if (count > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
