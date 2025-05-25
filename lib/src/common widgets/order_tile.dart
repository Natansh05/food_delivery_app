import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  final dynamic total;
  final DateTime date;
  final VoidCallback onTap;

  const OrderTile({
    super.key,
    required this.orderId,
    required this.total,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('MMM d, y – h:mm a').format(date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple.shade100,
          child: const Icon(
            Icons.receipt_long,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          'Date: $formattedDate',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Total: ₹${total.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              'Order #$orderId',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: theme.iconTheme.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
