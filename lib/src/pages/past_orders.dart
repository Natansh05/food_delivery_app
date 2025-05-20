import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/database/firestore.dart';
import '../../Services/auth/auth_service.dart';
import '../models/order_item.dart'; // Assuming you have an Order model
import 'order_details.dart'; // Import the detailed page

class PastOrdersPage extends StatefulWidget {
  const PastOrdersPage({super.key});

  @override
  State<PastOrdersPage> createState() => _PastOrdersPageState();
}

class _PastOrdersPageState extends State<PastOrdersPage> {
  final _authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O R D E R  H I S T O R Y'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getOrderStream(
            _authService.getCurrentUser()!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No past orders found.'));
          }
          final orders = snapshot.data!.docs.map((doc) {
            return UserOrder.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text(
                    'Order - ${order.time} - \$${order.totalCost.toStringAsFixed(
                        2)}'),
                subtitle: Text('Items: ${order.items} | ${order.date}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: order),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

