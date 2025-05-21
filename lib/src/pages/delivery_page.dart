import 'package:flutter/material.dart';
import 'package:myapp/Services/database/firestore.dart';
import 'package:myapp/src/common widgets/my_receipt.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/pages/home_page.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';

class DeliveryPage extends StatefulWidget {
  final double deliveryFee;
  final double handlingFee;

  const DeliveryPage({
    super.key,
    required this.deliveryFee,
    required this.handlingFee,
  });

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final FirestoreService db = FirestoreService();

  late String _receipt;
  late String _userName;
  late String _userPhone;
  late int _items;
  late double _totalCost;
  late double _deliveryFee;
  late double _handlingFee;

  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final userData = context.read<UserData>();
      final restaurant = context.read<Restaurant>();

      // Capture info BEFORE clearing
      double baseTotal = restaurant.getTotalPrice();
      double totalCost = baseTotal + widget.deliveryFee + widget.handlingFee;
      int items = restaurant.getTotalItems();
      String userName = userData.userName;
      String userPhone = userData.phoneNum;
      String receipt = restaurant.displayCartReceipt();

      // Save order to Firestore
      db.saveOrderToDatabase(
        receipt,
        userName,
        userPhone,
        totalCost,
        items,
        "", // payment mode removed
        "", // delivery type removed
      );

      // Store info in state variables
      setState(() {
        _receipt = receipt;
        _userName = userName;
        _userPhone = userPhone;
        _items = items;
        _totalCost = totalCost;
        _deliveryFee = widget.deliveryFee;
        _handlingFee = widget.handlingFee;
        _dataLoaded = true;
      });

      // Clear the cart AFTER storing info
      restaurant.clearCart();

      // Optionally navigate after a delay
      // Future.delayed(const Duration(seconds: 2), () {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => HomePage()),
      //     (route) => false,
      //   );
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!_dataLoaded) {
      // Show a loader while waiting for data
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery in progress...'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: theme.colorScheme.primary,
              size: 100,
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you for your order!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildInfoRow('Name:', _userName, theme),
            _buildInfoRow('Phone:', _userPhone, theme),
            _buildInfoRow('Total Items:', _items.toString(), theme),
            _buildInfoRow('Delivery Fee:', '₹${_deliveryFee.toStringAsFixed(2)}', theme),
            _buildInfoRow('Handling Fee:', '₹${_handlingFee.toStringAsFixed(2)}', theme),
            _buildInfoRow('Total Cost:', '₹${_totalCost.toStringAsFixed(2)}', theme),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Receipt:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyReceipt(receipt: _receipt), // Pass receipt here if MyReceipt supports it
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
