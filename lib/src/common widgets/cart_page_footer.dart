import 'package:flutter/material.dart';
import 'package:myapp/src/common widgets/my_current_location.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/models/user_data.dart';
import 'package:myapp/src/pages/delivery_page.dart';
import 'package:provider/provider.dart';

class CartPageFooter extends StatelessWidget {
  CartPageFooter({super.key});

  final TextEditingController textEditingController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update your delivery address"),
        content: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: "Enter your new address",
          ),
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              textEditingController.clear();
              Navigator.pop(context);
            },
            child: const Text("CANCEL"),
          ),

          // Save button
          TextButton(
            onPressed: () {
              String newAddress = textEditingController.text;
              context.read<UserData>().setUserAddress(newAddress);
              context.read<Restaurant>().updateDeliveryAdress(newAddress);
              Navigator.pop(context);
              textEditingController.clear();
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onTertiary,
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Current address display with location icon
          MyCurrentLocation(icon: Icon(Icons.home)),

          // Checkout button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if(context.read<UserData>().userAddress.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please set your delivery address first."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Order Confirmation"),
                        content: const Text(
                            "Are you sure you want to order this cart ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DeliveryPage(
                                    deliveryFee: 20.0,
                                    handlingFee: 4.0,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
