import 'package:flutter/material.dart';
import 'package:flavorfleet/src/common%20widgets/my_button.dart';
import 'package:flavorfleet/src/common%20widgets/network_image_box.dart';
import 'package:flavorfleet/src/models/restaurants.dart';
import 'package:provider/provider.dart';
import 'package:flavorfleet/src/common%20widgets/success_snackbar.dart';

import '../models/food.dart';

class FoodPage extends StatefulWidget {
  final Map<AddOn, bool> selectedAddons = {};
  final Food food;

  FoodPage({required this.food, super.key}) {
    for (AddOn addOn in food.availableAddOn) {
      selectedAddons[addOn] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  // method to add to cart
  void addToCart(Food food, Map<AddOn, bool> selectedAddOns) {
    // show snackbar
    final snackbar = successSnackBar(
      context,
      "${food.name} added to cart",
      true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    // if this method is triggered we will go back to the menu page
    Navigator.pop(context);

    // to add selected addons into the item cart
    List<AddOn> currentlySelectedAddOns = [];
    for (AddOn addOn in widget.food.availableAddOn) {
      if (widget.selectedAddons[addOn] == true) {
        currentlySelectedAddOns.add(addOn);
      }
    }

    context.read<Restaurant>().addToCart(food, currentlySelectedAddOns);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food image
                  NetworkImageBox(
                    imageUrl: widget.food.imagePath,
                    height: 500.0,
                    width: double.infinity,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),

                      // food price
                      Text(
                        '₹ ${widget.food.price}',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10.0),

                      // food description
                      Text(
                        widget.food.description,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),

                      const SizedBox(height: 10.0),
                      Divider(color: Theme.of(context).colorScheme.onPrimary),

                      Text(
                        "Add-Ons",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // available addons
                      Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.zero,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddOn.length,
                          itemBuilder: (context, index) {
                            AddOn addon = widget.food.availableAddOn[index];
                            return CheckboxListTile(
                              checkColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                              title: Text(addon.name),
                              subtitle: Text('₹ ${addon.price}'),
                              value: widget.selectedAddons[addon],
                              onChanged: (value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      MyButton(
                        onTap: () =>
                            addToCart(widget.food, widget.selectedAddons),
                        text: "Add to cart",
                      ),
                      const SizedBox(height: 25.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
