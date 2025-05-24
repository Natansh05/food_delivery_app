import 'package:flutter/material.dart';
import 'package:myapp/src/common widgets/network_image_box.dart';
import 'package:myapp/src/models/cart_item.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class DetailsCard extends StatelessWidget {
  final CartItem cartItem;

  const DetailsCard({
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            // Top section: name, price, quantity, image
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Price: ₹${cartItem.food.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quantity: ${cartItem.quantity}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Food image
                  NetworkImageBox(imageUrl: cartItem.food.imagePath),
                ],
              ),
            ),

            // Add-ons (if any)
            if (cartItem.selectedAddOns.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: cartItem.selectedAddOns.map((addOn) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(
                            '${addOn.name} (₹${addOn.price.toStringAsFixed(2)})',
                            style: const TextStyle(fontSize: 13),
                          ),
                          shape: const StadiumBorder(),
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onSelected: (_) {},
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
