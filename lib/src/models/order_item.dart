class UserOrder {
  final String id;
  final String date;
  final double totalCost;
  final String paymentMode;
  final String deliveryType;
  final String receipt;
  final String note;
  final String time;
  final int items;

  UserOrder({
    required this.id,
    required this.date,
    required this.totalCost,
    required this.paymentMode,
    required this.deliveryType,
    required this.receipt,
    required this.note,
    required this.time,
    required this.items,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      name: data['Name'] ?? '',
      quantity: (data['No. of Items'] ?? 0).toInt(),
      price: (data['Total Price'] ?? 0).toDouble(),
    );
  }
}
