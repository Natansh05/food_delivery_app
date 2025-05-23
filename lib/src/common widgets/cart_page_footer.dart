import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_current_location.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
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
              title: Text("Update your delivery address"),
              content: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "Enter your new address",
                ),
              ),
              actions: [
                // cancel button
                MaterialButton(
                  onPressed: () {
                    textEditingController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(" CANCEL "),
                ),

                // save button
                MaterialButton(
                  onPressed: () {
                    String newAdress = textEditingController.text;
                    context.read<UserData>().setUserAddress(newAdress);
                    context.read<Restaurant>().updateDeliveryAdress(newAdress);
                    Navigator.pop(context);
                    textEditingController.clear();
                  },
                  child: const Text(" SAVE "),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          MyCurrentLocation(
            icon: Icon(Icons.home),
          ),
          // Checkout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  // success snackbar
                  SnackBar snackbar = successSnackBar(
                    context,
                    "Order placed successfully",
                    true,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryPage(
                                deliveryFee: 20.0,
                                handlingFee: 4.0,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
