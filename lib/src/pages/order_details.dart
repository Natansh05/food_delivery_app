import 'package:flutter/material.dart';
import '../models/order_item.dart'; // Import the UserOrder model

class OrderDetailPage extends StatelessWidget {
  final UserOrder order;

  OrderDetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Order ID', '${order.id}', theme),
                _buildDetailRow('Date', '${order.date}', theme),
                _buildDetailRow('Total Cost', '₹${order.totalCost.toStringAsFixed(2)}', theme),
                _buildDetailRow('Payment Mode', '${order.paymentMode}', theme),
                _buildDetailRow('Time of Order', '${order.time}', theme),
                _buildDetailRow('Notes Left', '${order.note}', theme),
                _buildDetailRow('Total No. of Items', '${order.items}', theme),
                _buildDetailRow('Delivery Type', '${order.deliveryType}', theme),
                SizedBox(height: 20),
                _buildSectionTitle('Receipt', theme),
                SizedBox(height: 10),
                _buildReceiptContainer(order.receipt, theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  Widget _buildReceiptContainer(String receipt, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        receipt,
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }
}
