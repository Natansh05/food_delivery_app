class Food{
  final String name;
  final String description;
  final FoodCategory category;
  final String imagePath;
  final double price;
  List<AddOn> availableAddOn;

  Food({
    required this.availableAddOn,
    required this.price,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.category,
});
}

enum FoodCategory{
  bread,
  salads,
  paneer,
  desserts,
  drinks,
}


class AddOn{
  String name;
  double price;

  AddOn({
    required this.name,
    required this.price,
});
}