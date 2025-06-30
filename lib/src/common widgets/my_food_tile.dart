import 'package:flutter/material.dart';
import 'package:FlavorFleet/src/common%20widgets/network_image_box.dart';

import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.surface),
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '₹ ${food.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(food.description),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 15.0,
                  ),

                  // food image
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: NetworkImageBox(imageUrl: food.imagePath)),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          endIndent: 15,
          indent: 15,
        )
      ],
    );
  }
}
