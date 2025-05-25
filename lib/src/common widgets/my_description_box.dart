import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});




  @override
  Widget build(BuildContext context) {

    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    );

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // delivery fee
          Column(
            children: [
              Text('20/- Rs',
              style: mySecondaryTextStyle,),
              Text("Delivery Fee",style: mySecondaryTextStyle,),
            ],
          ),

          //delivery time
          Column(
            children: [
              Text("15-30 mins",
              style: mySecondaryTextStyle,),
              Text("Delivery time",
              style: mySecondaryTextStyle,),
            ],
          ),
        ],
      ),
    );
  }
}
