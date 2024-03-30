import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.all(10.0),
            // decoration: BoxDecoration(
            //   //borderRadius: BorderRadius.circular(12.0),
            //   border: Border.all(
            //     //color: Theme.of(context).colorScheme.secondary,
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(food.name),
                          Text('\₹'+ " "+food.price.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),),
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
                      child: Image.asset(food.imagePath,height: 100,),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          endIndent: 25,
          indent: 25,
        )
      ],
    );
  }
}
