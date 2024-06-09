import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_receipt.dart';
import 'package:myapp/src/pages/payment_page.dart' as file;

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery in progress......'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: MyReceipt()),
    );
  }
}
