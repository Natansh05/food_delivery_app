import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:myapp/src/models/cart_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'food.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [];
  final List<CartItem> _cart = [];
  final List<Category> _categories = [];
  String _deliveryAdress = 'Not Specified';
  bool _isLoading = false;

  /*
  GETTERS
   */
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  List<Category> get categories => _categories;
  String get deliveryAdress => _deliveryAdress;
  bool get isLoading => _isLoading;


  Restaurant();

  /*
  METHODS
   */

  // Fetch menu from Supabase and populate _menu
  Future<void> fetchCategories() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final List<dynamic> response = await Supabase.instance.client
          .from('categories')
          .select();
      _categories.clear();
      _categories.addAll(response.map((item) => Category.fromMap(item as Map<String, dynamic>)));
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> fetchFoods() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
    try {
      final List<dynamic> response = await Supabase.instance.client
      .from('foods')
      .select('''
        id, name, description, image_url, price,
        category:category_id (id, name),
        available_addons:addons (id, name, price)
      ''');
      _menu.clear();
      _menu.addAll(response.map((item) => Food.fromMap(item as Map<String, dynamic>)));
    } catch (e) {
      debugPrint('Error fetching foods: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update delivery address
  void updateDeliveryAdress(String newAdress) {
    _deliveryAdress = newAdress;
    notifyListeners();
  }

  // Add to cart
  void addToCart(Food food, List<AddOn> selectedAddOns) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons = const ListEquality().equals(item.selectedAddOns, selectedAddOns);
      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddOns: selectedAddOns));
    }
    notifyListeners();
  }

  void updateCart(List<CartItem> newCart) {
    _cart.clear();
    _cart.addAll(newCart);
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Get total price of items in cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (AddOn addOn in cartItem.selectedAddOns) {
        itemTotal += addOn.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // Get total number of items in cart
  int getTotalItems() {
    int count = 0;
    for (CartItem cartItem in _cart) {
      count += cartItem.quantity;
    }
    return count;
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*
  HELPERS
   */

  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt----->\n");

    String formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    String formattedTime = DateFormat.jm().format(DateTime.now());
    receipt.writeln('Date of Order : $formattedDate');
    receipt.writeln('Time Stamp of order : $formattedTime');
    receipt.writeln('Delivering to : $deliveryAdress');
    receipt.writeln('-----------------------------------------');

    for (final cartItem in _cart) {
      receipt.writeln(
          '${cartItem.quantity} x ${cartItem.food.name} : ${_formatPrice(cartItem.food.price)}');
      if (cartItem.selectedAddOns.isNotEmpty) {
        receipt.writeln('Add-Ons :- ${_formatAddons(cartItem.selectedAddOns)}\n');
      }
    }

    receipt.writeln('-----------------------------------------');
    receipt.writeln('Total Price : ${_formatPrice(getTotalPrice())}');
    receipt.writeln('Total Items : ${getTotalItems()}');

    return receipt.toString();
  }

  String _formatPrice(double price) => '₹ ${price.toStringAsFixed(2)}';

  String _formatAddons(List<AddOn> addons) {
    return addons.map((addOn) => ' ${addOn.name} : ${_formatPrice(addOn.price)}').join(", ");
  }
}
