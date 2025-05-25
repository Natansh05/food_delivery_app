// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:myapp/Services/database/supabase.dart';
import 'package:myapp/src/common widgets/my_receipt.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
import 'package:myapp/src/models/restaurants.dart';
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
  final DatabaseService db = DatabaseService();

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

      double baseTotal = restaurant.getTotalPrice();
      double totalCost = baseTotal + widget.deliveryFee + widget.handlingFee;
      int items = restaurant.getTotalItems();
      String userName = userData.userName;
      String userPhone = userData.phoneNum;
      String receipt = restaurant.displayCartReceipt();

      // Save order to Supabase
      db.placeOrder(context).then((_) {
        final snackbar =
            successSnackBar(context, "Your Order was received succesfully $userName", true);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }).catchError((error) {
        final snackbar = successSnackBar(
            context, "Failed to place order: $error", false);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });

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
        title: const Text('Delivery in progress...',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 150.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you for placing the order!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildInfoRow('Name:', _userName, theme),
            _buildInfoRow('Phone:', _userPhone, theme),
            _buildInfoRow('Total Items:', _items.toString(), theme),
            _buildInfoRow(
                'Delivery Fee:', '₹${_deliveryFee.toStringAsFixed(2)}', theme),
            _buildInfoRow(
                'Handling Fee:', '₹${_handlingFee.toStringAsFixed(2)}', theme),
            _buildInfoRow(
                'Total Cost:', '₹${_totalCost.toStringAsFixed(2)}', theme),
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
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyReceipt(
                    receipt:
                        _receipt), // Pass receipt here if MyReceipt supports it
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
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
