import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context){
    showDialog(context: context,
        builder: (context)=> AlertDialog(
          title: Text("Your location"),
          content: const TextField(
            decoration: InputDecoration(
              hintText: "Your Address...",
            ),
          ),
          actions: [
            // cancel button
            MaterialButton(onPressed: ()=> Navigator.pop(context),
              child: const Text(" CANCEL "),
            ),


            // save button
            MaterialButton(
              onPressed: ()=> Navigator.pop(context),
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
                // current adress
                Text(" A - 603 , Tulsi Parkview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),),

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
