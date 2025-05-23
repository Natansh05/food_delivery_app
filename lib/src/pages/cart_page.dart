import 'package:flutter/material.dart';
import 'package:myapp/src/common widgets/bill_details_card.dart';
import 'package:myapp/src/common widgets/cart_page_footer.dart';
import 'package:myapp/src/common widgets/my_cart_tile.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text("C A R T"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            restaurant.clearCart();
                            Navigator.pop(context);
                          },
                          child: const Text("Clear"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),

          body: userCart.isEmpty
              ? const Center(
                  child: Text(
                    "Cart is empty..",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 20, // no extra space needed
                    top: 10,
                  ),
                  children: [
                    ...userCart.map((item) => MyCartTile(cartItem: item)).toList(),
                    const SizedBox(height: 10),
                    BillDetailsCard(
                      itemTotal: restaurant.getTotalPrice(),
                      handlingCharge: 4.0,
                      deliveryCharge: 20.0,
                    ),
                  ],
                ),

          bottomNavigationBar: userCart.isNotEmpty ? CartPageFooter() : null,
        );
      },
    );
  }
}
