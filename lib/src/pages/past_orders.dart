import 'package:flutter/material.dart';
import 'package:myapp/Services/database/supabase.dart';
import 'package:myapp/src/common%20widgets/order_tile.dart';
import 'package:myapp/src/pages/order_details.dart';
import 'package:timezone/timezone.dart' as tz;

class PastOrdersPage extends StatefulWidget {
  const PastOrdersPage({super.key});

  @override
  State<PastOrdersPage> createState() => _PastOrdersPageState();
}

class _PastOrdersPageState extends State<PastOrdersPage> {
  final DatabaseService _databaseService = DatabaseService();

  List<dynamic> pastOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPastOrders();
  }

  void fetchPastOrders() async {
    final orders = await _databaseService.fetchOrders();
    setState(() {
      pastOrders = orders;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O R D E R  H I S T O R Y'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pastOrders.isEmpty
              ? Center(child: Text("No past orders found"))
              : ListView.builder(
                  itemCount: pastOrders.length,
                  itemBuilder: (context, index) {
                    final order = pastOrders[index];
                    final orderId = order['id'];
                    var total = order['amount'];

                    final date = DateTime.parse(order['created_at']);
                    final formattedDate = tz.TZDateTime.from(date, tz.getLocation('Asia/Kolkata'));
                    return OrderTile(
                      orderId: orderId,
                      total: total,
                      date: formattedDate,
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(orderId: orderId),
                          ),
                        ).then((_) {
                          fetchPastOrders();
                        });
                      },
                    );
                  },
                ),
    );
  }
}
