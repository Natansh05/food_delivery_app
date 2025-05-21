import 'package:flutter/material.dart';

class MyReceipt extends StatelessWidget {
  final String receipt;

  const MyReceipt({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0, top: 25.0),
      child: Center(
        child: Column(
          children: [
            const Text('Thank you for placing the order!'),
            const SizedBox(height: 25.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(receipt),
            ),
          ],
        ),
      ),
    );
  }
}
