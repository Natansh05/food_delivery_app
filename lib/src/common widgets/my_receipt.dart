import 'package:flutter/material.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatefulWidget {
  const MyReceipt({super.key});

  @override
  State<MyReceipt> createState() => _MyReceiptState();
}

class _MyReceiptState extends State<MyReceipt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0,right: 25.0,bottom: 25.0,top: 25.0),
      child: Center(
        child: Column(
          children: [
            const Text('Thankyou for placing the order !'),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Consumer<Restaurant>(
                builder: (context,restuarant,child)=>Text(restuarant.displayCartReceipt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
