import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});




  @override
  Widget build(BuildContext context) {

    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );

    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
    );

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // delivery fee
          Column(
            children: [
              Text('1000/- Rs',
              style: myPrimaryTextStyle,),
              Text("Delivery Fee",style: mySecondaryTextStyle,),
            ],
          ),

          //delivery time
          Column(
            children: [
              Text("15-30 mins",
              style: myPrimaryTextStyle,),
              Text("Delivery time",
              style: mySecondaryTextStyle,),
            ],
          ),
        ],
      ),
    );
  }
}
