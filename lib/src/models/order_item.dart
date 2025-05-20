import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory UserOrder.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserOrder(
      id: doc.id,
      date: data['Date'] ?? '',
      totalCost: (data['Total Price'] ?? 0).toDouble(),
      paymentMode: data['Mode of Payment'] ?? 'Unknown',
      deliveryType: data['Delivery Status'] ?? 'Unknown',
      receipt: data['Order'] ?? 'Unknown',
      time: data['Time'] ?? 'Unknown',
      note: data['Note'] ?? 'No notes were left',
      items:  (data['No. of Items'] ?? 0).toInt(),
    );
  }
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
