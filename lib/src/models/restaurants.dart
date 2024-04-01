import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/src/models/cart_item.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier{
  final List<Food> _menu = [


    // burgers
    Food(
        availableAddOn: [
          AddOn(name: "Extra Cheddar Cheese", price: 29.0),
          AddOn(name: "Bacon", price: 29.0),
          AddOn(name: "Avocado", price: 39.0),
          AddOn(name: "Sauce", price: 19.0),
        ],
        price: 179.0,
        name: "Classic Tangy Cheese Burger",
        imagePath: "lib/assets/bread/burger.jpeg",
        description:
        "A classic Burger with juicy potato patty with a hard crisp added with a tangy "
            "pickle and cheese slice over it with added onions and mayo to give it a touch ",
        category: FoodCategory.bread),
    Food(
      availableAddOn: [
        AddOn(name: "Extra Cheese", price: 25.0),
        AddOn(name: "Mixed Nuts", price: 20.0),
        AddOn(name: "Mayonnaise", price: 15.0),
        AddOn(name: "Beans Patty", price: 35.0),
      ],
      price: 179.0,
      name: "Veggie Cheese Mayo Burger",
      imagePath: "lib/assets/bread/burger1.jpeg",
      description: "A delicious veggie burger with a hearty patty made from beans and nuts, topped with melted cheese and creamy mayonnaise, served on a toasted bun.",
      category: FoodCategory.bread,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Caramelized Onions", price: 15.0),
        AddOn(name: "Roasted Bell Peppers", price: 20.0),
        AddOn(name: "Chipotle Mayo", price: 25.0),
        AddOn(name: "Lettuce", price: 10.0),
      ],
      price: 169.0,
      name: "Grilled Chicken Sandwich Toast",
      imagePath: "lib/assets/bread/burger2.jpeg",
      description: "Juicy grilled chicken breast served between two slices of toasted bread, topped with caramelized onions, roasted bell peppers, crisp lettuce, and a dollop of chipotle mayo.",
      category: FoodCategory.bread,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Extra Whey Protein", price: 35.0),
        AddOn(name: "Almond Butter", price: 25.0),
        AddOn(name: "Mixed Nuts", price: 20.0),
        AddOn(name: "Honey Drizzle", price: 15.0),
      ],
      price: 149.0,
      name: "Nutty Protein Sandwich",
      imagePath: "lib/assets/bread/burger3.jpeg",
      description: "A power-packed sandwich featuring whole grain bread filled with creamy almond butter, mixed nuts, and an extra boost of whey protein, topped with a drizzle of honey for sweetness.",
      category: FoodCategory.bread,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Potato Wafers", price: 20.0),
        AddOn(name: "Mayonnaise", price: 15.0),
        AddOn(name: "Cheese Dip", price: 25.0),
      ],
      price: 129.0,
      name: "Veg Chilli Cheese Toast",
      imagePath: "lib/assets/bread/burger4.jpeg",
      description: "A delightful combination of crispy toast topped with melted cheese and spicy chili, served with a side of crunchy potato wafers and creamy mayo & cheese dip.",
      category: FoodCategory.bread,
    ),


    // salads
    Food(
      availableAddOn: [
        AddOn(name: "Boiled Egg", price: 25.0),
        AddOn(name: "Cherry Tomatoes", price: 15.0),
        AddOn(name: "Cucumber Slices", price: 20.0),
        AddOn(name: "Toasted Pumpkin Seeds", price: 25.0),
      ],
      price: 120.0,
      name: "Broccoli Salad",
      imagePath: "lib/assets/salads/salad2.jpeg",
      description: "A refreshing salad featuring fresh broccoli florets, cherry tomatoes, red onions, and a tangy vinaigrette dressing.",
      category: FoodCategory.salads,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Extra Broccoli", price: 15.0),
        AddOn(name: "Extra Carrots", price: 10.0),
        AddOn(name: "Extra Cucumber", price: 10.0),
        AddOn(name: "Extra Beetroot", price: 10.0),
        AddOn(name: "Extra Avocado", price: 20.0),
      ],
      price: 130.0,
      name: "Green Veggie Salad",
      imagePath: "lib/assets/salads/salad3.jpeg",
      description: "A nutritious salad bursting with fresh green vegetables including broccoli, carrots, cucumber, beetroot, and creamy avocado, topped with a zesty vinaigrette dressing.",
      category: FoodCategory.salads,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Steamed Tofu", price: 35.0),
        AddOn(name: "Sunflower Seeds", price: 20.0),
        AddOn(name: "Edamame", price: 25.0),
        AddOn(name: "Balsamic Glaze", price: 15.0),
      ],
      price: 150.0,
      name: "BBQ Style Salad",
      imagePath: "lib/assets/salads/salad4.jpeg",
      description: "A flavorful salad with a barbecue twist, featuring juicy tomatoes, fresh ginger, sweet strawberries, and crunchy cabbage, topped with steamed tofu and drizzled with balsamic glaze.",
      category: FoodCategory.salads,
    ),
    Food(
      availableAddOn: [
        AddOn(name: "Spinach Leaves", price: 15.0),
        AddOn(name: "Walnuts", price: 20.0),
        AddOn(name: "Sesame Seeds", price: 15.0),
        AddOn(name: "Lemon Vinaigrette", price: 10.0),
      ],
      price: 140.0,
      name: "Superfood Salad",
      imagePath: "lib/assets/salads/salad5.jpeg",
      description: "A nutrient-packed salad featuring fresh broccoli, creamy avocado, crunchy cauliflower, earthy beetroot, zesty onion, and invigorating ginger, topped with spinach leaves and a sprinkling of walnuts and sesame seeds, dressed with a tangy lemon vinaigrette.",
      category: FoodCategory.salads,
    ),


    // drinks
    Food(
      price: 30.0,
      name: "Milk Tea",
      imagePath: "lib/assets/drinks/chai.jpeg",
      description: "A soothing cup of Indian tea, packed with antioxidants and refreshing flavor.",
      category: FoodCategory.drinks,
      availableAddOn: [
        AddOn(name: "Honey", price: 5.0),
        AddOn(name: "Ginger", price: 5.0),
        AddOn(name: "Mint Leaves", price: 5.0),
      ],
    ),
    Food(
      price: 40.0,
      name: "Cappuccino",
      imagePath: "lib/assets/drinks/cofee.jpeg",
      description: "A classic cappuccino with rich espresso, creamy milk, and frothy foam.",
      category: FoodCategory.drinks,
      availableAddOn: [
        AddOn(name: "Chocolate Powder", price: 5.0),
        AddOn(name: "Caramel Syrup", price: 5.0),
        AddOn(name: "Vanilla Extract", price: 5.0),
      ],
    ),
    Food(
      price: 50.0,
      name: "Fresh Orange Juice",
      imagePath: "lib/assets/drinks/juice.jpeg",
      description: "A refreshing glass of freshly squeezed orange juice, bursting with vitamins.",
      category: FoodCategory.drinks,
      availableAddOn: [
        AddOn(name: "Strawberry Garnish", price: 5.0),
        AddOn(name: "Mint Sprig", price: 5.0),
        AddOn(name: "Pineapple Slice", price: 5.0),
      ],
    ),
    Food(
      price: 100.0,
      name: "Red Wine",
      imagePath: "lib/assets/drinks/wine.jpeg",
      description: "A smooth glass of red wine, perfect for unwinding after a long day.",
      category: FoodCategory.drinks,
      availableAddOn: [
        AddOn(name: "Cheese Platter", price: 20.0),
        AddOn(name: "Crackers", price: 10.0),
        AddOn(name: "Grapes", price: 10.0),
      ],
    ),
    Food(
      price: 25.0,
      name: "Mojito Soda",
      imagePath: "lib/assets/drinks/soda.jpeg",
      description: "A refreshing soda infused with lime, mint, and a hint of sweetness.",
      category: FoodCategory.drinks,
      availableAddOn: [
        AddOn(name: "Lime Wedge", price: 5.0),
        AddOn(name: "Mint Sprig", price: 5.0),
        AddOn(name: "Simple Syrup", price: 5.0),
      ],
    ),


    // paneer
    Food(
      price: 100.0,
      name: "Hyderabadi Biryani",
      imagePath: "lib/assets/paneer/biryani.jpeg",
      description: "Aromatic and flavorful Hyderabadi biryani, made with long-grain basmati rice, tender marinated meat, and a blend of spices.",
      category: FoodCategory.paneer,
      availableAddOn: [
        AddOn(name: "Raita", price: 15.0),
        AddOn(name: "Salan", price: 20.0),
        AddOn(name: "Papad", price: 10.0),
      ],
    ),
    Food(
      price: 90.0,
      name: "Paneer Angara",
      imagePath: "lib/assets/paneer/sabji2.jpeg",
      description: "Paneer cubes marinated in a spicy masala and grilled to perfection, served with grilled vegetables.",
      category: FoodCategory.paneer,
      availableAddOn: [
        AddOn(name: "Naan", price: 15.0),
        AddOn(name: "Mint Chutney", price: 10.0),
        AddOn(name: "Onion Salad", price: 10.0),
      ],
    ),
    Food(
      price: 95.0,
      name: "Paneer Makhanwala",
      imagePath: "lib/assets/paneer/sabji1.jpeg",
      description: "Paneer cubes cooked in a creamy tomato-based gravy with butter and aromatic spices.",
      category: FoodCategory.paneer,
      availableAddOn: [
        AddOn(name: "Jeera Rice", price: 20.0),
        AddOn(name: "Garlic Naan", price: 15.0),
        AddOn(name: "Pickle", price: 5.0),
      ],
    ),


    // desserts
    Food(
      price: 50.0,
      name: "Chocolate Brownie",
      imagePath: "lib/assets/desserts/brownie.jpeg",
      description: "A decadent chocolate brownie, rich and fudgy, perfect for satisfying your sweet cravings.",
      category: FoodCategory.desserts,
      availableAddOn: [
        AddOn(name: "Vanilla Ice Cream Scoop", price: 10.0),
        AddOn(name: "Whipped Cream", price: 5.0),
        AddOn(name: "Chocolate Sauce", price: 5.0),
      ],
    ),
    Food(
      price: 60.0,
      name: "Classic Milkshake",
      imagePath: "lib/assets/desserts/shake.jpeg",
      description: "A creamy and indulgent milkshake made with vanilla ice cream and milk, blended to perfection.",
      category: FoodCategory.desserts,
      availableAddOn: [
        AddOn(name: "Chocolate Syrup", price: 5.0),
        AddOn(name: "Caramel Sauce", price: 5.0),
        AddOn(name: "Whipped Cream", price: 5.0),
      ],
    ),
    Food(
      price: 40.0,
      name: "Gulab Jamun",
      imagePath: "lib/assets/desserts/gulabjambu.jpeg",
      description: "Soft and syrupy gulab jamuns, a classic Indian dessert made with milk solids and sugar syrup.",
      category: FoodCategory.desserts,
      availableAddOn: [
        AddOn(name: "Pistachio Garnish", price: 5.0),
        AddOn(name: "Silver Leaf", price: 5.0),
        AddOn(name: "Saffron Strands", price: 5.0),
      ],
    ),
    Food(
      price: 35.0,
      name: "Glazed Donut",
      imagePath: "lib/assets/desserts/donuts.jpeg",
      description: "A classic glazed donut, fluffy and sweet, perfect with a cup of coffee or tea.",
      category: FoodCategory.desserts,
      availableAddOn: [
        AddOn(name: "Chocolate Drizzle", price: 5.0),
        AddOn(name: "Sprinkles", price: 5.0),
        AddOn(name: "Cinnamon Sugar", price: 5.0),
      ],
    ),
    Food(
      price: 30.0,
      name: "Vanilla Ice Cream",
      imagePath: "lib/assets/desserts/icecream.jpeg",
      description: "Creamy and smooth vanilla ice cream, a timeless classic enjoyed by all.",
      category: FoodCategory.desserts,
      availableAddOn: [
        AddOn(name: "Chocolate Sauce", price: 5.0),
        AddOn(name: "Caramel Syrup", price: 5.0),
        AddOn(name: "Sprinkles", price: 5.0),
      ],
    ),
  ];

  /*
  GETTERS
   */

  List<Food> get menu => _menu;
  // getter to receive the cart
  List<CartItem> get cart=> _cart;
  /*
  OPERATIONS
   */

  // creating a user cart
  List<CartItem> _cart = [];


  // add to cart
  void addToCart(Food food,List<AddOn> selectedAddOns){
    CartItem? cartItem = _cart.firstWhereOrNull((item){
      // check if selected item is the same
      bool isSameFood = item.food==food;

      // check if selected addOns are same
      bool isSameAddons = ListEquality().equals(item.selectedAddOns, selectedAddOns);
      return isSameFood && isSameAddons;
    });

    // if item exists increase the quantity
    if(cartItem!=null){
      cartItem.quantity++;
    }

    // otherwise add another item in the list

    else{
      _cart.add(CartItem(food: food, selectedAddOns: selectedAddOns));
    }
      notifyListeners();
  }


  // remove from cart
  void removeFromCart(CartItem cartItem){
    int cartIndex = _cart.indexOf(cartItem);
    if(cartIndex!=-1){
      if(_cart[cartIndex].quantity>1){
        _cart[cartIndex].quantity--;
      }
      else{
        _cart.remove(cartIndex);
      }
      notifyListeners();
    }
  }


  // see total price of items in cart
  double getTotalPrice(){
    double total = 0.0;
    for(CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;
      for(AddOn addOn in cartItem.selectedAddOns){
        itemTotal+=addOn.price;
      }
      total+=itemTotal;
      notifyListeners();
    }
    return total;
  }


  // get total number of items in cart
  int getTotalItems(){
    int cnt = 0;
    for(CartItem cartItem in _cart){
      cnt+=cartItem.quantity;
    }
    return cnt;
  }


  // clear cart
  void clearCart(){
    _cart.clear();
    notifyListeners();
  }

  /*
  HELPERS
   */

  // generate a receipt


  // format double value into money


  // format list of addons into string summary 




}