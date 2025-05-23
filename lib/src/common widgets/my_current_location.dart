import 'package:flutter/material.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/models/user_data.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatefulWidget {
  final Icon icon;
  const MyCurrentLocation({super.key, this.icon = const Icon(Icons.location_on)});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
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
    final address = Provider.of<UserData>(context).userAddress;
    final userName = Provider.of<UserData>(context).userName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        children: [
          // Location Icon
          Icon(
            widget.icon.icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 10),
          // Address Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivering to:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "$userName, $address",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Change Button
          TextButton(
            onPressed: () {
              openLocationSearchBox(context);
            },
            child: Text(
              "Change",
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
