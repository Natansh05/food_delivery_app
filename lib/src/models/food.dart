class Food{
  final String id;
  final String name;
  final String description;
  final Category category;
  final String imagePath;
  final double price;
  List<AddOn> availableAddOn;

  Food({
    required this.id,
    required this.availableAddOn,
    required this.price,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.category,
  });

  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imagePath: data['image_url'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      category: Category.fromMap(data['category']),
      availableAddOn: (data['available_addons'] as List<dynamic>?)
              ?.map((addOn) => AddOn.fromMap(addOn))
              .toList() ?? [],
    );
  }
}

class Category{
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }
}



class AddOn{
  String id;
  final String? foodId;
  String name;
  double price;

  AddOn({
    required this.id,
    this.foodId,
    required this.name,
    required this.price,
  });

  factory AddOn.fromMap(Map<String, dynamic> data) {
    return AddOn(
      id: data['id'] ?? '',
      foodId: data['food_id'] ?? '',
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
    );
  }
}