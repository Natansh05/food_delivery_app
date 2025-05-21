import 'package:flutter/material.dart';

class BillDetailsCard extends StatelessWidget {
  final double itemTotal;
  final double handlingCharge;
  final double deliveryCharge;

  const BillDetailsCard({
    super.key,
    required this.itemTotal,
    required this.handlingCharge,
    required this.deliveryCharge,
  });

  double get grandTotal => itemTotal + handlingCharge + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bill Details",
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildRow("Item Total", itemTotal, theme),
            const SizedBox(height: 8),
            _buildRow("Handling Charges", handlingCharge, theme),
            const SizedBox(height: 8),
            _buildRow("Delivery Charges", deliveryCharge, theme),
            const Divider(height: 24),
            _buildRow("Grand Total", grandTotal, theme, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, double value, ThemeData theme, {bool isBold = false}) {
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text("₹${value.toStringAsFixed(2)}", style: textStyle),
      ],
    );
  }
}
