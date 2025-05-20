import 'package:flutter/material.dart';
import 'package:myapp/Services/database/firestore.dart';
import 'package:myapp/src/common%20widgets/my_receipt.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});



  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  FirestoreService db = FirestoreService();
  bool order_saved = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserData>();
    final restaurant = context.watch<Restaurant>();


      double totalCost = restaurant.getTotalPrice();
      int items = restaurant.getTotalItems();
      String userName = userData.userName;
      String userPhone = userData.phoneNum;
      String mode = userData.cash ? "Cash" : "UPI";
      String delivery =
          userData.delivery ? "Order to be delivered" : "Pickup Order";
      String receipt = context.read<Restaurant>().displayCartReceipt();
    if(order_saved == false) {
      db.saveOrderToDatabase(
          receipt, userName, userPhone, totalCost, items, mode, delivery);
      order_saved = true;
    }
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery in progress......'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  color: theme.colorScheme.primary,
                  size: 100,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Thank you for your order!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoRow('Name:', userName, theme),
              _buildInfoRow('Phone:', userPhone, theme),
              _buildInfoRow('Payment Mode:', mode, theme),
              _buildInfoRow('Delivery Type:', delivery, theme),
              _buildInfoRow('Total Items:', items.toString(), theme),
              _buildInfoRow('Total Cost:', '₹${totalCost.toStringAsFixed(2)}', theme),
              SizedBox(height: 20),
              Text(
                'Receipt:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 10),
              MyReceipt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
