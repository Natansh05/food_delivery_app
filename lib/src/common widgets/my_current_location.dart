import 'package:flutter/material.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  final TextEditingController textEditingController  = TextEditingController();
  void openLocationSearchBox(BuildContext context){
    showDialog(context: context,
        builder: (context)=> AlertDialog(
          title: Text("Your location"),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Enter your adress...",
            ),
          ),
          actions: [
            // cancel button
            MaterialButton(onPressed: () {
                  textEditingController.clear();
                  Navigator.pop(context);
            },
              child: const Text(" CANCEL "),
            ),


            // save button
            MaterialButton(
              onPressed: () {
                String newAdress = textEditingController.text;
                context.read<Restaurant>().updateDeliveryAdress(newAdress);
                Navigator.pop(context);
                textEditingController.clear();
              },
              child: const Text(" SAVE "),
            )


          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
           const Text("Deliver now !!"),
          GestureDetector(
            onTap: ()=> openLocationSearchBox(context),
            child: Row(
              children: [

                Consumer<Restaurant>(builder: (context,restaurant,child)=>
                    Text(restaurant.deliveryAdress,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),),
                ),
                // drop down meny
                const Icon(Icons.arrow_drop_down_sharp),




              ],
            ),
          )
        ],
      ),
    );
  }
}
