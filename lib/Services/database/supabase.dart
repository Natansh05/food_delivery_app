import 'package:flutter/material.dart';
import 'package:FlavorFleet/Services/auth/auth_service.dart';
import 'package:FlavorFleet/src/models/cart_item.dart';
import 'package:FlavorFleet/src/models/food.dart';
import 'package:FlavorFleet/src/models/restaurants.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient supabase = Supabase.instance.client;
  final AuthService authService = AuthService();

  /// Method to place an order
  Future<void> placeOrder(BuildContext context) async {
    final user = authService.getCurrentUser();
    if (user == null) {
      throw Exception('No user logged in');
    }

    final restaurant = Provider.of<Restaurant>(context, listen: false);
    final cartItems = restaurant.cart;
    final bill = restaurant.displayCartReceipt();
    final totalAmount = restaurant.getTotalPrice().toStringAsFixed(2);

    // 1. Insert into orders
    final orderResponse = await supabase.from('orders').insert({
      'user_id': user.id,
      'amount': totalAmount,
      'order_bill': bill,
    }).select('id'); // Get order_id from response

    final orderId = orderResponse.first['id'];

    for (final cartItem in cartItems) {
      final foodItemId = cartItem.food.id; // or just cartItem.id
      final quantity = cartItem.quantity;
      final itemPrice = cartItem.food.price;

      final orderItemResponse = await supabase.from('order_items').insert({
        'order_id': orderId,
        'food_item_id': foodItemId,
        'quantity': quantity,
        'item_price': itemPrice,
      }).select('id');

      final orderItemId = orderItemResponse.first['id'];

      // 3. Insert selected addons (if any)
      for (final addon in cartItem.selectedAddOns) {
        await supabase.from('order_item_addons').insert({
          'order_item_id': orderItemId,
          'addon_id': addon.id,
          'food_item_id': foodItemId,
          'addon_price': addon.price,
        });
      }
    }

    // Optionally: Clear cart
    restaurant.clearCart();
  }

  Future<String?> fetchBill(String orderId) async {
    final response = await supabase
        .from('orders')
        .select('order_bill')
        .eq('id', orderId)
        .single();

    if (response.isEmpty) {
      throw Exception('Order not found');
    }

    return response['order_bill'] as String;
  }

  Future<Food?> fetchFoodById(String foodId) async {
    final List<dynamic> response =
        await Supabase.instance.client.from('foods').select('''
        id, name, description, image_url, price,
        category:category_id (id, name),
        available_addons:addons (id, name, price)
      ''').eq('id', foodId);
    return response.isNotEmpty
        ? Food.fromMap(response.first as Map<String, dynamic>)
        : null;
  }

  Future<List<dynamic>> fetchOrders() async {
    final user = authService.getCurrentUser();
    if (user == null) {
      throw Exception('No user logged in');
    }

    final response = await supabase
        .from('orders')
        .select('id, amount, created_at')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return response;
  }

  Future<List<CartItem>> fetchOrderCartItems(String orderId) async {
    final client = Supabase.instance.client;

    // 1. Fetch order items for the given order
    final orderItemsResponse = await client
        .from('order_items')
        .select('id, food_item_id, quantity')
        .eq('order_id', orderId);

    if (orderItemsResponse.isEmpty) {
      throw Exception('Failed to fetch order items');
    }
    else{
      debugPrint('Fetched order items: ${orderItemsResponse.length} items');
    }

    final orderItemsData = orderItemsResponse as List<dynamic>;
    if (orderItemsData.isEmpty) return [];

    final orderItemIds =
        orderItemsData.map((item) => item['id'] as String).toList();

    final orderAddonsResponse = await client
        .from('order_item_addons')
        .select('order_item_id, addon_id')
        .filter('order_item_id', 'in',
            '(${orderItemIds.map((id) => id).join(',')})');

    if (orderAddonsResponse.isEmpty) {
      throw Exception('Failed to fetch order addons');
    }

    final allAddonsData = orderAddonsResponse as List<dynamic>;

    // Map order_item_id to list of addon_ids
    final Map<String, List<String>> orderItemToAddonIds = {};

    for (final addon in allAddonsData) {
      final orderItemId = addon['order_item_id'] as String;
      final addonId = addon['addon_id'] as String;

      orderItemToAddonIds.putIfAbsent(orderItemId, () => []).add(addonId);
    }

    // 3. Build CartItem list
    List<CartItem> cartItems = [];

    for (final orderItem in orderItemsData) {
      final orderItemId = orderItem['id'] as String;
      final foodId = orderItem['food_item_id'] as String;
      final quantity = orderItem['quantity'] ?? 1;

      // Fetch the food object by ID - implement this function accordingly
      final food = await fetchFoodById(foodId);
      if (food == null) continue;

      final selectedAddOnIds = orderItemToAddonIds[orderItemId] ?? [];

      // Filter addons belonging to this food item
      final selectedAddOns = food.availableAddOn
          .where((addon) => selectedAddOnIds.contains(addon.id))
          .toList();

      cartItems.add(CartItem(
        food: food,
        quantity: quantity,
        selectedAddOns: selectedAddOns,
      ));
    }

    return cartItems;
  }
}
