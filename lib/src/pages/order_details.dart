import 'package:flutter/material.dart';
import 'package:myapp/Services/database/supabase.dart';
import 'package:myapp/src/common%20widgets/details_card.dart';
import 'package:myapp/src/common%20widgets/my_receipt.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
import 'package:myapp/src/models/cart_item.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late Future<List<CartItem>> userCartFuture;
  late Future<String?> _receipt;
  late ThemeData theme = Theme.of(context);
  final DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();
    userCartFuture = db.fetchOrderCartItems(widget.orderId);
    _receipt = db.fetchBill(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("O R D E R   D E T A I L S",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            )),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 150.0,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: userCartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userCart = snapshot.data ?? [];

          if (userCart.isEmpty) {
            return const Center(
              child: Text(
                "No items found in this order.",
                style: TextStyle(fontSize: 16.0),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order id : ${widget.orderId}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: theme.colorScheme.primary,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '🍲 Food You Ordered :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...userCart.map((item) => DetailsCard(cartItem: item)),
              const SizedBox(height: 10),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '🧾 Receipt of Your Order :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<String?>(
                future: _receipt,
                builder: (context, receiptSnapshot) {
                  if (receiptSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (receiptSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${receiptSnapshot.error}'));
                  }
                  return Card(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyReceipt(
                          receipt: receiptSnapshot.data ?? "No receipt found"),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Reorder Confirmation"),
                            content: const Text(
                                "Are you sure you want to reorder this food?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Provider.of<Restaurant>(context,
                                          listen: false)
                                      .updateCart(userCart);
                                  final snackbar = successSnackBar(context,
                                      "Food Items Added to your cart", true);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                },
                                child: const Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: const Text(
                      "Reorder this cart  🍽️",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
